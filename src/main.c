#include "main.h"
#include "ui.h"
#include "iota_io.h"

// use internalStorage_t to temp hold the storage
typedef struct internalStorage_t {
    uint8_t initialized;
    uint32_t account_seed[5];
    uint8_t advanced_mode;
    uint8_t browser_mode;

} internalStorage_t;

// N_storage_real will hold the actual address for NVRAM
WIDE internalStorage_t N_storage_real;
#define N_storage (*(WIDE internalStorage_t *)PIC(&N_storage_real))

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];
ux_state_t ux;

uint8_t get_advanced_mode()
{
    return N_storage.advanced_mode;
}

uint8_t get_browser_mode()
{
    return N_storage.browser_mode;
}

void write_advanced_mode(uint8_t mode)
{
    // something must have gone wrong to receive a mode > 1
    if (mode > 1) {
        os_sched_exit(0);
        return;
    }

    // only write if mode is different
    if (mode != N_storage.advanced_mode)
        nvm_write(&N_storage.advanced_mode, (void *)&mode, sizeof(uint8_t));
}

void write_browser_mode(uint8_t mode)
{
    // something must have gone wrong to receive a mode > 1
    if (mode > 1) {
        os_sched_exit(0);
        return;
    }

    // only write if mode is different
    if (mode != N_storage.browser_mode)
        nvm_write(&N_storage.browser_mode, (void *)&mode, sizeof(uint8_t));
}

bool flash_is_init()
{
    return N_storage.initialized == 0x01;
}

void init_flash()
{
    internalStorage_t storage;

    storage.initialized = 0x01;
    os_memset(storage.account_seed, 0, sizeof(uint32_t) * 5);
    storage.account_seed[0] = 0;
    storage.account_seed[1] = 4;
    storage.account_seed[2] = 9;
    storage.account_seed[3] = 22;
    storage.account_seed[4] = 762;
    storage.advanced_mode = 0;
    storage.browser_mode = 0;

    nvm_write(&N_storage, (void *)&storage, sizeof(internalStorage_t));
}

void incr_seed_idx(unsigned int account)
{
    // can't keep track of indexes in advanced mode
    if(get_advanced_mode())
        return;
    
    uint32_t seed_idx = N_storage.account_seed[account];
    seed_idx++;
    
    nvm_write(&N_storage.account_seed[account], (void *)&seed_idx, sizeof(uint32_t));
}
uint32_t get_seed_idx(unsigned int account)
{
    return N_storage.account_seed[account];
}

void write_seed_index(unsigned int account, const unsigned int seed_idx)
{
    nvm_write(&N_storage.account_seed[account],
              (void *)&seed_idx, sizeof(uint32_t));
}

static void IOTA_main()
{
    volatile unsigned int flags = 0;

    ui_init(flash_is_init());
    // init the API
    io_initialize();

    for (;;) {
        BEGIN_TRY
        {
            TRY
            {
                // data is always sent separatly
                const unsigned int rx = io_exchange(CHANNEL_APDU | flags, 0);

                // check header consistency
                if (rx < OFFSET_P3 ||
                    rx < G_io_apdu_buffer[OFFSET_P3] + OFFSET_P3) {
                    THROW(SW_INCORRECT_LENGTH_P3);
                }
                flags = iota_dispatch();
            }
            CATCH_OTHER(e)
            {
                unsigned short sw;

                switch (e & 0xF000) {
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = SW_UNKNOWN | (e & 0x0FF);
                }

                // send  response code and reset ui
                // TODO: what happens if io_send throws an exception
                io_send(NULL, 0, sw);
                ui_restore();
                flags = 0;
            }
            FINALLY
            {
            }
        }
        END_TRY;
    }
}


/* ------------------------------------------------
 ---------------------------------------------------
 ---------------------------------------------------
 ------------------- Not Modified ------------------
 --------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len)
{
    switch (channel & ~(IO_FLAGS)) {
    case CHANNEL_KEYBOARD:
        break;

        // multiplexed io exchange over a SPI channel and TLV encapsulated
        // protocol
    case CHANNEL_SPI:
        if (tx_len) {
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);

            if (channel & IO_RESET_AFTER_REPLIED) {
                reset();
            }
            return 0; // nothing received from the master so far (it's a tx
            // transaction)
        }
        else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element)
{
    io_seproxyhal_display_default((bagl_element_t *)element);
}

unsigned char io_event(unsigned char channel)
{
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        }
        else {
            UX_DISPLAYED_EVENT();
        }
        break;

        // unknown events are acknowledged
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_general_status();
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

__attribute__((section(".boot"))) int main(void)
{
    // exit critical section
    __asm volatile("cpsie i");

    UX_INIT();

    // ensure exception will work as planned
    os_boot();

    BEGIN_TRY
    {
        TRY
        {
            io_seproxyhal_init();

#ifdef LISTEN_BLE
            if (os_seph_features() &
                SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_BLE) {
                BLE_power(0, NULL);
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
            USB_power(1);

            IOTA_main();
        }
        CATCH_OTHER(e)
        {
        }
        FINALLY
        {
        }
    }
    END_TRY;
}
