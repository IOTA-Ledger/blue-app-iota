#include "ui/nano/nano_buttons.h"
#include <stdbool.h>
#include <stdint.h>
#include "api.h"
#include "iota_io.h"
#include "macros.h"
#include "ui/nano/nano_misc.h"
#include "os.h"

int button_main_menu(const UI_BUTTON_PRESS button_press)
{
    if (button_press == BUTTON_B) {
        switch (ui_state.menu_idx) {
        case MENU_MAIN_IOTA:
            nano_state_set(STATE_EXIT, 0);
            return -1;

        case MENU_MAIN_ABOUT:
            nano_state_set(STATE_ABOUT, 0);
            return -1;

        case MENU_MAIN_EXIT:
            nano_state_set(STATE_EXIT, 0);
            return -1;

        default:
            THROW_PARAMETER("menu_idx");
        }
    }

    return MENU_MAIN_LEN - 1;
}

int button_about(const UI_BUTTON_PRESS button_press)
{
    if (button_press == BUTTON_B) {
        switch (ui_state.menu_idx) {
#ifdef TARGET_NANOS
        case MENU_ABOUT_VERSION:
            nano_state_set(STATE_VERSION, 0);
            return -1;

        case MENU_ABOUT_MORE_INFO:
            nano_state_set(STATE_MORE_INFO, 0);
            return -1;
#else
        case MENU_ABOUT_VERSION:
        case MENU_ABOUT_MORE_INFO:
            // ignore
            break;
#endif
        case MENU_ABOUT_BACK:
            nano_state_set(STATE_MAIN_MENU, MENU_MAIN_ABOUT);
            return -1;

        default:
            THROW_PARAMETER("menu_idx");
        }
    }

    return MENU_ABOUT_LEN - 1;
}

#ifdef TARGET_NANOS
void button_version(const UI_BUTTON_PRESS button_press)
{
    if (button_press == BUTTON_B) {
        // return to About -> Version
        nano_state_set(STATE_ABOUT, MENU_ABOUT_VERSION);
    }
}

int button_more_info(const UI_BUTTON_PRESS button_press)
{
    if (button_press == BUTTON_B) {
        // return to About -> More Info
        nano_state_set(STATE_ABOUT, MENU_ABOUT_MORE_INFO);
        return -1;
    }

    return MENU_MORE_INFO_LEN - 1;
}
#endif

int button_bip_path(const UI_BUTTON_PRESS button_press)
{
    if (button_press == BUTTON_L && ui_state.menu_idx == 0) {
        // we came from tx
        if (ui_state.nano_state_backup == STATE_BUNDLE) {
            nano_state_set(STATE_BUNDLE_ADDR, MENU_ADDR_LAST);
            return -1;
        }
        else { // we came from disp_addr
            nano_state_set(STATE_ADDRESS_FULL, MENU_ADDR_LAST);
            return -1;
        }
    }
    if (button_press == BUTTON_B) {
        nano_state_restore();
        return -1;
    }

    return MENU_BIP_LAST;
}

int button_address_full(const UI_BUTTON_PRESS button_press)
{
    if (button_press == BUTTON_L && ui_state.menu_idx == 0) {
        nano_state_set(STATE_ADDRESS_DIGEST, 0);
        return -1;
    }
    if (button_press == BUTTON_R && ui_state.menu_idx == MENU_ADDR_LAST) {
        nano_state_set(STATE_BIP_PATH, 0);
        return -1;
    }
    if (button_press == BUTTON_B) {
        nano_state_restore();
        return -1;
    }

    return MENU_ADDR_LAST;
}

void button_address_digest(const UI_BUTTON_PRESS button_press)
{
    if (button_press == BUTTON_R) {
        nano_state_set(STATE_ADDRESS_FULL, 0);
    }
    else if (button_press == BUTTON_B) {
        nano_state_restore();
    }
}

int button_bundle_addr(const UI_BUTTON_PRESS button_press)
{
    // If the backup menu idx is 1, it's the output addr so don't go to bip path
    if (button_press == BUTTON_R && ui_state.menu_idx == MENU_ADDR_LAST &&
        !(ui_state.nano_state_backup == STATE_BUNDLE &&
          ui_state.backup_menu_idx == 1)) {
        nano_state_set(STATE_BIP_PATH, 0);
        return -1;
    }
    if (button_press == BUTTON_B) {
        nano_state_restore();
        return -1;
    }

    return MENU_ADDR_LAST;
}

static void button_bundle_double_press(const uint8_t menu_bundle_len)
{
    // can't use switch statement because array sz isn't known
    if (ui_state.menu_idx == MENU_TX_DENY) {
        ui_state.flags.full_value = false;
        // let exception handling reset ui/api
        PRINTF("user_deny_tx\n");
        THROW(SW_DENIED_BY_USER);
    }

    if (ui_state.menu_idx == MENU_TX_APPROVE) {
        ui_state.flags.full_value = false;
        user_sign_tx();
        return;
    }

    // all other options alternate between val/addr
    if (ui_state.menu_idx % 2 == 0) {
        // toggle full value
        if (ui_state.flags.toggle_value) {
            ui_state.flags.full_value = !ui_state.flags.full_value;
        }
    }
    else {
        // on an address screen
        nano_state_backup();
        nano_state_set(STATE_BUNDLE_ADDR, 0);
    }
}

void button_bundle(const UI_BUTTON_PRESS button_press)
{
    const uint8_t menu_bundle_len = get_menu_bundle_len();

    switch (button_press) {
    case BUTTON_R:
        // loop back to 0 after last entry (deny)
        if (ui_state.menu_idx == MENU_TX_DENY) {
            ui_state.menu_idx = 0;
        }
        else {
            ui_state.menu_idx++;
        }
        break;

    case BUTTON_L:
        // if this is very first tx, left goes to last option (deny)
        if (ui_state.menu_idx == 0) {
            ui_state.menu_idx = MENU_TX_DENY;
        }
        else {
            ui_state.menu_idx--;
        }
        break;

    case BUTTON_B:
        button_bundle_double_press(menu_bundle_len);
        break;

    default:
        THROW_PARAMETER("button_press");
    }
}
