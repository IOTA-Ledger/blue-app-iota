#include "main.h"
#include "ui.h"
#include "api.h"

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

bool init_flash()
{
    // not initialized
    if (N_storage.initialized != 0x01) {
        internalStorage_t storage;

        storage.initialized = 0x01;
        memset(storage.account_seed, 0, sizeof(uint32_t) * 5);
        storage.account_seed[0] = 1;
        storage.account_seed[1] = 4;
        storage.account_seed[2] = 9;
        storage.account_seed[3] = 22;
        storage.account_seed[4] = 762;
        storage.advanced_mode = 0;
        storage.browser_mode = 0;

        nvm_write(&N_storage, (void *)&storage, sizeof(internalStorage_t));

        return true;
    }

    return false;
}

uint32_t get_seed_idx(unsigned int idx)
{
    return N_storage.account_seed[idx];
}

/** @brief This is called by the API to transfer data while ignoring responses.
 *  This function must be called exactly onece from withing each api command.
 */
void apdu_send(const void *ptr, unsigned int length)
{
    if (length > IO_APDU_BUFFER_SIZE) {
        THROW(INVALID_PARAMETER);
    }

    os_memcpy(G_io_apdu_buffer, ptr, length);
    G_io_apdu_buffer[length++] = 0x90;
    G_io_apdu_buffer[length++] = 0x00;

    // just send, the response is handled in the main loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, length);
}

static void IOTA_main()
{
    volatile unsigned int rx = 0;
    volatile unsigned int tx = 0;
    volatile unsigned int flags = 0;

    // init the UI and flash (and if first run use that on ui_init())
    ui_init(init_flash());
    // init the APDU api
    api_initialize();

    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY
        {
            TRY
            {
                rx = tx;
                // ensure no race in catch_other if io_exchange throws an error
                tx = 0;

                rx = io_exchange(CHANNEL_APDU | flags, rx);

                // flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0)
                    THROW(0x6982);

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA)
                    THROW(0x6E00);

                const unsigned int len =
                    G_io_apdu_buffer[APDU_BODY_LENGTH_OFFSET];
                if (rx < len + APDU_HEADER_LENGTH) {
                    THROW(INVALID_STATE);
                }
                unsigned char *input_data =
                    G_io_apdu_buffer + APDU_HEADER_LENGTH;

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {

                case INS_SET_SEED:
                    flags = api_set_seed(input_data, len);
                    break;

                case INS_PUBKEY:
                    flags = api_pubkey(input_data, len);
                    break;

                case INS_TX:
                    flags = api_tx(input_data, len);
                    break;

                case INS_SIGN:
                    flags = api_sign(input_data, len);
                    break;

                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                    // unknown command ??
                default:
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e)
            {
                // ui_reset();

                switch (e & 0xF000) {
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY
            {
            }
        }
        END_TRY;
    }

return_to_dashboard:
    return;
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
