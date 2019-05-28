#include "ui/blue/blue_buttons.h"
#include <stddef.h>
#include "api.h"
#include "iota_io.h"
#include "os.h"
#include "os_io_seproxyhal.h"
#include "ui/blue/blue_misc.h"
#include "ui/blue/blue_screens.h"
#include "ui/blue/blue_types.h"
#include "ui/ui.h"

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
    ui_display_main_menu();
    return NULL;
}

const bagl_element_t *button_tx_next(const bagl_element_t *e)
{
    if (second_last_tx()) {
        blue_ui_state.menu_idx++;
        update_tx_info();
        UX_DISPLAY(bagl_ui_transaction_last, NULL);
    }
    else {
        blue_ui_state.menu_idx++;
        update_tx_info();
        UX_DISPLAY(bagl_ui_transaction, NULL);
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

#define BLUE_BUTTON_PROTOTYPE(name)                                            \
    unsigned int bagl_ui_##name##_button(unsigned int button_mask,             \
                                         unsigned int button_mask_counter)     \
    {                                                                          \
        return 0;                                                              \
    }

BLUE_BUTTON_PROTOTYPE(main)
BLUE_BUTTON_PROTOTYPE(settings)
BLUE_BUTTON_PROTOTYPE(disp_addr)
BLUE_BUTTON_PROTOTYPE(transaction_first)
BLUE_BUTTON_PROTOTYPE(transaction)
BLUE_BUTTON_PROTOTYPE(transaction_last)
BLUE_BUTTON_PROTOTYPE(generating_addr)
BLUE_BUTTON_PROTOTYPE(validating)
BLUE_BUTTON_PROTOTYPE(receiving_tx)
BLUE_BUTTON_PROTOTYPE(signing_tx)
