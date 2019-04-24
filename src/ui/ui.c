#include "ui.h"
#include <string.h>
#include "os_io_seproxyhal.h"
#include "api.h"
#include "iota/addresses.h"

#define TICKS_PER_SECOND 10

// Seconds until UI timeout if expected inputs are not received
#define UI_TIMEOUT_SECONDS 3
#define UI_TIMEOUT_INTERACTIVE_SECONDS 100

static uint16_t timer;

void ui_force_draw()
{
#ifndef TARGET_NANOX
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
