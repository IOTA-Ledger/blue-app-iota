#include "ui.h"
#include <string.h>
#include "os_io_seproxyhal.h"
#include "nanos/nanos_types.h"
#include "nanos/nanos_misc.h"
#include "nanos/nanos_buttons.h"
#include "nanos/nanos_display.h"
#include "nanos/nanos_elements.h"
#include "nanos/nanos_screens.h"
#include "nanos/nanos_core.h"
#include "api.h"
#include "iota/addresses.h"
#include "blue/blue_screens.h"

#define TICKS_PER_SECOND 10

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
#else
    nanos_ui_init();
#endif
}

// Entry points for main to modify display
void ui_display_main_menu()
{
#ifdef TARGET_BLUE
#else
    nanos_display_main_menu();
#endif
}

void ui_display_getting_addr()
{
#ifdef TARGET_BLUE
#else
    nanos_display_getting_addr();
#endif
}

void ui_display_validating()
{
#ifdef TARGET_BLUE
#else
    nanos_display_validating();
#endif
}

void ui_display_recv()
{
#ifdef TARGET_BLUE
#else
    nanos_display_recv();
#endif
}

void ui_display_signing()
{
#ifdef TARGET_BLUE
#else
    nanos_display_signing();
#endif
}

void ui_display_address(const unsigned char *addr_bytes)
{
#ifdef TARGET_BLUE
#else
    nanos_display_address(addr_bytes);
#endif
}

void ui_sign_tx()
{
#ifdef TARGET_BLUE
#else
    nanos_sign_tx();
#endif
}

void ui_reset()
{
#ifdef TARGET_BLUE
#else
    nanos_ui_reset();
#endif
}

void ui_restore()
{
#ifdef TARGET_BLUE
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
    // forbid app from locking during transaction (rely on tx timeout)
    switch (ui_state.state) {
            // BIP Path could be in tx or disp_addr
            // (backup state will tell us which)
        case STATE_BIP_PATH:
            if (ui_state.backup_state != STATE_PROMPT_TX)
                return false;
        case STATE_PROMPT_TX:
        case STATE_TX_ADDR:
            return true;
        default:
            return false;
    }
}
