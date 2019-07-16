#ifndef X_ELEMENTS_H
#define X_ELEMENTS_H

#define DEFAULT_FONT                                                           \
    BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER

#define DEFAULT_FONT_BOLD                                                      \
    BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER

#define TITLE_FONT_LG                                                          \
    BAGL_FONT_OPEN_SANS_LIGHT_16px | BAGL_FONT_ALIGNMENT_CENTER

// {type, userid, x, y, width, height, stroke, radius, fill,
// fgcolor, bgcolor, fontid, iconid}, text .....

// -- Clear screen
#define SCREEN_CLEAR                                                           \
    {                                                                          \
        {BAGL_RECTANGLE, EL_CLEAR, 0,        0, 128, 64, 0, 0,                 \
         BAGL_FILL,      0x000000, 0xFFFFFF, 0, 0},                            \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

#define SCREEN_MSG_Y(y, txt, font, userid)                                     \
    {                                                                          \
        {BAGL_LABELINE, userid,   0,    y, 128, 64, 0, 0, 0,                   \
         0xFFFFFF,      0x000000, font, 0},                                    \
            txt, 0, 0, 0, NULL, NULL, NULL                                     \
    }

// Basic Title on top, 1 line below - version
#define SCREEN_TITLE_TOP                                                       \
    SCREEN_MSG_Y(28, ui_text.top_str, TITLE_FONT_LG, EL_TITLE)
#define SCREEN_TITLE_BOT                                                       \
    SCREEN_MSG_Y(48, ui_text.bot_str, DEFAULT_FONT, EL_TITLE)

// 3 info lines (no title) - more info
#define SCREEN_BIP_TITLE                                                       \
    SCREEN_MSG_Y(22, ui_text.top_str, TITLE_FONT_LG, EL_BIP)
#define SCREEN_BIP_1 SCREEN_MSG_Y(36, ui_text.mid_str, DEFAULT_FONT, EL_BIP)
#define SCREEN_BIP_2 SCREEN_MSG_Y(50, ui_text.bot_str, DEFAULT_FONT, EL_BIP)

// 4 info lines (no title) - address
#define SCREEN_ADDRESS_1                                                       \
    SCREEN_MSG_Y(14, ui_text.top_str, DEFAULT_FONT, EL_ADDR)
#define SCREEN_ADDRESS_2                                                       \
    SCREEN_MSG_Y(28, ui_text.mid_str, DEFAULT_FONT, EL_ADDR)
#define SCREEN_ADDRESS_3                                                       \
    SCREEN_MSG_Y(42, ui_text.bot_str, DEFAULT_FONT, EL_ADDR)
#define SCREEN_ADDRESS_4 SCREEN_MSG_Y(56, ui_text.x_str, DEFAULT_FONT, EL_ADDR)

// Text under icon (home/back)
#define SCREEN_MSG_ICON                                                        \
    SCREEN_MSG_Y(46, ui_text.mid_str, TITLE_FONT_LG, EL_ICON)

#define SCREEN_MSG_ICON_MULTILINE_1                                            \
    SCREEN_MSG_Y(38, ui_text.top_str, TITLE_FONT_LG, EL_ICON_MULTI)
#define SCREEN_MSG_ICON_MULTILINE_2                                            \
    SCREEN_MSG_Y(56, ui_text.bot_str, TITLE_FONT_LG, EL_ICON_MULTI)

// -- Up arrow on left
#define SCREEN_GLYPH_UP                                                        \
    {                                                                          \
        {BAGL_ICON, EL_UP, 3, 29, 7, 7, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            (const char *)&C_x_icon_left, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Down arrow on right
#define SCREEN_GLYPH_DOWN                                                      \
    {                                                                          \
        {                                                                      \
            BAGL_ICON, EL_DOWN, 117,      29,       8, 6, 0,                   \
            0,         0,       0xFFFFFF, 0x000000, 0, 0},                     \
            (const char *)&C_x_icon_right, 0, 0, 0, NULL, NULL, NULL           \
    }

// -- IOTA icon on left
#define SCREEN_GLYPH_IOTA                                                      \
    {                                                                          \
        {                                                                      \
            BAGL_ICON, EL_IOTA, 0,        0,        128, 40, 0,                \
            0,         0,       0xFFFFFF, 0x000000, 0,   0},                   \
            (const char *)&C_x_iota_logo, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Loading icon on left
#define SCREEN_GLYPH_LOAD                                                      \
    {                                                                          \
        {BAGL_ICON, EL_LOAD, 57, 6, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},  \
            (const char *)&C_x_icon_load, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_DASH                                                      \
    {                                                                          \
        {BAGL_ICON, EL_DASH, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0}, \
            (const char *)&C_x_icon_dash, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Back icon on left
#define SCREEN_GLYPH_BACK                                                      \
    {                                                                          \
        {BAGL_ICON, EL_BACK, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0}, \
            (const char *)&C_x_icon_back, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Back icon on left
#define SCREEN_GLYPH_INFO                                                      \
    {                                                                          \
        {BAGL_ICON, EL_INFO, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0}, \
            (const char *)&C_x_icon_info, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_CHECK                                                     \
    {                                                                          \
        {                                                                      \
            BAGL_ICON, EL_CHECK, 57,       14,       8, 6, 0,                  \
            0,         0,        0xFFFFFF, 0x000000, 0, 0},                    \
            (const char *)&C_x_icon_check, 0, 0, 0, NULL, NULL, NULL           \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_CROSS                                                     \
    {                                                                          \
        {                                                                      \
            BAGL_ICON, EL_CROSS, 57,       14,       8, 6, 0,                  \
            0,         0,        0xFFFFFF, 0x000000, 0, 0},                    \
            (const char *)&C_x_icon_cross, 0, 0, 0, NULL, NULL, NULL           \
    }

// -- Define all screen glyphs
#define SCREEN_GLYPHS_ALL                                                      \
    SCREEN_GLYPH_IOTA, SCREEN_GLYPH_LOAD, SCREEN_GLYPH_DASH,                   \
        SCREEN_GLYPH_BACK, SCREEN_GLYPH_INFO, SCREEN_GLYPH_CHECK,              \
        SCREEN_GLYPH_CROSS, SCREEN_GLYPH_UP, SCREEN_GLYPH_DOWN

#endif // X_ELEMENTS_H
