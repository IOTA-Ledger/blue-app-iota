#ifndef NANO_TYPES_H
#define NANO_TYPES_H

#include <stdint.h>
#include <stdbool.h>
#include "macros.h"
#include "iota/iota_types.h"

/// length of one text line
#define TEXT_LEN 21

typedef enum { BUTTON_L, BUTTON_R, BUTTON_B, BUTTON_BAD } UI_BUTTON_PRESS;

// Different positions text can appear at -
// TOP_H and BOT_H are "half off the screen" elements on the S
// to give a scrollable menu effect. POS_X is a fourth
// text position for displaying addresses on the NANO X
typedef enum { TOP_H, TOP, MID, BOT, BOT_H, POS_X } UI_TEXT_POS;

#ifdef TARGET_NANOS

// allowed text lengths in the different screens
#define TEXT_LEN_ADDRESS_ABBREV 18
#define TEXT_LEN_ADDRESS_FULL 18
#define TEXT_LEN_VALUE 18

// UI SCREENS
typedef enum {
    SCREEN_TITLE,
    SCREEN_MENU,
    SCREEN_ICON,
    SCREEN_ICON_MULTI,
} UI_SCREENS_NANO;

// UI ELEMENTS
typedef enum {
    EL_CLEAR,
    EL_UP,
    EL_DOWN,
    EL_DASH,
    EL_LOAD,
    EL_IOTA,
    EL_BACK,
    EL_CONFIRM,
    EL_ICON,
    EL_ICON_MULTI,
    EL_TITLE,
    EL_MENU,
    NUM_UI_ELEMENTS
} UI_ELEMENTS_NANO;

#else // TARGET_NANOS

// allowed text lengths in the different screens
#define TEXT_LEN_ADDRESS_ABBREV 15
#define TEXT_LEN_ADDRESS_FULL 18
#define TEXT_LEN_VALUE 18

// UI SCREEN TYPES - these map onto omega screen elements
typedef enum {
    SCREEN_TITLE,
    SCREEN_ICON,
    SCREEN_ICON_MULTI,
    SCREEN_BIP,
    SCREEN_ADDR
} UI_SCREENS_NANO;

// UI ELEMENTS
typedef enum {
    EL_CLEAR,
    EL_UP,   // maps to left
    EL_DOWN, // maps to right
    EL_DASH,
    EL_LOAD,
    EL_IOTA,
    EL_BACK,
    EL_INFO,
    EL_CHECK,
    EL_CROSS,
    EL_TITLE,
    EL_BIP,
    EL_ADDR,
    EL_ICON,
    EL_ICON_MULTI,
    NUM_UI_ELEMENTS
} UI_ELEMENTS_NANO;

#endif // TARGET_NANOS

// Menus

#ifdef TARGET_NANOS
static const char MENU_MORE_INFO_TEXT[][TEXT_LEN] = {
    "Please visit", "iota.org/sec", "for more info."};
#define MENU_MORE_INFO_LEN ARRAY_SIZE(MENU_MORE_INFO_TEXT)
#endif

// Split the entire address into 15 chunks with 6 trytes each
#define MENU_ADDR_CHUNK_LEN 6
#define MENU_ADDR_LEN                                                          \
    CEILING(NUM_ADDRESS_TRYTES,                                                \
            MENU_ADDR_CHUNK_LEN *(TEXT_LEN_ADDRESS_FULL /                      \
                                  (MENU_ADDR_CHUNK_LEN + 1)))

#ifdef TARGET_NANOS
#define MENU_ADDR_LAST MAX(MENU_ADDR_LEN - 1, 0)
#define MENU_BIP_LAST 1
#else
#define MENU_ADDR_LAST MAX(CEILING(MENU_ADDR_LEN, 4) - 1, 0)
#define MENU_BIP_LAST 0
#endif

#define MENU_TX_APPROVE (menu_bundle_len - 2)
#define MENU_TX_DENY (menu_bundle_len - 1)

// UI STATES
typedef enum {
    STATE_MAIN_MENU,
    STATE_ABOUT,
    STATE_VERSION,
    STATE_MORE_INFO,
    STATE_ADDRESS_DIGEST,
    STATE_ADDRESS_FULL,
    STATE_BUNDLE,
    STATE_BUNDLE_ADDR,
    STATE_BIP_PATH,
    STATE_IGNORE,
    STATE_EXIT = 255
} UI_STATES_NANO;

// Main menu entries
typedef enum {
    MENU_MAIN_IOTA,
    MENU_MAIN_ABOUT,
    MENU_MAIN_EXIT,
    MENU_MAIN_LEN
} MENU_MAIN_ENTRIES;

// About menu entries
typedef enum {
    MENU_ABOUT_VERSION,
    MENU_ABOUT_MORE_INFO,
    MENU_ABOUT_BACK,
    MENU_ABOUT_LEN
} MENU_ABOUT_ENTRIES;

typedef struct UI_TEXT_CTX_NANO {

    char top_str[TEXT_LEN];
    char mid_str[TEXT_LEN];
    char bot_str[TEXT_LEN];
#ifdef TARGET_NANOX
    char x_str[TEXT_LEN];
#endif

} UI_TEXT_CTX_NANO;

typedef struct UI_STATE_CTX_NANO {

    // current UI state
    uint8_t state;
    uint8_t menu_idx;
    uint8_t nano_state_backup;
    uint8_t backup_menu_idx;

    // bit flags
    struct {
        /// flag for each UI element to enable/disable
        unsigned int elements : NUM_UI_ELEMENTS;
        /// flag whether the value format can be toggled between full/readable
        unsigned int toggle_value : 1;
        /// flag whether the full or abbreviated value is shown
        unsigned int full_value : 1;
    } flags;

    // data buffered in the UI
    union {
        unsigned char addr_bytes[NUM_HASH_BYTES];
    } buffer;

} UI_STATE_CTX_NANO;

extern UI_TEXT_CTX_NANO ui_text;
extern UI_STATE_CTX_NANO ui_state;

#endif // NANO_TYPES_H
