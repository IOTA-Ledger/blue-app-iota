#include "os.h"
#include "os_io_seproxyhal.h"
#include "nanox_screens.h"
#include "nanox_elements.h"
#include "nanox_types.h"
#include "glyphs.h"
#include "ui.h"
#include "iota/addresses.h"

#ifdef TARGET_NANOX

UI_STATE_CTX_NANOX nanox_ui_state;
UI_TEXT_CTX_NANOX nanox_ui_text;
static void nanox_transition_state(unsigned int button_mask);


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

const ux_flow_step_t *get_flow_step(UI_STATES_NANOX s, uint8_t i)
{
    switch (s) {
    case STATE_MAIN:
        switch (i) {
        case 1:
            return &ux_main_flow_1_step;
        case 2:
            return &ux_main_flow_2_step;
            /*case 3:
             return &ux_main_flow_3_step;
             case 4:
             return &ux_main_flow_4_step;
             case 5:
             return &ux_main_flow_5_step;
             case 6:
             return &ux_main_flow_6_step;
             case 7:
             return &ux_main_flow_7_step;
             case 8:
             return &ux_main_flow_8_step;
             case 9:
             return &ux_main_flow_9_step;
             case 10:
             return &ux_main_flow_10_step;*/
        default:
        case 0:
            return &ux_main_flow_0_step;
        }
    default:
        return NULL;
    }
}

BUTTON_FUNCTION(title)

// screen for title on top, info on bottom
static const bagl_element_t bagl_ui_title_screen[] = {SCREEN_CLEAR,
                                                      SCREEN_MSG_TOP};

void display_about_x()
{
    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_about_flow, NULL);
    // UX_DISPLAY(bagl_ui_title_screen, NULL);
}

void return_main_menu()
{
    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    int i = 1;
    ux_flow_init(0, ux_main_flow, get_flow_step(STATE_MAIN, i));
}

// Entry points for main to modify display
void ui_display_main_menu()
{
    // snprintf(nanox_ui_text.mid_str, 21, "%s", "Welcome IOTA");
    // UX_DISPLAY(bagl_ui_title_screen, NULL);

    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_main_flow, NULL);

    nanox_ui_state.state = STATE_MAIN;
    nanox_ui_state.menu_idx = 0;
}

void ui_display_getting_addr()
{
    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_getting_addr_flow, NULL);

    ui_force_draw();
}

void ui_display_validating()
{
    // reserve a display stack slot if none yet
    if (G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_main_flow, NULL);

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
        ux_flow_init(0, ux_main_flow, NULL);

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
        ux_flow_init(0, ux_main_flow, NULL);

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
    ux_flow_init(0, ux_main_flow, NULL);

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
    ux_flow_init(0, ux_tx_flow, NULL);

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
        ux_flow_init(0, ux_main_flow, NULL);
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

static void nanox_transition_state(unsigned int button_mask)
{
    return;
}

#endif // TARGET_NANOX
