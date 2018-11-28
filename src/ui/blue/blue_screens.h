#ifndef BLUE_SCREENS_H
#define BLUE_SCREENS_H

#include "blue_elements.h"
#include "blue_buttons.h"
#include "../../glyphs.h"

static const bagl_element_t bagl_ui_main[] = {BG_FILL,
                                              HEADER_TEXT("IOTA"),
                                              HEADER_BUTTON_L(SETTINGS),
                                              HEADER_BUTTON_R(DASHBOARD),
                                              BODY_IOTA_ICON,
                                              BODY_TITLE(OPEN_TITLE),
                                              TEXT_CENTERED(310, OPEN_MSG1),
                                              TEXT_CENTERED(332, OPEN_MSG2)};

static const bagl_element_t bagl_ui_settings[] = {
    BG_FILL,
    HEADER_TEXT("Settings"),
    HEADER_BUTTON_L(LEFT),
    TEXT_LEFT_TITLE(105, "Version"),
    TEXT_LEFT(125, APPVERSION),
    TEXT_LEFT_TITLE(180, "More Info"),
    TEXT_LEFT(200, MORE_INFO_TXT),
    BLUE_UI_BUTTON(COLOUR_RED, "Temp", 30, 240, button_tmp),
    BLUE_UI_BUTTON(COLOUR_GREEN, "Transaction", 170, 240, button_tx)};

static const bagl_element_t bagl_ui_transaction_first[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),
    HEADER_BUTTON_L(LEFT),
    HEADER_BUTTON_R(DASHBOARD),
    TEXT_LEFT_TITLE_LG(105, "Output:"),
    TEXT_RIGHT(105, "1.566 Gi"),
    TEXT_CENTERED(125, "1,566,091,655 i"),
    TEXT_LEFT_TITLE_LG(160, "Address:"),
    TEXT_LEFT(180, ADDR1),
    TEXT_LEFT(200, ADDR2),
    TEXT_LEFT(220, ADDR3),
    TEXT_CHK(240, ADDR_CHK),
    BLUE_UI_BUTTON(COLOUR_GREY, "Next", 170, 360, button_tx_next)};

static const bagl_element_t bagl_ui_transaction[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),
    HEADER_BUTTON_L(LEFT),
    HEADER_BUTTON_R(DASHBOARD),
    TEXT_LEFT_TITLE_LG(105, "Output:"),
    TEXT_RIGHT(105, "1.566 Gi"),
    TEXT_CENTERED(125, "1,566,091,655 i"),
    TEXT_LEFT_TITLE_LG(160, "Address:"),
    TEXT_LEFT(180, ADDR1),
    TEXT_LEFT(200, ADDR2),
    TEXT_LEFT(220, ADDR3),
    TEXT_CHK(240, ADDR_CHK),
    TEXT_LEFT_TITLE(275, "BIP32 Path:"),
    TEXT_LEFT(295, "44'|107a'|0'|14'"),
    BLUE_UI_BUTTON(COLOUR_DARK_GREY, "Previous", 30, 360, button_tx_prev),
    BLUE_UI_BUTTON(COLOUR_GREY, "Next", 170, 360, button_tx_next)};

static const bagl_element_t bagl_ui_transaction_last[] = {
    BG_FILL,
    HEADER_TEXT("Transaction"),
    HEADER_BUTTON_L(LEFT),
    HEADER_BUTTON_R(DASHBOARD),
    TEXT_LEFT_TITLE_LG(105, "Output:"),
    TEXT_RIGHT(105, "1.566 Gi"),
    TEXT_CENTERED(125, "1,566,091,655 i"),
    TEXT_LEFT_TITLE_LG(160, "Address:"),
    TEXT_LEFT(180, ADDR1),
    TEXT_LEFT(200, ADDR2),
    TEXT_LEFT(220, ADDR3),
    TEXT_CHK(240, ADDR_CHK),
    TEXT_LEFT_TITLE(275, "BIP32 Path:"),
    TEXT_LEFT(295, "44'|107a'|0'|14'"),
    BLUE_UI_BUTTON(COLOUR_DARK_GREY, "Previous", 30, 360, button_tx_prev),
    BLUE_UI_BUTTON(COLOUR_RED, "Deny", 30, 410, NULL),
    BLUE_UI_BUTTON(COLOUR_GREEN, "Approve", 170, 410, NULL)};

static const bagl_element_t bagl_ui_generating_addr[] = {
    BG_FILL, HEADER_TEXT("Generating Address"), HEADER_BUTTON_L(LEFT),
    BODY_TITLE("Generating Address...")};

static const bagl_element_t bagl_ui_validating[] = {
    BG_FILL, HEADER_TEXT("Validating"), HEADER_BUTTON_L(LEFT),
    BODY_TITLE("Validating...")};

static const bagl_element_t bagl_ui_receiving_tx[] = {
    BG_FILL, HEADER_TEXT("Receiving Transaction"), HEADER_BUTTON_L(LEFT),
    BODY_TITLE("Receiving Transaction...")};

static const bagl_element_t bagl_ui_signing_tx[] = {
    BG_FILL, HEADER_TEXT("Signing Transaction"), HEADER_BUTTON_L(LEFT),
    BODY_TITLE("Signing Transaction...")};

#endif // BLUE_SCREENS_H
