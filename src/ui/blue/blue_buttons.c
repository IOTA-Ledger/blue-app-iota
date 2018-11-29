#include "blue_buttons.h"
#include "blue_screens.h"
#include "blue_types.h"
#include "blue_core.h"
#include "blue_misc.h"
#include "glyphs.h"
#include "os.h"

#include "os_io_seproxyhal.h"

#define NUM_TX 3
#define SECOND_LAST_TX NUM_TX - 2

const bagl_element_t *bagl_ui_SETTINGS_blue_button(const bagl_element_t *e)
{
    UX_DISPLAY(bagl_ui_settings, NULL);
    blue_ui_state.state = STATE_SETTINGS;
    return NULL;
}

const bagl_element_t *bagl_ui_DASHBOARD_blue_button(const bagl_element_t *e)
{
    os_sched_exit(0);
    return NULL;
}

const bagl_element_t *bagl_ui_LEFT_blue_button(const bagl_element_t *e)
{
    blue_display_main_menu();
    return NULL;
}

// TODO remove this button
const bagl_element_t *button_tx(const bagl_element_t *e)
{
    blue_sign_tx();
    return NULL;
}

const bagl_element_t *button_tx_next(const bagl_element_t *e)
{
    if (blue_ui_state.menu_idx < SECOND_LAST_TX) {
        blue_ui_state.menu_idx++;
        update_tx_info();
        UX_DISPLAY(bagl_ui_transaction, NULL);
    }
    else {
        blue_ui_state.menu_idx++;
        update_tx_info();
        UX_DISPLAY(bagl_ui_transaction_last, NULL);
    }
    return NULL;
}

const bagl_element_t *button_tx_prev(const bagl_element_t *e)
{
    if (blue_ui_state.menu_idx > 1) {
        blue_ui_state.menu_idx--;
        update_tx_info();
        UX_DISPLAY(bagl_ui_transaction, NULL);
    }
    else {
        blue_ui_state.menu_idx--;
        update_tx_info();
        UX_DISPLAY(bagl_ui_transaction_first, NULL);
    }
    return NULL;
}

const bagl_element_t *button_deny(const bagl_element_t *e)
{
    THROW(SW_DENIED_BY_USER);
    return NULL;
}

const bagl_element_t *button_approve(const bagl_element_t *e)
{
    user_sign_tx();
    return NULL;
}

// TODO remove
const bagl_element_t *button_tmp(const bagl_element_t *e)
{
    UX_DISPLAY(bagl_ui_signing_tx, NULL);
    return NULL;
}

#define BLUE_BUTTON_PROTOTYPE(name)                                            \
    unsigned int bagl_ui_##name##_button(unsigned int button_mask,             \
                                         unsigned int button_mask_counter)     \
    {                                                                          \
        return 0;                                                              \
    }

BLUE_BUTTON_PROTOTYPE(main)
BLUE_BUTTON_PROTOTYPE(settings)
BLUE_BUTTON_PROTOTYPE(transaction_first)
BLUE_BUTTON_PROTOTYPE(transaction)
BLUE_BUTTON_PROTOTYPE(transaction_last)
BLUE_BUTTON_PROTOTYPE(generating_addr)
BLUE_BUTTON_PROTOTYPE(validating)
BLUE_BUTTON_PROTOTYPE(receiving_tx)
BLUE_BUTTON_PROTOTYPE(signing_tx)
