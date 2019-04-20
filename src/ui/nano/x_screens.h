#ifndef X_SCREENS_H
#define X_SCREENS_H

#include "x_elements.h"
#include "x_core.h"
#include "glyphs.h"

// screen for title on top, info on bottom
static const bagl_element_t bagl_ui_title_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP, SCREEN_MSG_BOT, SCREEN_GLYPHS_ALL};

// screen for title on top info on bottom BOLD
static const bagl_element_t bagl_ui_title_bold_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_BOLD, SCREEN_MSG_BOT_BOLD, SCREEN_GLYPHS_ALL};

// screen for info in the middle, and half text elements above and below (menu
// effect)
static const bagl_element_t bagl_ui_menu_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_MSG_BOT_HALF,
    SCREEN_GLYPHS_ALL};

// screen for displaying IOTA icon
static const bagl_element_t bagl_ui_iota_screen[] = {
    SCREEN_CLEAR,         SCREEN_MSG_MID,    SCREEN_UNDERLINE,
    SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_IOTA, SCREEN_GLYPH_DOWN};

// screen for displaying back icon
static const bagl_element_t bagl_ui_back_screen[] = {
    SCREEN_CLEAR,      SCREEN_MSG_TOP_HALF,  SCREEN_MSG_MID,
    SCREEN_GLYPH_BACK, SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_UP};

// screen for displaying dash icon
static const bagl_element_t bagl_ui_dash_screen[] = {
    SCREEN_CLEAR,      SCREEN_MSG_TOP_HALF,  SCREEN_MSG_MID,
    SCREEN_GLYPH_DASH, SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_UP};

// screen for displaying up icon
static const bagl_element_t bagl_ui_up_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_GLYPH_UP};

// screen for displaying down icon
static const bagl_element_t bagl_ui_dn_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_GLYPH_DOWN};

// screen for displaying confirm icon
static const bagl_element_t bagl_ui_conf_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_GLYPH_CONFIRM};

// screen for displaying up + down icons
static const bagl_element_t bagl_ui_updn_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_GLYPH_UP,
    SCREEN_GLYPH_DOWN};

// screen for displaying up + confirm icons
static const bagl_element_t bagl_ui_upconf_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_GLYPH_UP,
    SCREEN_GLYPH_CONFIRM};

// screen for displaying down + confirm icons
static const bagl_element_t bagl_ui_dnconf_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_GLYPH_DOWN,
    SCREEN_GLYPH_CONFIRM};

// screen for displaying up + down + confirm icons
static const bagl_element_t bagl_ui_updnconf_screen[] = {
    SCREEN_CLEAR,    SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID,
    SCREEN_GLYPH_UP, SCREEN_GLYPH_DOWN,   SCREEN_GLYPH_CONFIRM};

#endif // X_SCREENS_H
