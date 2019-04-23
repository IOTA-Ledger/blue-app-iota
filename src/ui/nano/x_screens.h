#ifndef X_SCREENS_H
#define X_SCREENS_H

#include "nano_core.h"
#include "x_elements.h"
#include "glyphs.h"

// screen for title on top, info on bottom
static const bagl_element_t bagl_ui_title_screen[] = {
    SCREEN_CLEAR, SCREEN_TITLE_TOP, SCREEN_TITLE_BOT, SCREEN_GLYPHS_ALL};

// TODO remove unused screens
// screen for 4 lines for address
static const bagl_element_t bagl_ui_addr_screen[] = {
    SCREEN_CLEAR,     SCREEN_ADDRESS_1, SCREEN_ADDRESS_2, SCREEN_ADDRESS_3,
    SCREEN_ADDRESS_4, SCREEN_GLYPHS_ALL};

// screen for BIP Path title and bip path below
static const bagl_element_t bagl_ui_bip_screen[] = {
    SCREEN_CLEAR, SCREEN_BIP_TITLE, SCREEN_BIP_1,
    SCREEN_BIP_2, SCREEN_GLYPHS_ALL};

// screen for displaying icon with 1 line
static const bagl_element_t bagl_ui_icon_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_ICON, SCREEN_GLYPHS_ALL};

// screen for displaying icon with 2 lines
static const bagl_element_t bagl_ui_icon_multi_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_ICON_MULTILINE_1, SCREEN_MSG_ICON_MULTILINE_2, SCREEN_GLYPH_LOAD};

#endif // X_SCREENS_H
