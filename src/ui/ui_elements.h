#ifndef UI_SCREEN_DEFN_H
#define UI_SCREEN_DEFN_H


// {type, userid, x, y, width, height, stroke, radius, fill,
// fgcolor, bgcolor, fontid, iconid}, text .....

// -- Clear screen
#define SCREEN_CLEAR \
{{BAGL_RECTANGLE, 0x00, 0, 0, 128, 32, 0, 0, BAGL_FILL, 0x000000, 0xFFFFFF, \
0, 0}, NULL, 0, 0, 0, NULL, NULL, NULL}

// -- Title screen top message
#define SCREEN_MSG_TOP \
{{BAGL_LABELINE, 0x01, 0, 13, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000, \
BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0}, \
ui_text.top_str, 0, 0, 0, NULL, NULL, NULL}

// -- Title screen bottom message
#define SCREEN_MSG_BOT \
{{BAGL_LABELINE, 0x01, 0, 25, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000, \
BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0}, \
ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL}

// -- Menu screen top message half off screen
#define SCREEN_MSG_TOP_OFF \
{{BAGL_LABELINE, 0x01, 0, 3, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000, \
BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0}, \
ui_text.top_str, 0, 0, 0, NULL, NULL, NULL}

// -- Menu screen middle message
#define SCREEN_MSG_MID \
{{BAGL_LABELINE, 0x01, 0, 19, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000, \
BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 0}, \
ui_text.mid_str, 0, 0, 0, NULL, NULL, NULL}

// -- Menu screen bot message half off screen
#define SCREEN_MSG_BOT_OFF \
{{BAGL_LABELINE, 0x01, 0, 36, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000, \
BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0}, \
ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL},

// -- Confirm bars along top
#define SCREEN_ICON_CONFIRM \
{{BAGL_ICON, 0x00, 3, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, \
BAGL_GLYPH_ICON_LESS}, &ui_glyphs.glyph[GLYPH_CONFIRM], 0, 0, 0, NULL, NULL, NULL}, \
\
{{BAGL_ICON, 0x00, 117, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, \
BAGL_GLYPH_ICON_LESS}, &ui_glyphs.glyph[GLYPH_CONFIRM], 0, 0, 0, NULL, NULL, NULL}

// -- Cross on left
#define SCREEN_ICON_CROSS \
{{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0, \
BAGL_GLYPH_ICON_CROSS}, &ui_glyphs.glyph[GLYPH_CROSS], 0, 0, 0, NULL, NULL, NULL}

// -- Checkmark on right
#define SCREEN_ICON_CHECK \
{{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, \
BAGL_GLYPH_ICON_CHECK}, &ui_glyphs.glyph[GLYPH_CHECK], 0, 0, 0, NULL, NULL, NULL}

// -- Up arrow on left
#define SCREEN_ICON_UP \
{{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0, \
BAGL_GLYPH_ICON_UP}, &ui_glyphs.glyph[GLYPH_UP], 0, 0, 0, NULL, NULL, NULL}

// -- Down arrow on right
#define SCREEN_ICON_DOWN \
{{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, \
BAGL_GLYPH_ICON_DOWN}, &ui_glyphs.glyph[GLYPH_DOWN], 0, 0, 0, NULL, NULL, NULL}

// -- Warning icon on left
#define SCREEN_ICON_WARN \
{{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, \
BAGL_GLYPH_ICON_WARNING_BADGE}, &ui_glyphs.glyph[GLYPH_WARN], 0, 0, 0, NULL, NULL, NULL}

// -- Loading icon on left
#define SCREEN_ICON_LOAD \
{{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, \
BAGL_GLYPH_ICON_LOADING_BADGE}, &ui_glyphs.glyph[GLYPH_LOAD], 0, 0, 0, NULL, NULL, NULL}

// -- Dashboard icon on left
#define SCREEN_ICON_DASH \
{{BAGL_ICON, 0x00, 24, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, \
BAGL_GLYPH_ICON_DASHBOARD_BADGE}, &ui_glyphs.glyph[GLYPH_DASH], 0, 0, 0, NULL, NULL, NULL}

// -- Define all screen glyphs
#define SCREEN_ICONS_ALL \
SCREEN_ICON_CONFIRM, SCREEN_ICON_CROSS, SCREEN_ICON_CHECK, SCREEN_ICON_UP, \
SCREEN_ICON_DOWN, SCREEN_ICON_WARN, SCREEN_ICON_LOAD, SCREEN_ICON_DASH


#endif // UI_SCREEN_DEFN_H
