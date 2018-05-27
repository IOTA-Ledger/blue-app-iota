#ifndef UI_TYPES_H
#define UI_TYPES_H

#include <stdint.h>
#include "iota/bundle.h"

/* -------------------------------------------------
 ------------------------------------------------- */
static char app_version[10] = "1.0.0\0";
/* -------------------------------------------------
 ------------------------------------------------- */

#define TYPE_INT 0
#define TYPE_STR 1

#define TOP_H 0
#define TOP 1
#define MID 2
#define BOT 3
#define BOT_H 4

#define BUTTON_L 0
#define BUTTON_R 1
#define BUTTON_B 2

#define BUTTON_BAD 255

// UI STATES

#define STATE_INIT 0
#define STATE_WELCOME 1
#define STATE_IGNORE 2
#define STATE_DISP_IDX 3
#define STATE_ABOUT 4
#define STATE_VERSION 5
#define STATE_MORE_INFO 6
#define STATE_DISP_ADDR 7     // Host displays pubkey on ledger
#define STATE_TX_ADDR 8       // Display full address in TX
#define STATE_DISP_ADDR_CHK 9 // Abbreviated address with Checksum
#define STATE_WRITE_INDEXES 10
#define STATE_PROMPT_TX 11
#define STATE_WARN_CHANGE 12

#define STATE_EXIT 255

// Size of Menu
#define MENU_INIT_LEN 6
#define MENU_WELCOME_LEN 4
#define MENU_DISP_IDX_LEN 6
#define MENU_ABOUT_LEN 3
#define MENU_ADDR_LEN 7
#define MENU_WRITE_INDEXES_LEN 10
#define MENU_WARN_CHANGE_LEN 7
#define MENU_MORE_INFO_LEN 3

typedef struct UI_TEXT_CTX {

    // half_top/bot are text lines half off the screen
    // to make text menus appear scrollable
    char half_top[21];
    char top_str[21];
    char mid_str[21];
    char bot_str[21];
    char half_bot[21];

} UI_TEXT_CTX;

typedef struct UI_GLYPH_CTX {

    // flags for turning on/off certain glyphs
    char glyph_bar_l[2], glyph_bar_r[2];
    char glyph_cross[2], glyph_check[2];
    char glyph_up[2], glyph_down[2];
    char glyph_warn[2], glyph_dash[2], glyph_load[2];

} UI_GLYPH_CTX;

typedef struct UI_STATE_CTX {

    // tx information
    int64_t val;
    bool display_full_value;

    char addr[90];

    uint8_t state;
    uint8_t menu_idx;

    uint8_t backup_state;
    uint8_t backup_menu_idx;

    const BUNDLE_CTX *bundle_ctx;
    const uint32_t *seed_indexes;

} UI_STATE_CTX;

extern UI_TEXT_CTX ui_text;
extern UI_GLYPH_CTX ui_glyphs;
extern UI_STATE_CTX ui_state;

#endif // UI_TYPES_H
