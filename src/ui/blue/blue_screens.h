#ifndef BLUE_SCREENS_H
#define BLUE_SCREENS_H

#include "ui/blue/blue_elements.h"
#include "ui/blue/blue_buttons.h"
#include "ui/blue/blue_types.h"
#include "api.h"
#include "glyphs.h"

static const bagl_element_t bagl_ui_main[] = {
    BG_FILL,
    HEADER_TEXT("IOTA"),
    HEADER_BUTTON_L(SETTINGS),
    HEADER_BUTTON_R(DASHBOARD),

    BODY_IOTA_ICON,
    TEXT_CENTER(OPEN_TITLE, _Y(270), COLOUR_BLACK, FONT_L),
    TEXT_CENTER(OPEN_MESSAGE1, _Y(310), COLOUR_BLACK, FONT_S),
    TEXT_CENTER(OPEN_MESSAGE2, _Y(330), COLOUR_BLACK, FONT_S),
    TEXT_CENTER(OPEN_MESSAGE3, _Y(450), COLOUR_GREY, FONT_XS)};

static const bagl_element_t bagl_ui_settings[] = {
    BG_FILL,
    HEADER_TEXT("Settings"),
    HEADER_BUTTON_L(LEFT),

    TEXT_LEFT("Version", _Y(335), COLOUR_BLACK, FONT_M),
    TEXT_LEFT_TAB(APPVERSION, _Y(355), COLOUR_BLACK, FONT_S),
    TEXT_LEFT("More Info", _Y(390), COLOUR_BLACK, FONT_M),
    TEXT_LEFT_TAB(MORE_INFO_TXT, _Y(410), COLOUR_BLACK, FONT_S),

    TEXT_CENTER(SETTINGS_FOOTER1, _Y(442), COLOUR_GREY, FONT_XS),
    TEXT_CENTER(SETTINGS_FOOTER2, _Y(458), COLOUR_GREY, FONT_XS)};

static const bagl_element_t bagl_ui_disp_addr[] = {
    BG_FILL,
    HEADER_TEXT("Confirm Address"),
    HEADER_BUTTON_L(LEFT),

    TEXT_LEFT("Address:", _Y(160), COLOUR_BLACK, FONT_L),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK1], _Y(180), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK2], _Y(200), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK3], _Y(220), COLOUR_BLACK, FONT_S),
    TEXT_CENTER(&blue_ui_state.addr[CHUNK_CHK], _Y(240), COLOUR_SKYBLUE,
                FONT_S)};

static const bagl_element_t bagl_ui_transaction_first[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),

    TEXT_LEFT(blue_ui_state.tx_type, _Y(105), COLOUR_BLACK, FONT_L),
    TEXT_RIGHT(blue_ui_state.abbrv_val, _Y(105), COLOUR_BLACK, FONT_L),
    TEXT_RIGHT(blue_ui_state.full_val, _Y(125), COLOUR_BLACK, FONT_S),

    TEXT_LEFT("Address:", _Y(160), COLOUR_BLACK, FONT_L),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK1], _Y(180), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK2], _Y(200), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK3], _Y(220), COLOUR_BLACK, FONT_S),
    TEXT_CENTER(&blue_ui_state.addr[CHUNK_CHK], _Y(240), COLOUR_SKYBLUE,
                FONT_S),

    BODY_BUTTON("Next", _X(170), _Y(360), COLOUR_GREY, button_tx_next)};

static const bagl_element_t bagl_ui_transaction[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),

    TEXT_LEFT(blue_ui_state.tx_type, _Y(105), COLOUR_BLACK, FONT_L),
    TEXT_RIGHT(blue_ui_state.abbrv_val, _Y(105), COLOUR_BLACK, FONT_L),
    TEXT_LEFT_TAB(&blue_ui_state.tx_type[TX_TYPE_SPLIT], _Y(125), COLOUR_BLACK,
                  FONT_S),
    TEXT_RIGHT(blue_ui_state.full_val, _Y(125), COLOUR_BLACK, FONT_S),

    TEXT_LEFT("Address:", _Y(160), COLOUR_BLACK, FONT_L),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK1], _Y(180), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK2], _Y(200), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK3], _Y(220), COLOUR_BLACK, FONT_S),
    TEXT_CENTER(&blue_ui_state.addr[CHUNK_CHK], _Y(240), COLOUR_SKYBLUE,
                FONT_S),

    TEXT_LEFT("BIP32 Path:", _Y(275), COLOUR_BLACK, FONT_M),
    TEXT_LEFT_TAB(blue_ui_state.bip32_path, _Y(295), COLOUR_BLACK, FONT_S),

    BODY_BUTTON("Previous", _X(30), _Y(360), COLOUR_DARKGREY, button_tx_prev),
    BODY_BUTTON("Next", _X(170), _Y(360), COLOUR_GREY, button_tx_next)};

static const bagl_element_t bagl_ui_transaction_last[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),

    TEXT_LEFT(blue_ui_state.tx_type, _Y(105), COLOUR_BLACK, FONT_L),
    TEXT_RIGHT(blue_ui_state.abbrv_val, _Y(105), COLOUR_BLACK, FONT_L),
    TEXT_LEFT_TAB(&blue_ui_state.tx_type[TX_TYPE_SPLIT], _Y(125), COLOUR_BLACK,
                  FONT_S),
    TEXT_RIGHT(blue_ui_state.full_val, _Y(125), COLOUR_BLACK, FONT_S),

    TEXT_LEFT("Address:", _Y(160), COLOUR_BLACK, FONT_L),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK1], _Y(180), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK2], _Y(200), COLOUR_BLACK, FONT_S),
    TEXT_LEFT_TAB(&blue_ui_state.addr[CHUNK3], _Y(220), COLOUR_BLACK, FONT_S),
    TEXT_CENTER(&blue_ui_state.addr[CHUNK_CHK], _Y(240), COLOUR_SKYBLUE,
                FONT_S),

    TEXT_LEFT("BIP32 Path:", _Y(275), COLOUR_BLACK, FONT_M),
    TEXT_LEFT_TAB(blue_ui_state.bip32_path, _Y(295), COLOUR_BLACK, FONT_S),

    BODY_BUTTON("Previous", _X(30), _Y(360), COLOUR_DARKGREY, button_tx_prev),
    BODY_BUTTON("Deny", _X(30), _Y(410), COLOUR_RED, button_deny),
    BODY_BUTTON("Approve", _X(170), _Y(410), COLOUR_GREEN, button_approve)};

static const bagl_element_t bagl_ui_generating_addr[] = {
    BG_FILL, HEADER_TEXT("Generating Address"),
    TEXT_CENTER("Generating Address...", _Y(270), COLOUR_BLACK, FONT_L)};

static const bagl_element_t bagl_ui_validating[] = {
    BG_FILL, HEADER_TEXT("Validating"),
    TEXT_CENTER("Validating...", _Y(270), COLOUR_BLACK, FONT_L)};

static const bagl_element_t bagl_ui_receiving_tx[] = {
    BG_FILL, HEADER_TEXT("Receiving Transaction"),
    TEXT_CENTER("Receiving Transaction...", _Y(270), COLOUR_BLACK, FONT_L)};

static const bagl_element_t bagl_ui_signing_tx[] = {
    BG_FILL, HEADER_TEXT("Signing Transaction"),
    TEXT_CENTER("Signing Transaction...", _Y(270), COLOUR_BLACK, FONT_L)};

#endif // BLUE_SCREENS_H
