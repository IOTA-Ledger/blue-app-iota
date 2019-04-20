#ifndef X_ELEMENTS_H
#define X_ELEMENTS_H

#ifdef TARGET_NANOX

#define DEFAULT_FONT                                                           \
    BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER

#define DEFAULT_FONT_BOLD                                                      \
    BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER

// {type, userid, x, y, width, height, stroke, radius, fill,
// fgcolor, bgcolor, fontid, iconid}, text .....

// -- Clear screen
#define SCREEN_CLEAR                                                           \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,     0,        0, 128, 64, 0, 0,                 \
         BAGL_FILL,      0x000000, 0xFFFFFF, 0, 0},                            \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Title screen top message
#define SCREEN_MSG_TOP                                                         \
    {                                                                          \
        {BAGL_LABELINE, 0x01,         0, 26, 128, 64, 0, 0, 0, 0xFFFFFF,       \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Title screen top message
#define SCREEN_MSG_TOP_BOLD                                                    \
    {                                                                          \
        {BAGL_LABELINE,     0x01, 0, 26, 128, 64, 0, 0, 0, 0xFFFFFF, 0x000000, \
         DEFAULT_FONT_BOLD, 0},                                                \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Title screen bottom message
#define SCREEN_MSG_BOT                                                         \
    {                                                                          \
        {BAGL_LABELINE, 0x01,         0, 50, 128, 64, 0, 0, 0, 0xFFFFFF,       \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Title screen bottom message
#define SCREEN_MSG_BOT_BOLD                                                    \
    {                                                                          \
        {BAGL_LABELINE,     0x01, 0, 50, 128, 64, 0, 0, 0, 0xFFFFFF, 0x000000, \
         DEFAULT_FONT_BOLD, 0},                                                \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen top message half off screen
#define SCREEN_MSG_TOP_HALF                                                    \
    {                                                                          \
        {BAGL_LABELINE, 0x01,         0, 26, 128, 64, 0, 0, 0, 0xFFFFFF,       \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen middle message
#define SCREEN_MSG_MID                                                         \
    {                                                                          \
        {BAGL_LABELINE,     0x01, 0, 38, 128, 64, 0, 0, 0, 0xFFFFFF, 0x000000, \
         DEFAULT_FONT_BOLD, 0},                                                \
            ui_text.mid_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen bot message half off screen
#define SCREEN_MSG_BOT_HALF                                                    \
    {                                                                          \
        {BAGL_LABELINE, 0x01,         0, 50, 128, 64, 0, 0, 0, 0xFFFFFF,       \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Underline for "IOTA"
#define SCREEN_UNDERLINE                                                       \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,     48,       44, 33, 1, 0, 0,                  \
         BAGL_FILL,      0xFFFFFF, 0x000000, 0,  0},                           \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Confirm bars along top
#define SCREEN_GLYPH_CONFIRM                                                   \
    {{BAGL_RECTANGLE, 0x00, 13, 6, 8, 1, 0, 0, BAGL_FILL, 0xFFFFFF, 0x000000,   \
      0, 0},                                                                   \
     NULL,                                                                     \
     0,                                                                        \
     0,                                                                        \
     0,                                                                        \
     NULL,                                                                     \
     NULL,                                                                     \
     NULL},                                                                    \
                                                                               \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,     107,      6, 8, 1, 0, 0,                    \
         BAGL_FILL,      0xFFFFFF, 0x000000, 0, 0},                            \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Up arrow on left
#define SCREEN_GLYPH_UP                                                        \
    {                                                                          \
        {BAGL_ICON, 0x00, 3, 29, 7, 7, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},     \
            (const char *)&C_x_icon_up, 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Down arrow on right
#define SCREEN_GLYPH_DOWN                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 117, 29, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},   \
            (const char *)&C_x_icon_down, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Loading icon on left
#define SCREEN_GLYPH_LOAD                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 9, 29, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},     \
            (const char *)&C_x_icon_load, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_DASH                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 24, 29, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            (const char *)&C_x_icon_dash, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- IOTA icon on left
#define SCREEN_GLYPH_IOTA                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 18, 29, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            (const char *)&C_x_icon_iota, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Back icon on left
#define SCREEN_GLYPH_BACK                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 24, 27, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},    \
            (const char *)&C_x_icon_back, 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Define all screen glyphs
#define SCREEN_GLYPHS_ALL                                                      \
    SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_UP, SCREEN_GLYPH_DOWN,                  \
        SCREEN_GLYPH_LOAD, SCREEN_GLYPH_DASH

// -- Define button functions with specific names
#define BUTTON_FUNCTION(name)                                                  \
    static unsigned int bagl_ui_##name##_screen_button(                        \
        unsigned int button_mask, unsigned int button_mask_counter)            \
    {                                                                          \
        nanos_transition_state(button_mask);                                   \
                                                                               \
        return 0;                                                              \
    }

#endif // TARGET_NANOX

#endif // X_ELEMENTS_H
