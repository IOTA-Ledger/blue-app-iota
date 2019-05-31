#include <stdbool.h>
#include <stddef.h>
#include "bagl.h"
#include "iota/iota_types.h"
#include "macros.h"
#include "os.h"
#include "os_io_seproxyhal.h"
#include "ui/nano/nano_buttons.h"
#include "ui/nano/nano_draw.h"
#include "ui/nano/nano_misc.h"
#include "ui/nano/nano_types.h"
#include "ui/ui.h"

#if defined(TARGET_NANOS) || defined(TARGET_NANOX)
#include "ui/nano/nano_screens.h"

#ifdef TARGET_NANOS
#else
#include "ui/nano/x_elements.h"
#endif // TARGET_NANOS

static void nano_transition_state(unsigned int button_mask);

UI_TEXT_CTX_NANO ui_text;
UI_STATE_CTX_NANO ui_state;

/// Check whether the draw flag for the given element is set.
static bool check_element_flag(UI_ELEMENTS_NANO element)
{
    if (element >= NUM_UI_ELEMENTS) {
        THROW_PARAMETER("element");
    }

    return ui_state.flags.elements & (1U << element);
}

static const bagl_element_t *element_preprocessor(const bagl_element_t *element)
{
    // return the element as is, if it is enabled
    if (check_element_flag(element->component.userid)) {
        return element;
    }

    return NULL;
}

static unsigned int
bagl_ui_omega_screen_button(unsigned int button_mask,
                            unsigned int button_mask_counter)
{
    UNUSED(button_mask_counter);

    nano_transition_state(button_mask);
    return 0;
}

static void nano_display(void)
{
    UX_DISPLAY(bagl_ui_omega_screen, element_preprocessor);
}

static void nano_draw_state(void)
{
    switch (ui_state.state) {
    case STATE_MAIN_MENU:
        nano_draw_main_menu();
        break;

    case STATE_ABOUT:
        nano_draw_about();
        break;

#ifdef TARGET_NANOS
    case STATE_VERSION:
        nano_draw_version();
        break;

    case STATE_MORE_INFO:
        nano_draw_more_info();
        break;
#endif

    case STATE_BIP_PATH:
        nano_draw_bip_path();
        break;

    case STATE_BUNDLE_ADDR:
        nano_draw_bundle_addr();
        break;

    case STATE_ADDRESS_FULL:
        nano_draw_address_full();
        break;

    case STATE_ADDRESS_DIGEST:
        nano_draw_address_digest();
        break;

    case STATE_BUNDLE:
        nano_draw_bundle();
        break;

    case STATE_IGNORE:
        return;

    default:
        THROW_PARAMETER("state");
    }
}

static void set_and_draw_state(UI_STATES_NANO state)
{
    nano_state_set(state, 0);
    nano_draw_state();
}

void ui_init()
{
    MEMCLEAR(ui_text);
    MEMCLEAR(ui_state);

    ui_display_main_menu();
}

// Entry points for main to modify display
void ui_display_main_menu()
{
    set_and_draw_state(STATE_MAIN_MENU);
    nano_state_backup();

    nano_display();
}

void ui_display_getting_addr()
{
    nano_state_set_ignore();
    nano_draw_getting_addr();

    nano_display();
    ui_force_draw();
}

void ui_display_validating()
{
    nano_state_set_ignore();
    nano_draw_validating();

    nano_display();
    ui_force_draw();
}

void ui_display_recv()
{
    nano_state_set_ignore();
    nano_draw_receiving();

    nano_display();
    ui_force_draw();
}

void ui_display_signing()
{
    nano_state_set_ignore();
    nano_draw_signing();

    nano_display();
    ui_force_draw();
}

void ui_display_address(const unsigned char *addr_bytes)
{
    // write the address trytes into the UI state
    os_memcpy(ui_state.buffer.addr_bytes, addr_bytes, NUM_HASH_TRYTES);

    set_and_draw_state(STATE_ADDRESS_DIGEST);
    nano_display();
    ui_force_draw();
}

void ui_sign_tx()
{
    set_and_draw_state(STATE_BUNDLE);
    nano_display();
}

void ui_reset()
{
    set_and_draw_state(STATE_MAIN_MENU);
    nano_display();
    ui_force_draw();
}

void ui_restore()
{
    nano_state_restore();
    nano_draw_state();

    nano_display();
    ui_force_draw();
}

static UI_BUTTON_PRESS translate_button_mask(const unsigned int button_mask)
{
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        return BUTTON_L;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        return BUTTON_R;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT | BUTTON_LEFT:
        return BUTTON_B;
    default:
        return BUTTON_BAD;
    }
}

static void nano_handle_button(const UI_BUTTON_PRESS button_press)
{
    int array_sz;

    switch (ui_state.state) {
    case STATE_MAIN_MENU:
        array_sz = button_main_menu(button_press);
        break;

    case STATE_ABOUT:
        array_sz = button_about(button_press);
        break;

#ifdef TARGET_NANOS
    case STATE_VERSION:
        button_version(button_press);
        return;

    case STATE_MORE_INFO:
        array_sz = button_more_info(button_press);
        break;
#endif

    case STATE_BIP_PATH:
        array_sz = button_bip_path(button_press);
        break;

    case STATE_ADDRESS_FULL:
        array_sz = button_address_full(button_press);
        break;

    case STATE_ADDRESS_DIGEST:
        button_address_digest(button_press);
        return;

    case STATE_BUNDLE_ADDR:
        array_sz = button_bundle_addr(button_press);
        break;

    case STATE_BUNDLE:
        button_bundle(button_press);
        return;

    case STATE_IGNORE:
        return;

    default:
        THROW_PARAMETER("state");
    }

    // incr or decr ui_state.menu_idx
    if (array_sz >= 0) {
        if (button_press == BUTTON_L) {
            ui_state.menu_idx = MAX(0, ui_state.menu_idx - 1);
        }
        else if (button_press == BUTTON_R) {
            ui_state.menu_idx = MIN(array_sz, ui_state.menu_idx + 1);
        }
    }
}

static void nano_transition_state(unsigned int button_mask)
{
    const UI_BUTTON_PRESS button_press = translate_button_mask(button_mask);
    // make sure we only transition on valid button presses
    if (button_press == BUTTON_BAD) {
        return;
    }

    nano_handle_button(button_press);
    if (ui_state.state == STATE_EXIT) {
        // Go back to the dashboard
        os_sched_exit(0);
    }

    // display the new state
    nano_draw_state();
    nano_display();
}

#endif
