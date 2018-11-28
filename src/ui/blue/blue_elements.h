#ifndef BLUE_ELEMENTS_H
#define BLUE_ELEMENTS_H

// { {type, userid, x, y, width, height, stroke,
//    radius, fill, fgcolor, bgcolor, font_id, icon_id},
//   text, touch_area_brim, overfgcolor, overbgcolor, tap, out, over }

#define COLOUR_GREEN 0x005653
#define COLOUR_RED 0x6d0202
#define COLOUR_WHITE 0xf9f9f9
#define COLOUR_BLACK 0x000000
#define COLOUR_GREY 0x888888
#define COLOUR_DARK_GREY 0x666666
#define COLOUR_CHK 0x3c9fe0

#define COLOUR_LIGHT(colour) colour + 0x333333

#define _TOUCHABLE | BAGL_FLAG_TOUCHABLE
#define _CENTERED | BAGL_FONT_ALIGNMENT_CENTER
#define _RIGHT | BAGL_FONT_ALIGNMENT_RIGHT
#define _MIDDLE | BAGL_FONT_ALIGNMENT_MIDDLE

#define SYM(name) BAGL_FONT_SYMBOLS_0_##name
#define BUTTON(name) bagl_ui_##name##_blue_button

#define HEADER_FONT BAGL_FONT_OPEN_SANS_SEMIBOLD_11_16PX
#define DEFAULT_FONT_LG BAGL_FONT_OPEN_SANS_LIGHT_16_22PX
#define DEFAULT_FONT_MED BAGL_FONT_OPEN_SANS_REGULAR_11_14PX
#define DEFAULT_FONT_SM BAGL_FONT_OPEN_SANS_REGULAR_10_13PX

#define OPEN_TITLE "Open IOTA Wallet"

#define OPEN_MSG1 "Connect the Ledger Blue and open your"
#define OPEN_MSG2 "preferred wallet to view your accounts."

#define MORE_INFO_TXT "Please visit iota.org/sec for more info."

#define ADDR1 "ADLJXS9SKYQKMVQFXR9JDUUJHJWGDN"
#define ADDR2 "WHQZMDGJFGZOX9BZEKDSXBSPZTTWEY"
#define ADDR3 "PTNM9OZMYDQWZXFHRTXRC"
#define ADDR_CHK "OITXAGCJZ"

#define HEADER_BG_FILL                                                         \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,         0, 20, 320, 48, 0, 0, BAGL_FILL,        \
         COLOUR_GREEN,   COLOUR_GREEN, 0, 0},                                  \
            NULL, 0, 0, 0, NULL, NULL, NULL,                                   \
    }

#define HEADER_BUTTON(x, sym, callback)                                        \
    {                                                                          \
        {BAGL_RECTANGLE _TOUCHABLE,                                            \
         0x00,                                                                 \
         x,                                                                    \
         34,                                                                   \
         56,                                                                   \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         BAGL_FILL,                                                            \
         COLOUR_GREEN,                                                         \
         COLOUR_WHITE,                                                         \
         BAGL_FONT_SYMBOLS_0 _CENTERED,                                        \
         0},                                                                   \
            sym, 0, COLOUR_GREEN, COLOUR_GREY, callback, NULL, NULL,           \
    }

#define HEADER_TEXT(txt)                                                       \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         0,                                                                    \
         48,                                                                   \
         320,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_WHITE,                                                         \
         COLOUR_GREEN,                                                         \
         HEADER_FONT _CENTERED,                                                \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define BODY_BG_FILL                                                           \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,         0, 68, 320, 412, 0, 0, BAGL_FILL,       \
         COLOUR_WHITE,   COLOUR_WHITE, 0, 0},                                  \
            NULL, 0, 0, 0, NULL, NULL, NULL,                                   \
    }

#define BODY_IOTA_ICON                                                         \
    {                                                                          \
        {BAGL_ICON, 0x00,      135,          178,          50, 50, 0,          \
         0,         BAGL_FILL, COLOUR_WHITE, COLOUR_GREEN, 0,  0},             \
            (const char *)&C_blue_badge_iota, 0, 0, 0, NULL, NULL, NULL,       \
    }

#define BODY_TITLE(txt)                                                        \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         0,                                                                    \
         270,                                                                  \
         320,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_BLACK,                                                         \
         COLOUR_WHITE,                                                         \
         DEFAULT_FONT_LG _CENTERED,                                            \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define TEXT_CENTERED(y, txt)                                                  \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         0,                                                                    \
         y,                                                                    \
         320,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_BLACK,                                                         \
         COLOUR_WHITE,                                                         \
         DEFAULT_FONT_SM _CENTERED,                                            \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define TEXT_LEFT_TITLE(y, txt)                                                \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         30,                                                                   \
         y,                                                                    \
         290,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_BLACK,                                                         \
         COLOUR_WHITE,                                                         \
         DEFAULT_FONT_MED,                                                     \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define TEXT_LEFT_TITLE_LG(y, txt)                                             \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         30,                                                                   \
         y,                                                                    \
         290,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_BLACK,                                                         \
         COLOUR_WHITE,                                                         \
         DEFAULT_FONT_LG,                                                      \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define TEXT_LEFT(y, txt)                                                      \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         38,                                                                   \
         y,                                                                    \
         282,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_BLACK,                                                         \
         COLOUR_WHITE,                                                         \
         DEFAULT_FONT_SM,                                                      \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define TEXT_RIGHT(y, txt)                                                     \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         38,                                                                   \
         y,                                                                    \
         244,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_BLACK,                                                         \
         COLOUR_WHITE,                                                         \
         DEFAULT_FONT_MED _RIGHT,                                              \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define TEXT_CHK(y, txt)                                                       \
    {                                                                          \
        {BAGL_LABELINE,                                                        \
         0x00,                                                                 \
         38,                                                                   \
         y,                                                                    \
         244,                                                                  \
         30,                                                                   \
         0,                                                                    \
         0,                                                                    \
         0,                                                                    \
         COLOUR_CHK,                                                           \
         COLOUR_WHITE,                                                         \
         DEFAULT_FONT_SM _CENTERED,                                            \
         0},                                                                   \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define BLUE_UI_BUTTON(colour, txt, x, y, callback)                            \
    {                                                                          \
        {BAGL_BUTTON _TOUCHABLE,                                               \
         0x00,                                                                 \
         x,                                                                    \
         y,                                                                    \
         120,                                                                  \
         40,                                                                   \
         0,                                                                    \
         6,                                                                    \
         BAGL_FILL,                                                            \
         COLOUR_LIGHT(colour),                                                 \
         COLOUR_WHITE,                                                         \
         BAGL_FONT_OPEN_SANS_LIGHT_14px _CENTERED _MIDDLE,                     \
         0},                                                                   \
            txt, 0, colour, COLOUR_WHITE, callback, NULL, NULL,                \
    }

#define HEADER_BUTTON_L(l_b) HEADER_BUTTON(0, SYM(l_b), BUTTON(l_b))
#define HEADER_BUTTON_R(r_b) HEADER_BUTTON(264, SYM(r_b), BUTTON(r_b))

#define BG_FILL HEADER_BG_FILL, BODY_BG_FILL

#endif // BLUE_ELEMENTS_H
