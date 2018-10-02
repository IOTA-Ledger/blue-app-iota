#ifndef UI_ELEMENTS_H
#define UI_ELEMENTS_H


// {type, userid, x, y, width, height, stroke, radius, fill,
// fgcolor, bgcolor, fontid, iconid}, text .....

// -- Clear screen
#define SCREEN_CLEAR                                                           \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,     0,        0, 128, 32, 0, 0,                 \
         BAGL_FILL,      0x000000, 0xFFFFFF, 0, 0},                            \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Title screen top message
#define SCREEN_MSG_TOP                                                         \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x01,                                                                 \
         0,                                                                    \
         13,                                                                   \
         128,                                                                  \
         32,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER,        \
         0},                                                                   \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Title screen bottom message
#define SCREEN_MSG_BOT                                                         \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x01,                                                                 \
         0,                                                                    \
         25,                                                                   \
         128,                                                                  \
         32,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER,        \
         0},                                                                   \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen top message half off screen
#define SCREEN_MSG_TOP_HALF                                                    \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x01,                                                                 \
         0,                                                                    \
         3,                                                                    \
         128,                                                                  \
         32,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER,        \
         0},                                                                   \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen middle message
#define SCREEN_MSG_MID                                                         \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x01,                                                                 \
         0,                                                                    \
         19,                                                                   \
         128,                                                                  \
         32,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER,      \
         0},                                                                   \
            ui_text.mid_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen bot message half off screen
#define SCREEN_MSG_BOT_HALF                                                    \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x01,                                                                 \
         0,                                                                    \
         36,                                                                   \
         128,                                                                  \
         32,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER,        \
         0},                                                                   \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Underline for "IOTA"
#define SCREEN_UNDERLINE                                                       \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,     48,       22, 33, 1, 0, 0,                  \
         BAGL_FILL,      0xFFFFFF, 0x000000, 0,  0},                           \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Confirm bars along top
#define SCREEN_GLYPH_CONFIRM                                                   \
    {{BAGL_ICON, 0x00, 3, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,            \
      BAGL_GLYPH_ICON_LESS},                                                   \
     &ui_glyphs.glyph[GLYPH_CONFIRM],                                          \
     0,                                                                        \
     0,                                                                        \
     0,                                                                        \
     NULL,                                                                     \
     NULL,                                                                     \
     NULL},                                                                    \
                                                                               \
    {                                                                          \
        {BAGL_ICON,                                                            \
         0x00,                                                                 \
         117,                                                                  \
         -3,                                                                   \
         8,                                                                    \
         6,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         0,                                                                    \
         BAGL_GLYPH_ICON_LESS},                                                \
            &ui_glyphs.glyph[GLYPH_CONFIRM], 0, 0, 0, NULL, NULL, NULL         \
    }

// -- Up arrow on left
#define SCREEN_GLYPH_UP                                                        \
    {                                                                          \
        {BAGL_ICON,         0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0, \
         BAGL_GLYPH_ICON_UP},                                                  \
            &ui_glyphs.glyph[GLYPH_UP], 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Down arrow on right
#define SCREEN_GLYPH_DOWN                                                      \
    {                                                                          \
        {BAGL_ICON,                                                            \
         0x00,                                                                 \
         117,                                                                  \
         13,                                                                   \
         8,                                                                    \
         6,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         0,                                                                    \
         BAGL_GLYPH_ICON_DOWN},                                                \
            &ui_glyphs.glyph[GLYPH_DOWN], 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Warning icon on left
#define SCREEN_GLYPH_WARN                                                      \
    {                                                                          \
        {BAGL_ICON,                                                            \
         0x00,                                                                 \
         9,                                                                    \
         12,                                                                   \
         8,                                                                    \
         6,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         0,                                                                    \
         BAGL_GLYPH_ICON_WARNING_BADGE},                                       \
            &ui_glyphs.glyph[GLYPH_WARN], 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Loading icon on left
#define SCREEN_GLYPH_LOAD                                                      \
    {                                                                          \
        {BAGL_ICON,                                                            \
         0x00,                                                                 \
         9,                                                                    \
         12,                                                                   \
         8,                                                                    \
         6,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         0,                                                                    \
         BAGL_GLYPH_ICON_LOADING_BADGE},                                       \
            &ui_glyphs.glyph[GLYPH_LOAD], 0, 0, 0, NULL, NULL, NULL            \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_DASH                                                      \
    {                                                                          \
        {BAGL_ICON,                                                            \
         0x00,                                                                 \
         24,                                                                   \
         12,                                                                   \
         8,                                                                    \
         6,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         0xFFFFFF,                                                             \
         0x000000,                                                             \
         0,                                                                    \
         BAGL_GLYPH_ICON_DASHBOARD_BADGE},                                     \
            &ui_glyphs.glyph[GLYPH_DASH], 0, 0, 0, NULL, NULL, NULL            \
    }

// -- IOTA icon on left
#define SCREEN_GLYPH_IOTA                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 18, 8, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},     \
            (const char *)&C_icon_iota, 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Back icon on left
#define SCREEN_GLYPH_BACK                                                      \
    {                                                                          \
        {BAGL_ICON, 0x00, 24, 8, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},     \
            (const char *)&C_icon_back, 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Define all screen glyphs
#define SCREEN_GLYPHS_ALL                                                      \
    SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_UP, SCREEN_GLYPH_DOWN,                  \
        SCREEN_GLYPH_WARN, SCREEN_GLYPH_LOAD, SCREEN_GLYPH_DASH

// -- Define button functions with specific names
#define BUTTON_FUNCTION(name)                                                  \
    static unsigned int bagl_ui_##name##_screen_button(                        \
        unsigned int button_mask, unsigned int button_mask_counter)            \
    {                                                                          \
        ui_transition_state(button_mask);                                      \
                                                                               \
        return 0;                                                              \
    }

#endif // UI_ELEMENTS_H
