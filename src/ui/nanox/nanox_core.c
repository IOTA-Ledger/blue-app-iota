#include "os.h"
#include "os_io_seproxyhal.h"
#include "nanox_screens.h"
#include "nanox_types.h"
#include "glyphs.h"
#include "ui.h"
#include "iota/addresses.h"

#ifdef TARGET_NANOX

UI_STATE_CTX_NANOX nanox_ui_state;

#define NANOX_DRAW(flow)                                                       \
    if (G_ux.stack_count == 0) {                                               \
        ux_stack_push();                                                       \
    }                                                                          \
    ux_flow_init(0, flow, NULL);

static void nanox_ctx_initialize()
{
    MEMCLEAR(nanox_ui_state);
}

void ui_init()
{
    nanox_ctx_initialize();
    ui_timeout_stop();

    ui_display_main_menu();
}

// Entry points for main to modify display
void ui_display_main_menu()
{
    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_idle_flow, NULL);

    nanox_ui_state.state = STATE_MAIN;
    nanox_ui_state.menu_idx = 0;
}

void ui_display_getting_addr()
{
    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_idle_flow, NULL);

    ui_force_draw();
}

void ui_display_validating()
{
    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_idle_flow, NULL);

    ui_force_draw();
}

void ui_display_recv()
{
    if (nanox_ui_state.state != STATE_RECV) {
        nanox_ui_state.state = STATE_RECV;

        // reserve a display stack slot if none yet
        if (G_ux.stack_count == 0) {
            ux_stack_push();
        }
        ux_flow_init(0, ux_idle_flow, NULL);

        ui_force_draw();
    }
}

void ui_display_signing()
{
    if (nanox_ui_state.state != STATE_SIGN) {
        nanox_ui_state.state = STATE_SIGN;

        // reserve a display stack slot if none yet
        if (G_ux.stack_count == 0) {
            ux_stack_push();
        }
        ux_flow_init(0, ux_idle_flow, NULL);

        ui_force_draw();
    }
}

void ui_display_address(const unsigned char *addr_bytes)
{
    // get_address_with_checksum(addr_bytes, nanox_ui_state.addr);
    // break_address();

    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_idle_flow, NULL);

    ui_force_draw();
}

void ui_sign_tx()
{
    // write_bip_path();
    // update_tx_info();

    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_idle_flow, NULL);

    nanox_ui_state.state = STATE_TX;
    nanox_ui_state.menu_idx = 0;
}

void ui_reset()
{
    ui_display_main_menu();
    ui_force_draw();
}

void ui_restore()
{
    // ui gets reset on seed_seed (if seed has changed)
    switch (nanox_ui_state.state) {
    // if they were in settings, take them there
    // everything else go to main menu
    case STATE_SETTINGS:
        // reserve a display stack slot if none yet
        if (G_ux.stack_count == 0) {
            ux_stack_push();
        }
        ux_flow_init(0, ux_idle_flow, NULL);
        break;
    default:
        ui_display_main_menu();
        break;
    }
    ui_force_draw();
}

bool ui_lock_forbidden()
{
    if (nanox_ui_state.state == STATE_TX)
        return true;
    else
        return false;
}

#endif // TARGET_NANOX
