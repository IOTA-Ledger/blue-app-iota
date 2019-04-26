#ifndef S_ELEMENTS_H
#define S_ELEMENTS_H

#define DEFAULT_FONT                                                           \
    BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER

#define DEFAULT_FONT_BOLD                                                      \
    BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER

// {type, userid, x, y, width, height, stroke, radius, fill,
// fgcolor, bgcolor, fontid, iconid}, text .....

// -- Clear screen
#define SCREEN_CLEAR                                                           \
    {                                                                          \
        {BAGL_RECTANGLE, EL_CLEAR, 0,        0, 128, 32, 0, 0,                 \
         BAGL_FILL,      0x000000, 0xFFFFFF, 0, 0},                            \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Title screen top message
#define SCREEN_MSG_TOP                                                         \
    {                                                                          \
        {BAGL_LABELINE, EL_TITLE,     0, 13, 128, 32, 0, 0, 0, 0xFFFFFF,       \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Title screen top message
#define SCREEN_MSG_TOP_BOLD                                                    \
    {                                                                          \
        {BAGL_LABELINE, EL_TITLE_BOLD,     0, 13, 128, 32, 0, 0, 0, 0xFFFFFF,  \
         0x000000,      DEFAULT_FONT_BOLD, 0},                                 \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Title screen bottom message
#define SCREEN_MSG_BOT                                                         \
    {                                                                          \
        {BAGL_LABELINE, EL_TITLE,     0, 25, 128, 32, 0, 0, 0, 0xFFFFFF,       \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Title screen bottom message
#define SCREEN_MSG_BOT_BOLD                                                    \
    {                                                                          \
        {BAGL_LABELINE, EL_TITLE_BOLD,     0, 25, 128, 32, 0, 0, 0, 0xFFFFFF,  \
         0x000000,      DEFAULT_FONT_BOLD, 0},                                 \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen top message half off screen
#define SCREEN_MSG_TOP_HALF                                                    \
    {                                                                          \
        {BAGL_LABELINE, EL_MENU,      0, 3, 128, 32, 0, 0, 0, 0xFFFFFF,        \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.top_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen middle message
#define SCREEN_MSG_MID                                                         \
    {                                                                          \
        {BAGL_LABELINE, EL_MENU,           0, 19, 128, 32, 0, 0, 0, 0xFFFFFF,  \
         0x000000,      DEFAULT_FONT_BOLD, 0},                                 \
            ui_text.mid_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Menu screen bot message half off screen
#define SCREEN_MSG_BOT_HALF                                                    \
    {                                                                          \
        {BAGL_LABELINE, EL_MENU,      0, 36, 128, 32, 0, 0, 0, 0xFFFFFF,       \
         0x000000,      DEFAULT_FONT, 0},                                      \
            ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL                         \
    }

// -- Underline for "IOTA"
#define SCREEN_UNDERLINE                                                       \
    {                                                                          \
        {BAGL_RECTANGLE, EL_IOTA,  48,       22, 33, 1, 0, 0,                  \
         BAGL_FILL,      0xFFFFFF, 0x000000, 0,  0},                           \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Confirm bars along top
#define SCREEN_GLYPH_CONFIRM                                                   \
    {{BAGL_ICON, EL_CONFIRM, 3, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,      \
      BAGL_GLYPH_ICON_LESS},                                                   \
     NULL,                                                                     \
     0,                                                                        \
     0,                                                                        \
     0,                                                                        \
     NULL,                                                                     \
     NULL,                                                                     \
     NULL},                                                                    \
                                                                               \
    {                                                                          \
        {BAGL_ICON,                                                            \
         EL_CONFIRM,                                                           \
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
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Up arrow on left
#define SCREEN_GLYPH_UP                                                        \
    {                                                                          \
        {                                                                      \
            BAGL_ICON,                                                         \
            EL_UP,                                                             \
            3,                                                                 \
            12,                                                                \
            7,                                                                 \
            7,                                                                 \
            0,                                                                 \
            0,                                                                 \
            0,                                                                 \
            0x000000,                                                          \
            0x000000,                                                          \
            0,                                                                 \
            BAGL_GLYPH_ICON_UP},                                               \
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Down arrow on right
#define SCREEN_GLYPH_DOWN                                                      \
    {                                                                          \
        {BAGL_ICON,                                                            \
         EL_DOWN,                                                              \
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
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Loading icon on left
#define SCREEN_GLYPH_LOAD                                                      \
    {                                                                          \
        {BAGL_ICON,                                                            \
         EL_LOAD,                                                              \
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
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- Dashboard icon on left
#define SCREEN_GLYPH_DASH                                                      \
    {                                                                          \
        {BAGL_ICON,                                                            \
         EL_DASH,                                                              \
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
            NULL, 0, 0, 0, NULL, NULL, NULL                                    \
    }

// -- IOTA icon on left
#define SCREEN_GLYPH_IOTA                                                      \
    {                                                                          \
        {BAGL_ICON, EL_IOTA, 18, 8, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},  \
            (const char *)&C_icon_iota, 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Back icon on left
#define SCREEN_GLYPH_BACK                                                      \
    {                                                                          \
        {BAGL_ICON, EL_BACK, 24, 8, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, 0},  \
            (const char *)&C_icon_back, 0, 0, 0, NULL, NULL, NULL              \
    }

// -- Define all screen glyphs
#define SCREEN_GLYPHS_ALL                                                      \
    SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_UP, SCREEN_GLYPH_DOWN,                  \
        SCREEN_GLYPH_LOAD, SCREEN_GLYPH_DASH, SCREEN_GLYPH_BACK,               \
        SCREEN_GLYPH_IOTA, SCREEN_UNDERLINE

// -- Define button functions with specific names
#define BUTTON_FUNCTION(name)                                                  \
    static unsigned int bagl_ui_##name##_screen_button(                        \
        unsigned int button_mask, unsigned int button_mask_counter)            \
    {                                                                          \
        nano_transition_state(button_mask);                                    \
                                                                               \
        return 0;                                                              \
    }

#endif // S_ELEMENTS_H
