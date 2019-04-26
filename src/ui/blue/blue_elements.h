#ifndef BLUE_ELEMENTS_H
#define BLUE_ELEMENTS_H

// { {type, userid, x, y, width, height, stroke,
//    radius, fill, fgcolor, bgcolor, font_id, icon_id},
//   text, touch_area_brim, overfgcolor, overbgcolor, tap, out, over }

#define COLOUR_GREEN 0x005653
#define COLOUR_RED 0x570000
#define COLOUR_WHITE 0xf9f9f9
#define COLOUR_BLACK 0x000000
#define COLOUR_GREY 0x888888
#define COLOUR_DARKGREY 0x666666
#define COLOUR_SKYBLUE 0x3c9fe0

#define COLOUR_LIGHT(colour) colour + 0x333333

#define _TOUCHABLE | BAGL_FLAG_TOUCHABLE
#define _LEFT | BAGL_FONT_ALIGNMENT_LEFT
#define _CENTERED | BAGL_FONT_ALIGNMENT_CENTER
#define _RIGHT | BAGL_FONT_ALIGNMENT_RIGHT
#define _MIDDLE | BAGL_FONT_ALIGNMENT_MIDDLE

#define SYM(name) BAGL_FONT_SYMBOLS_0_##name
#define BUTTON(name) bagl_ui_##name##_blue_button

#define HEADER_FONT BAGL_FONT_OPEN_SANS_SEMIBOLD_11_16PX
#define FONT_L BAGL_FONT_OPEN_SANS_LIGHT_16_22PX
#define FONT_M BAGL_FONT_OPEN_SANS_REGULAR_11_14PX
#define FONT_S BAGL_FONT_OPEN_SANS_REGULAR_10_13PX
#define FONT_XS BAGL_FONT_OPEN_SANS_REGULAR_8_11PX

#define _Y(y) y
#define _X(x) x

#define _TAB 8

#define OPEN_TITLE "Open IOTA Wallet"

#define OPEN_MESSAGE1 "Connect the Ledger Blue and open your"
#define OPEN_MESSAGE2 "preferred wallet to view your accounts."
#define OPEN_MESSAGE3 "Validation requests will show automatically."

#define MORE_INFO_TXT "Please visit iota.org/sec for more info."

#define SETTINGS_FOOTER1 "Visit the official IOTA discord"
#define SETTINGS_FOOTER2 "if you have questions or suggestions."

#define FILL_AREA(x, y, w, h, colour_fg, colour_bg)                            \
    {                                                                          \
        {BAGL_RECTANGLE, 0x00,      x,         y, w, h, 0, 0,                  \
         BAGL_FILL,      colour_fg, colour_bg, 0, 0},                          \
            NULL, 0, 0, 0, NULL, NULL, NULL,                                   \
    }

#define HEADER_BG_FILL FILL_AREA(0, 20, 320, 48, COLOUR_GREEN, COLOUR_GREEN)
#define BODY_BG_FILL FILL_AREA(0, 68, 320, 412, COLOUR_WHITE, COLOUR_WHITE)

#define BG_FILL HEADER_BG_FILL, BODY_BG_FILL

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

#define HEADER_BUTTON_L(l_b) HEADER_BUTTON(0, SYM(l_b), BUTTON(l_b))
#define HEADER_BUTTON_R(r_b) HEADER_BUTTON(264, SYM(r_b), BUTTON(r_b))

#define BODY_IOTA_ICON                                                         \
    {                                                                          \
        {BAGL_ICON, 0x00,      135,          178,          50, 50, 0,          \
         0,         BAGL_FILL, COLOUR_WHITE, COLOUR_GREEN, 0,  0},             \
            (const char *)&C_blue_badge_iota, 0, 0, 0, NULL, NULL, NULL,       \
    }

#define BODY_BUTTON(txt, x, y, colour, callback)                               \
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
         FONT_M _CENTERED _MIDDLE,                                             \
         0},                                                                   \
            txt, 0, colour, COLOUR_WHITE, callback, NULL, NULL,                \
    }

#define TEXT_EL(txt, x, y, w, h, colour_fg, colour_bg, font, pos)              \
    {                                                                          \
        {BAGL_LABELINE, 0x00,      x,        y, w, h, 0, 0, 0,                 \
         colour_fg,     colour_bg, font pos, 0},                               \
            txt, 0, 0, 0, NULL, NULL, NULL,                                    \
    }

#define HEADER_TEXT(txt)                                                       \
    TEXT_EL(txt, 0, 48, 320, 20, COLOUR_WHITE, COLOUR_GREEN, HEADER_FONT,      \
            _CENTERED)

#define TEXT_CENTER(txt, y, colour, font)                                      \
    TEXT_EL(txt, 30, y, 260, 20, colour, COLOUR_WHITE, font, _CENTERED)

#define TEXT_LEFT(txt, y, colour, font)                                        \
    TEXT_EL(txt, 30, y, 260, 20, colour, COLOUR_WHITE, font, _LEFT)

#define TEXT_LEFT_TAB(txt, y, colour, font)                                    \
    TEXT_EL(txt, 30 + _TAB, y, 260, 20, colour, COLOUR_WHITE, font, _LEFT)

#define TEXT_RIGHT(txt, y, colour, font)                                       \
    TEXT_EL(txt, 30, y, 260, 20, colour, COLOUR_WHITE, font, _RIGHT)

#endif // BLUE_ELEMENTS_H
