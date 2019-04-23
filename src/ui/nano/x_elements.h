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
        {BAGL_RECTANGLE, 0x00,     0,        0, 128, 64, 0, 0,                 \
         BAGL_FILL,      0x000000, 0xFFFFFF, 0, 0},                            \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

#define SCREEN_MSG_Y(y, txt, font)                                             \
    {                                                                          \
        {BAGL_LABELINE, 0x01,     0,    y, 128, 64, 0, 0, 0,                   \
         0xFFFFFF,      0x000000, font, 0},                                    \
            txt, 0, 0, 0, NULL, NULL, NULL                                     \
    }

// Basic Title on top, 1 line below - version
#define SCREEN_TITLE_TOP SCREEN_MSG_Y(28, ui_text.top_str, TITLE_FONT_LG)
#define SCREEN_TITLE_BOT SCREEN_MSG_Y(48, ui_text.bot_str, DEFAULT_FONT)

// 3 info lines (no title) - more info
#define SCREEN_BIP_TITLE SCREEN_MSG_Y(22, ui_text.top_str, TITLE_FONT_LG)
#define SCREEN_BIP_1 SCREEN_MSG_Y(36, ui_text.mid_str, DEFAULT_FONT)
#define SCREEN_BIP_2 SCREEN_MSG_Y(50, ui_text.bot_str, DEFAULT_FONT)

// 4 info lines (no title) - address
#define SCREEN_ADDRESS_1 SCREEN_MSG_Y(14, ui_text.top_str, DEFAULT_FONT)
#define SCREEN_ADDRESS_2 SCREEN_MSG_Y(28, ui_text.mid_str, DEFAULT_FONT)
#define SCREEN_ADDRESS_3 SCREEN_MSG_Y(42, ui_text.bot_str, DEFAULT_FONT)
#define SCREEN_ADDRESS_4 SCREEN_MSG_Y(56, ui_text.x_str, DEFAULT_FONT)

// TODO - MULTILINE MSG ICON/TEXT for LOADING
// Text under icon (home/back)
#define SCREEN_MSG_ICON SCREEN_MSG_Y(46, ui_text.mid_str, TITLE_FONT_LG)

#define SCREEN_MSG_ICON_MULTILINE_1                                            \
    SCREEN_MSG_Y(38, ui_text.top_str, TITLE_FONT_LG)
#define SCREEN_MSG_ICON_MULTILINE_2                                            \
    SCREEN_MSG_Y(56, ui_text.bot_str, TITLE_FONT_LG)

#define SCREEN_BOLD_LINE SCREEN_MSG_Y(38, ui_text.mid_str, TITLE_FONT_LG)

// TODO REMOVE
// -- Confirm bars along top
#define SCREEN_GLYPH_CONFIRM                                                   \
    {{BAGL_ICON, 0x00, 13, 6, 8, 1, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},        \
     ui_state.glyph[GLYPH_CONFIRM],                                             \
     0,                                                                        \
     0,                                                                        \
     0,                                                                        \
     NULL,                                                                     \
     NULL,                                                                     \
     NULL},                                                                    \
                                                                               \
    {                                                                          \
        {BAGL_ICON, 0x00, 107, 6, 8, 1, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            ui_state.glyph[GLYPH_CONFIRM], 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Up arrow on left
#define SCREEN_GLYPH_UP                                                        \
    {                                                                          \
        {BAGL_ICON, 0x00, 3, 29, 7, 7, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},     \
            ui_state.glyph[GLYPH_UP], 0, 0, 0, NULL, NULL, NULL                 \
    }

// -- Down arrow on right
#define SCREEN_GLYPH_DOWN                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 117, 29, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},   \
            ui_state.glyph[GLYPH_DOWN], 0, 0, 0, NULL, NULL, NULL               \
    }

// -- IOTA icon on left
#define SCREEN_GLYPH_IOTA                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 5, 13, 118, 46, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},  \
            ui_state.glyph[GLYPH_IOTA], 0, 0, 0, NULL, NULL, NULL               \
    }

// -- Loading icon on left
#define SCREEN_GLYPH_LOAD                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 57, 6, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},     \
            ui_state.glyph[GLYPH_LOAD], 0, 0, 0, NULL, NULL, NULL               \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_DASH                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            ui_state.glyph[GLYPH_DASH], 0, 0, 0, NULL, NULL, NULL               \
    }

// -- Back icon on left
#define SCREEN_GLYPH_BACK                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            ui_state.glyph[GLYPH_BACK], 0, 0, 0, NULL, NULL, NULL               \
    }

// -- Back icon on left
#define SCREEN_GLYPH_INFO                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            ui_state.glyph[GLYPH_INFO], 0, 0, 0, NULL, NULL, NULL               \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_CHECK                                                     \
    {                                                                          \
        {BAGL_ICON, 0x00, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            ui_state.glyph[GLYPH_CHECK], 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_CROSS                                                     \
    {                                                                          \
        {BAGL_ICON, 0x00, 57, 14, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            ui_state.glyph[GLYPH_CROSS], 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Define all screen glyphs
#define SCREEN_GLYPHS_ALL                                                      \
    SCREEN_GLYPH_IOTA, SCREEN_GLYPH_LOAD, SCREEN_GLYPH_DASH,                   \
        SCREEN_GLYPH_BACK, SCREEN_GLYPH_INFO, SCREEN_GLYPH_CHECK,              \
        SCREEN_GLYPH_CROSS, SCREEN_GLYPH_UP, SCREEN_GLYPH_DOWN,                \
        SCREEN_GLYPH_CONFIRM

// -- Define button functions with specific names
#define BUTTON_FUNCTION(name)                                                  \
    static unsigned int bagl_ui_##name##_screen_button(                        \
        unsigned int button_mask, unsigned int button_mask_counter)            \
    {                                                                          \
        nano_transition_state(button_mask);                                    \
                                                                               \
        return 0;                                                              \
    }

#endif // X_ELEMENTS_H
