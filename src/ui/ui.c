#include "ui.h"
#include <string.h>
#include "os_io_seproxyhal.h"
#include "api.h"
#include "iota/addresses.h"

#ifdef TARGET_BLUE
#include "blue/blue_types.h"
#include "blue/blue_core.h"
#else
#include "nanos/nanos_types.h"
#include "nanos/nanos_core.h"
#endif // TARGET_BLUE

#define TICKS_PER_SECOND 10

// Seconds until UI timeout if expected inputs are not received
#define UI_TIMEOUT_SECONDS 3
#define UI_TIMEOUT_INTERACTIVE_SECONDS 80

static uint16_t timer;

void ui_force_draw()
{
    bool ux_done = false;
    while (!ux_done) {
        io_seproxyhal_general_status();
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,
                               sizeof(G_io_seproxyhal_spi_buffer), 0);

        // manually handle events
        switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (UX_DISPLAYED()) {
                ux_done = true;
                break;
            }
            else {
                UX_DISPLAYED_EVENT();
            }
            break;
        default:
            // ignore any other event
            break;
        }
    }

    // now everything is in the buffer, the next general status renders it
    io_seproxyhal_general_status();
    io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,
                           sizeof(G_io_seproxyhal_spi_buffer), 0);
}

void ui_init()
{
#ifdef TARGET_BLUE
    blue_ui_init();
#else
    nanos_ui_init();
#endif
}

// Entry points for main to modify display
void ui_display_main_menu()
{
#ifdef TARGET_BLUE
    blue_display_main_menu();
#else
    nanos_display_main_menu();
#endif
}

void ui_display_getting_addr()
{
#ifdef TARGET_BLUE
    blue_display_getting_addr();
#else
    nanos_display_getting_addr();
#endif
}

void ui_display_validating()
{
#ifdef TARGET_BLUE
    blue_display_validating();
#else
    nanos_display_validating();
#endif
}

void ui_display_recv()
{
#ifdef TARGET_BLUE
    blue_display_recv();
#else
    nanos_display_recv();
#endif
}

void ui_display_signing()
{
#ifdef TARGET_BLUE
    blue_display_signing();
#else
    nanos_display_signing();
#endif
}

void ui_display_address(const unsigned char *addr_bytes)
{
#ifdef TARGET_BLUE
    blue_display_address(addr_bytes);
#else
    nanos_display_address(addr_bytes);
#endif
}

void ui_sign_tx()
{
#ifdef TARGET_BLUE
    blue_sign_tx();
#else
    nanos_sign_tx();
#endif
}

void ui_reset()
{
#ifdef TARGET_BLUE
    blue_ui_reset();
#else
    nanos_ui_reset();
#endif
}

void ui_restore()
{
#ifdef TARGET_BLUE
    blue_ui_restore();
#else
    nanos_ui_restore();
#endif
}

void ui_timeout_tick()
{
    // timer not started
    if (timer <= 0) {
        return;
    }

    timer--;
    if (timer == 0) {
        // throw an exception so that a result is always returned
        THROW(SW_COMMAND_TIMEOUT);
    }
}

void ui_timeout_start(bool interactive)
{
    if (interactive) {
        timer = UI_TIMEOUT_INTERACTIVE_SECONDS * TICKS_PER_SECOND;
    }
    else {
        timer = UI_TIMEOUT_SECONDS * TICKS_PER_SECOND;
    }
}

void ui_timeout_stop()
{
    timer = 0;
}

bool ui_lock_forbidden(void)
{
#ifdef TARGET_BLUE
    return blue_ui_lock_forbidden();
#else
    return nanos_ui_lock_forbidden();
#endif
}
