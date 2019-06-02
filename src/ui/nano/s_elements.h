#ifndef S_ELEMENTS_H
#define S_ELEMENTS_H

#define DEFAULT_FONT                                                           \
    (BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER)

#define DEFAULT_FONT_BOLD                                                      \
    (BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER)

// Screen with text message
#define SCREEN_MSG(userid, x, y, font_id, text)                                \
    {                                                                          \
        {BAGL_LABELINE, userid,   x,       y, 128 - x, 32, 0, 0, 0,            \
         0xFFFFFF,      0x000000, font_id, 0},                                 \
            text, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// Screen with internal glyph
#define SCREEN_GLYPH(userid, x, y, icon_id)                                    \
    {                                                                          \
        {BAGL_ICON, userid, x,        y,        0, 0,      0,                  \
         0,         0,      0x000000, 0x000000, 0, icon_id},                   \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// Screen with user defined glyph
#define SCREEN_GLYPH_USER(userid, x, y, icon_details)                          \
    {                                                                          \
        {BAGL_ICON, userid, x, y, 0, 0, 0, 0, 0, 0x000000, 0x000000, 0, 0},    \
            (const char *)icon_details, 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Clear screen
#define SCREEN_CLEAR                                                           \
    {                                                                          \
        {BAGL_RECTANGLE, EL_CLEAR, 0,        0, 128, 32, 0, 0,                 \
         BAGL_FILL,      0x000000, 0xFFFFFF, 0, 0},                            \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Underline for "IOTA"
#define SCREEN_UNDERLINE                                                       \
    {                                                                          \
        {BAGL_RECTANGLE, EL_IOTA,  48,       22, 33, 1, 0, 0,                  \
         BAGL_FILL,      0xFFFFFF, 0x000000, 0,  0},                           \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Title screen top message
#define SCREEN_MSG_TOP                                                         \
    SCREEN_MSG(EL_TITLE, 0, 13, DEFAULT_FONT, ui_text.top_str)

// -- Title screen bottom message
#define SCREEN_MSG_BOT                                                         \
    SCREEN_MSG(EL_TITLE, 0, 25, DEFAULT_FONT, ui_text.bot_str)

// -- Menu screen top message half off screen
#define SCREEN_MSG_TOP_HALF                                                    \
    SCREEN_MSG(EL_MENU, 0, 3, DEFAULT_FONT, ui_text.top_str)

// -- Menu screen middle message
#define SCREEN_MSG_MID                                                         \
    SCREEN_MSG(EL_MENU, 0, 19, DEFAULT_FONT_BOLD, ui_text.mid_str)

// -- Menu screen bot message half off screen
#define SCREEN_MSG_BOT_HALF                                                    \
    SCREEN_MSG(EL_MENU, 0, 36, DEFAULT_FONT, ui_text.bot_str)

// -- Bold middle message right of an icon
#define SCREEN_ICON_MSG                                                        \
    SCREEN_MSG(EL_ICON, 20, 19, DEFAULT_FONT_BOLD, ui_text.mid_str)

// -- Bold top message right of an icon
#define SCREEN_ICON_MULTILINE_MSG_TOP                                          \
    SCREEN_MSG(EL_ICON_MULTI, 20, 13, DEFAULT_FONT_BOLD, ui_text.top_str)

// -- Bold bottom message right of an icon
#define SCREEN_ICON_MULTILINE_MSG_BOT                                          \
    SCREEN_MSG(EL_ICON_MULTI, 20, 25, DEFAULT_FONT_BOLD, ui_text.bot_str)

// -- Confirm bars along top
#define SCREEN_GLYPH_CONFIRM_1                                                 \
    SCREEN_GLYPH(EL_CONFIRM, 3, 0, BAGL_GLYPH_ICON_LESS)
#define SCREEN_GLYPH_CONFIRM_2                                                 \
    SCREEN_GLYPH(EL_CONFIRM, 120, 0, BAGL_GLYPH_ICON_LESS)

// -- Up arrow on left
#define SCREEN_GLYPH_UP SCREEN_GLYPH(EL_UP, 3, 12, BAGL_GLYPH_ICON_UP)

// -- Down arrow on right
#define SCREEN_GLYPH_DOWN SCREEN_GLYPH(EL_DOWN, 120, 13, BAGL_GLYPH_ICON_DOWN)

// -- Loading icon on left
#define SCREEN_GLYPH_LOAD                                                      \
    SCREEN_GLYPH(EL_LOAD, 13, 16, BAGL_GLYPH_ICON_LOADING_BADGE)

// -- Dashboard icon on left
#define SCREEN_GLYPH_DASH                                                      \
    SCREEN_GLYPH(EL_DASH, 25, 15, BAGL_GLYPH_ICON_DASHBOARD_BADGE)

// -- IOTA icon on left
#define SCREEN_GLYPH_IOTA SCREEN_GLYPH_USER(EL_IOTA, 18, 8, &C_icon_iota)

// -- Back icon on left
#define SCREEN_GLYPH_BACK SCREEN_GLYPH_USER(EL_BACK, 24, 8, &C_icon_back)

// -- Define all screen messages
#define SCREEN_MSG_ALL                                                         \
    SCREEN_MSG_TOP, SCREEN_MSG_BOT, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID,       \
        SCREEN_MSG_BOT_HALF, SCREEN_ICON_MSG, SCREEN_ICON_MULTILINE_MSG_TOP,   \
        SCREEN_ICON_MULTILINE_MSG_BOT

// -- Define all screen glyphs
#define SCREEN_GLYPHS_ALL                                                      \
    SCREEN_GLYPH_CONFIRM_1, SCREEN_GLYPH_CONFIRM_2, SCREEN_GLYPH_UP,           \
        SCREEN_GLYPH_DOWN, SCREEN_GLYPH_LOAD, SCREEN_GLYPH_DASH,               \
        SCREEN_GLYPH_BACK, SCREEN_GLYPH_IOTA, SCREEN_UNDERLINE

#endif // S_ELEMENTS_H
