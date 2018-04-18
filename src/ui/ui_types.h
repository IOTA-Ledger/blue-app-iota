#ifndef UI_TYPES_H
#define UI_TYPES_H

#include <stdint.h>
#include "../api.h"
#include "../iota/bundle.h"

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

// TODO organize order
#define STATE_MENU_INIT 0
#define STATE_MENU_WELCOME 1
#define STATE_IGNORE 2
#define STATE_MENU_DISP_IDX 3
#define STATE_MENU_ADVANCED 4
#define STATE_MENU_ADV_WARN 5
#define STATE_MENU_DISP_ADDR 6 // Host displays pubkey on ledger
#define STATE_MENU_TX_ADDR 7   // Display address in TX
#define STATE_DISP_ADDR_CHK 8  // Abbreviated address with Checksum
#define STATE_MENU_INIT_LEDGER 9
#define STATE_PROMPT_TX 10

#define STATE_EXIT 255

// Size of Menu
#define MENU_INIT_LEN 5
#define MENU_WELCOME_LEN 4
#define MENU_DISP_IDX_LEN 6
#define MENU_ADVANCED_LEN 2
#define MENU_ADV_WARN_LEN 3
#define MENU_ADDR_LEN 7
#define MENU_INIT_LEDGER_LEN 9

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

    uint8_t state;
    uint8_t menu_idx;

    uint8_t backup_state;
    uint8_t backup_menu_idx;

    // tx information
    int64_t val;
    bool display_full_value;

    char addr[90];

    BUNDLE_CTX *bundle_ctx;
    // init ledger indexes
    const INIT_LEDGER_INPUT *input;

} UI_STATE_CTX;

extern UI_TEXT_CTX ui_text;
extern UI_GLYPH_CTX ui_glyphs;
extern UI_STATE_CTX ui_state;

#endif // UI_TYPES_H
