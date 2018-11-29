#ifndef BLUE_SCREENS_H
#define BLUE_SCREENS_H

#include "blue_elements.h"
#include "blue_buttons.h"
#include "blue_types.h"
#include "api.h"
#include "glyphs.h"

static const bagl_element_t bagl_ui_main[] = {
    BG_FILL,
    HEADER_TEXT("IOTA"),
    HEADER_BUTTON_L(SETTINGS),
    HEADER_BUTTON_R(DASHBOARD),
    BODY_IOTA_ICON,
    BODY_TITLE(OPEN_TITLE),
    TEXT_CENTERED(310, OPEN_MESSAGE1),
    TEXT_CENTERED(332, OPEN_MESSAGE2)};

static const bagl_element_t bagl_ui_settings[] = {
    BG_FILL,
    HEADER_TEXT("Settings"),
    HEADER_BUTTON_L(LEFT),
    TEXT_LEFT_TITLE(105, "Version"),
    TEXT_LEFT(125, APPVERSION),
    TEXT_LEFT_TITLE(180, "More Info"),
    TEXT_LEFT(200, MORE_INFO_TXT)};

static const bagl_element_t bagl_ui_disp_addr[] = {
    BG_FILL,
    HEADER_TEXT("Confirm Address"),
    HEADER_BUTTON_L(LEFT),
    TEXT_LEFT_TITLE_LG(160, "Address:"),
    TEXT_LEFT(180, &blue_ui_state.addr[CHUNK1]),
    TEXT_LEFT(200, &blue_ui_state.addr[CHUNK2]),
    TEXT_LEFT(220, &blue_ui_state.addr[CHUNK3]),
    TEXT_CHK(240, &blue_ui_state.addr[CHUNK_CHK])};

static const bagl_element_t bagl_ui_transaction_first[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),
    TEXT_LEFT_TITLE_LG(105, blue_ui_state.tx_type),
    TEXT_RIGHT(105, blue_ui_state.abbrv_val),
    TEXT_CENTERED(125, blue_ui_state.full_val),
    TEXT_LEFT_TITLE_LG(160, "Address:"),
    TEXT_LEFT(180, &blue_ui_state.addr[CHUNK1]),
    TEXT_LEFT(200, &blue_ui_state.addr[CHUNK2]),
    TEXT_LEFT(220, &blue_ui_state.addr[CHUNK3]),
    TEXT_CHK(240, &blue_ui_state.addr[CHUNK_CHK]),
    BLUE_UI_BUTTON(COLOUR_GREY, "Next", 170, 360, button_tx_next)};

static const bagl_element_t bagl_ui_transaction[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),
    TEXT_LEFT_TITLE_LG(105, blue_ui_state.tx_type),
    TEXT_RIGHT(105, blue_ui_state.abbrv_val),
    TEXT_CENTERED(125, blue_ui_state.full_val),
    TEXT_LEFT_TITLE_LG(160, "Address:"),
    TEXT_LEFT(180, &blue_ui_state.addr[CHUNK1]),
    TEXT_LEFT(200, &blue_ui_state.addr[CHUNK2]),
    TEXT_LEFT(220, &blue_ui_state.addr[CHUNK3]),
    TEXT_CHK(240, &blue_ui_state.addr[CHUNK_CHK]),
    TEXT_LEFT_TITLE(275, "BIP32 Path:"),
    TEXT_LEFT(295, blue_ui_state.bip32_path),
    BLUE_UI_BUTTON(COLOUR_DARK_GREY, "Previous", 30, 360, button_tx_prev),
    BLUE_UI_BUTTON(COLOUR_GREY, "Next", 170, 360, button_tx_next)};

static const bagl_element_t bagl_ui_transaction_last[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),
    TEXT_LEFT_TITLE_LG(105, blue_ui_state.tx_type),
    TEXT_RIGHT(105, blue_ui_state.abbrv_val),
    TEXT_CENTERED(125, blue_ui_state.full_val),
    TEXT_LEFT_TITLE_LG(160, "Address:"),
    TEXT_LEFT(180, &blue_ui_state.addr[CHUNK1]),
    TEXT_LEFT(200, &blue_ui_state.addr[CHUNK2]),
    TEXT_LEFT(220, &blue_ui_state.addr[CHUNK3]),
    TEXT_CHK(240, &blue_ui_state.addr[CHUNK_CHK]),
    TEXT_LEFT_TITLE(275, "BIP32 Path:"),
    TEXT_LEFT(295, blue_ui_state.bip32_path),
    BLUE_UI_BUTTON(COLOUR_DARK_GREY, "Previous", 30, 360, button_tx_prev),
    BLUE_UI_BUTTON(COLOUR_RED, "Deny", 30, 410, button_deny),
    BLUE_UI_BUTTON(COLOUR_GREEN, "Approve", 170, 410, button_approve)};

static const bagl_element_t bagl_ui_generating_addr[] = {
    BG_FILL, HEADER_TEXT("Generating Address"),
    BODY_TITLE("Generating Address...")};

static const bagl_element_t bagl_ui_validating[] = {
    BG_FILL, HEADER_TEXT("Validating"), BODY_TITLE("Validating...")};

static const bagl_element_t bagl_ui_receiving_tx[] = {
    BG_FILL, HEADER_TEXT("Receiving Transaction"),
    BODY_TITLE("Receiving Transaction...")};

static const bagl_element_t bagl_ui_signing_tx[] = {
    BG_FILL, HEADER_TEXT("Signing Transaction"),
    BODY_TITLE("Signing Transaction...")};

#endif // BLUE_SCREENS_H
