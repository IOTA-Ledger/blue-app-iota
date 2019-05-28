#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "api.h"
#include "iota_io.h"
#include "macros.h"
#include "os.h"
#include "os_apilevel.h"
#include "os_io_seproxyhal.h"
#include "seproxyhal_protocol.h"
#include "ui/ui.h"

// define global SDK variables
unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

#ifdef TARGET_NANOX
#include "ux.h"

ux_state_t G_ux;
bolos_ux_params_t G_ux_params;
#else  // NANOS/BLUE
ux_state_t ux;
#endif // TARGET_NANOX

// APDU header present in every input
typedef IO_STRUCT APDU_HEADER
{
    uint8_t cla;
    uint8_t ins;
    uint8_t p1;
    uint8_t p2;
    uint8_t p3;
}
APDU_HEADER;

/// Returns true, if the device is not locked
static bool device_is_unlocked(void)
{
#if CX_APILEVEL >= 9
    return os_global_pin_is_validated() == BOLOS_UX_OK;
#else
    return os_global_pin_is_validated();
#endif
}

static void IOTA_main()
{
    volatile unsigned int flags = 0;

    ui_init();
    io_initialize();

    // Exchange APDUs until EXCEPTION_IO_RESET is thrown
    for (;;) {
        BEGIN_TRY
        {
            TRY
            {
                // data is always sent separatly
                const unsigned int rx = io_exchange(CHANNEL_APDU | flags, 0);

                // when no APDU received, trigger a reset
                if (rx == 0) {
                    THROW(EXCEPTION_IO_RESET);
                }

                // the device must not be locked
                VALIDATE(device_is_unlocked(), SW_DEVICE_IS_LOCKED);

                // check header validity
                VALIDATE(rx >= sizeof(APDU_HEADER), SW_INCORRECT_LENGTH);

                const APDU_HEADER *header = (APDU_HEADER *)G_io_apdu_buffer;
                VALIDATE(header->cla == CLA, SW_CLA_NOT_SUPPORTED);
                VALIDATE(rx == header->p3 + sizeof(APDU_HEADER),
                         SW_INCORRECT_LENGTH_P3);

                unsigned char *data = G_io_apdu_buffer + sizeof(APDU_HEADER);

                // handle iota apdu commands
                flags = iota_dispatch(header->ins, header->p1, header->p2,
                                      header->p3, data);
            }
            CATCH(EXCEPTION_IO_RESET)
            {
                THROW(EXCEPTION_IO_RESET);
            }
            CATCH_OTHER(e)
            {
                unsigned short sw;

                // SW_OK must not be thrown
                if (e == SW_OK) {
                    sw = INVALID_STATE;
                }
                // expected errors start with 0x6
                if ((e & 0xF000) == 0x6000) {
                    sw = e;
                }
                else {
                    sw = SW_UNKNOWN | (e & 0x0FF);
                }

                switch (sw) {
                case SW_DEVICE_IS_LOCKED:
                case SW_CLA_NOT_SUPPORTED:
                    // do not reset anything
                    break;
                default:
                    // reset states and UI
                    api_initialize();
                    ui_reset();
                    io_timeout_reset();
                }

                // send the error code
                io_send(NULL, 0, sw);

                flags = 0;
            }
            FINALLY
            {
            }
        }
        END_TRY;
    }
}

// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len)
{
    switch (channel & ~(IO_FLAGS)) {
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);

            if (channel & IO_RESET_AFTER_REPLIED) {
                reset();
            }
            // nothing received from the master so far (it's a tx transaction)
            return 0;
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
        UX_DISPLAYED_EVENT({});
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer,
                        { io_timeout_callback(UX_ALLOWED); });
        break;

    default:
        UX_DEFAULT_EVENT();
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_general_status();
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

static void app_exit(void)
{
    BEGIN_TRY_L(exit)
    {
        TRY_L(exit)
        {
            os_sched_exit(-1);
        }
        FINALLY_L(exit)
        {
        }
    }
    END_TRY_L(exit);
}

__attribute__((section(".boot"))) int main(void)
{
    // exit critical section
    __asm volatile("cpsie i");

    // ensure exception will work as planned
    os_boot();

    for (;;) {
        UX_INIT();

        BEGIN_TRY
        {
            TRY
            {
                io_seproxyhal_init();

                // deactivate usb before activating
                USB_power(false);
                USB_power(true);

#ifdef HAVE_BLE
                BLE_power(false, NULL);
                BLE_power(true, "Nano X");
#endif // HAVE_BLE

                IOTA_main();
            }
            CATCH(EXCEPTION_IO_RESET)
            {
                // reset IO and UX
                continue;
            }
            CATCH_ALL
            {
                // exit on all other exceptions
                break;
            }
            FINALLY
            {
            }
        }
        END_TRY;
    }
    app_exit();
}
