#include "ui/nano/nano_draw.h"
#include <stdbool.h>
#include <stdint.h>
#include "api.h"
#include "iota/addresses.h"
#include "iota/bundle.h"
#include "iota/iota_types.h"
#include "macros.h"
#include "os.h"
#include "ui/nano/nano_misc.h"
#include "ui/nano/nano_types.h"
#include "ui/ui_common.h"

void nano_draw_main_menu()
{
#ifdef TARGET_NANOS
    nano_draw_screen(SCREEN_MENU);
#else
    nano_draw_screen(SCREEN_ICON);
#endif

    switch (ui_state.menu_idx) {
#ifdef TARGET_NANOS
    case MENU_MAIN_IOTA:
        nano_draw_text("IOTA", MID);
        NANO_DRAW_ELEMENTS(EL_IOTA, EL_DOWN, EL_CONFIRM);
        break;

    case MENU_MAIN_ABOUT:
        nano_draw_text("About", MID);
        NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN, EL_CONFIRM);
        break;

    case MENU_MAIN_EXIT:
        nano_draw_text("Exit App", MID);
        NANO_DRAW_ELEMENTS(EL_UP, EL_DASH, EL_CONFIRM);
        break;
#else
    case MENU_MAIN_IOTA:
        nano_draw_text("IOTA", MID);
        NANO_DRAW_ELEMENTS(EL_IOTA);
        break;

    case MENU_MAIN_ABOUT:
        nano_draw_text("About", MID);
        NANO_DRAW_ELEMENTS(EL_INFO, EL_UP, EL_DOWN);
        break;

    case MENU_MAIN_EXIT:
        nano_draw_text("Exit App", MID);
        NANO_DRAW_ELEMENTS(EL_UP, EL_DASH);
        break;
#endif
    default:
        THROW_PARAMETER("menu_idx");
    }
}

void nano_draw_about()
{
#ifdef TARGET_NANOS
    nano_draw_screen(SCREEN_MENU);

    // display the menu
    switch (ui_state.menu_idx) {
    case MENU_ABOUT_VERSION:
        nano_draw_text("Version", MID);
        NANO_DRAW_ELEMENTS(EL_DOWN, EL_CONFIRM);
        break;

    case MENU_ABOUT_MORE_INFO:
        nano_draw_text("More Info", MID);
        NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN, EL_CONFIRM);
        break;

    case MENU_ABOUT_BACK:
        nano_draw_text("Back", MID);
        NANO_DRAW_ELEMENTS(EL_UP, EL_BACK, EL_CONFIRM);
        break;
    default:
        THROW_PARAMETER("menu_idx");
    }
#else
    nano_draw_screen(SCREEN_TITLE);

    // display the menu
    switch (ui_state.menu_idx) {
    case MENU_ABOUT_VERSION:
        nano_draw_text("Version", TOP);
        nano_draw_text(APPVERSION, BOT);
        NANO_DRAW_ELEMENTS(EL_DOWN);
        break;

    case MENU_ABOUT_MORE_INFO:
        nano_draw_text("More Info:", TOP);
        nano_draw_text("iota.org/sec", BOT);
        NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN);
        break;

    case MENU_ABOUT_BACK:
        nano_draw_screen(SCREEN_ICON);
        nano_draw_text("Back", MID);
        NANO_DRAW_ELEMENTS(EL_UP, EL_BACK);
        break;
    default:
        THROW_PARAMETER("menu_idx");
    }
#endif
}

#ifdef TARGET_NANOS
void nano_draw_version()
{
    nano_draw_screen(SCREEN_MENU);

    nano_draw_text(APPVERSION, MID);
    NANO_DRAW_ELEMENTS(EL_BACK, EL_CONFIRM);
}
#endif // TARGET_NANOS

#ifdef TARGET_NANOS
void nano_draw_more_info()
{
    nano_draw_screen(SCREEN_MENU);

    nano_draw_menu_text(MENU_MORE_INFO_TEXT, MENU_MORE_INFO_LEN);
    NANO_DRAW_ELEMENTS(EL_CONFIRM);
}
#endif // TARGET_NANOS

void nano_draw_getting_addr()
{
    nano_draw_screen(SCREEN_ICON_MULTI);

    nano_draw_text("Generating", TOP);
    nano_draw_text("Address...", BOT);
    NANO_DRAW_ELEMENTS(EL_LOAD);
}

void nano_draw_validating()
{
    nano_draw_screen(SCREEN_ICON);

    nano_draw_text("Validating...", MID);
    NANO_DRAW_ELEMENTS(EL_LOAD);
}

void nano_draw_receiving()
{
    nano_draw_screen(SCREEN_ICON_MULTI);

    nano_draw_text("Receiving", TOP);
    nano_draw_text("Transaction...", BOT);
    NANO_DRAW_ELEMENTS(EL_LOAD);
}

void nano_draw_signing()
{
    nano_draw_screen(SCREEN_ICON_MULTI);

    nano_draw_text("Signing", TOP);
    nano_draw_text("Transaction...", BOT);
    NANO_DRAW_ELEMENTS(EL_LOAD);
}

static void nano_draw_bip_path_string(void)
{
    char text[2][TEXT_LEN];
    format_bip_path(&api, text);

#ifdef TARGET_NANOS
    nano_draw_screen(SCREEN_TITLE);

    nano_draw_text(text[0], TOP);
    nano_draw_text(text[1], BOT);
    NANO_DRAW_ELEMENTS(EL_UP, EL_CONFIRM);
#else
    nano_draw_screen(SCREEN_BIP);

    nano_draw_text("BIP32 Path:", TOP);
    nano_draw_text(text[0], MID);
    nano_draw_text(text[1], BOT);
    NANO_DRAW_ELEMENTS(EL_UP);
#endif
}

void nano_draw_bip_path()
{
#ifdef TARGET_NANOS
    switch (ui_state.menu_idx) {
    case 0:
        nano_draw_screen(SCREEN_MENU);

        nano_draw_text("BIP32 Path:", MID);
        NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN, EL_CONFIRM);
        break;

    case 1:
        nano_draw_bip_path_string();
        break;

    default:
        THROW_PARAMETER("menu_idx");
    }
#else
    // display the path directly
    nano_draw_bip_path_string();
#endif
}

void nano_draw_address_full()
{
#ifdef TARGET_NANOS
    nano_draw_screen(SCREEN_MENU);
    NANO_DRAW_ELEMENTS(EL_CONFIRM);
#else
    nano_draw_screen(SCREEN_ADDR);
#endif

    // convert address to trytes
    char addr[NUM_ADDRESS_TRYTES];
    get_address_with_checksum(ui_state.buffer.addr_bytes, addr);

    char text[MENU_ADDR_LEN][TEXT_LEN];
    format_address_full(addr, text);
    nano_draw_menu_text(text, MENU_ADDR_LEN);

    // if DISP_ADDR then above is actually checksum screen
    if (ui_state.menu_idx == 0 && ui_state.state == STATE_ADDRESS_FULL) {
        NANO_DRAW_ELEMENTS(EL_UP);
    }

    // add down arrow to show bip path, don't show
    // bip path on output addr of a tx
    if (ui_state.menu_idx == MENU_ADDR_LAST &&
        !(ui_state.nano_state_backup == STATE_BUNDLE &&
          ui_state.backup_menu_idx == 1)) {
        NANO_DRAW_ELEMENTS(EL_DOWN);
    }
}

void nano_draw_address_digest()
{
    nano_draw_screen(SCREEN_TITLE);

    char addr[NUM_ADDRESS_TRYTES];
    get_address_with_checksum(ui_state.buffer.addr_bytes, addr);

    format_address_abbrev(addr, nano_get_text_buffer(TOP));
    format_address_checksum(addr, nano_get_text_buffer(BOT));

    // draw an up button only when we are in the bundle screen
    if (ui_state.state == STATE_BUNDLE) {
        NANO_DRAW_ELEMENTS(EL_UP);
    }
#ifdef TARGET_NANOS
    NANO_DRAW_ELEMENTS(EL_DOWN, EL_CONFIRM);
#else
    NANO_DRAW_ELEMENTS(EL_DOWN);
#endif
}

void nano_draw_bundle_addr()
{
    // piggyback off identical display
    nano_draw_address_full();
}

static void nano_draw_bundle_approve(void)
{
#ifdef TARGET_NANOS
    nano_draw_screen(SCREEN_MENU);
    nano_draw_text("Approve", MID);
    NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN, EL_CONFIRM);
#else
    nano_draw_screen(SCREEN_ICON);
    nano_draw_text("Approve", MID);
    NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN, EL_CHECK);
#endif
}

static void nano_draw_bundle_deny(void)
{
#ifdef TARGET_NANOS
    nano_draw_screen(SCREEN_MENU);
    nano_draw_text("Deny", MID);
    NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN, EL_CONFIRM);
#else
    nano_draw_screen(SCREEN_ICON);
    nano_draw_text("Deny", MID);
    NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN, EL_CROSS);
#endif
}

static void nano_draw_bundle_address(void)
{
    // buffer the address of the current transaction
    const unsigned char *addr_bytes =
        bundle_get_address_bytes(&api.ctx.bundle, ui_state_get_tx_index());
    os_memcpy(ui_state.buffer.addr_bytes, addr_bytes, NUM_HASH_BYTES);

    nano_draw_address_digest();
}

static void nano_draw_bundle_value(void)
{
    nano_draw_screen(SCREEN_TITLE);

    const unsigned int tx_index = ui_state_get_tx_index();
    int64_t val = api.ctx.bundle.bundle.values[tx_index];

    // display the title line on the top

    // the forth last entry is the value of change tx
    if (ui_state.menu_idx == get_menu_bundle_len() - 4) {
        // write the last index along with "change"
        const uint32_t idx =
            api.ctx.bundle.bundle.indices[api.ctx.bundle.bundle.last_tx_index];
        snprintf(nano_get_text_buffer(TOP), TEXT_LEN, "Change: [%u]", idx);
    }
    // input tx
    else if (val < 0) {
        // write the currentindex along with "input"
        const uint32_t idx = api.ctx.bundle.bundle.indices[tx_index];
        snprintf(nano_get_text_buffer(TOP), TEXT_LEN, "Input: [%u]", idx);
    }
    // outgoing tx
    else {
        nano_draw_text("Output:", TOP);
    }

    // display the value on the bottom
    format_value(val, nano_get_text_buffer(BOT));

    // mark, if readable form is possible
    if (ABS(val) >= 1000) {
        ui_state.flags.toggle_value = true;
#ifdef TARGET_NANOS
        NANO_DRAW_ELEMENTS(EL_CONFIRM);
#endif
    }
    NANO_DRAW_ELEMENTS(EL_UP, EL_DOWN);
}

void nano_draw_bundle()
{
    const uint8_t menu_bundle_len = get_menu_bundle_len();

    // the default is that the entry cannot be toggled
    ui_state.flags.toggle_value = false;

    // the second last menu entry is "approve"
    if (ui_state.menu_idx == menu_bundle_len - 2) {
        nano_draw_bundle_approve();
        return;
    }
    // the last menu entry is "deny"
    if (ui_state.menu_idx == menu_bundle_len - 1) {
        nano_draw_bundle_deny();
        return;
    }
    // before that, even indices will be amounts, odd will be address
    if (ui_state.menu_idx % 2 == 0) {
        nano_draw_bundle_value();
    }
    else {
        nano_draw_bundle_address();
    }
}
