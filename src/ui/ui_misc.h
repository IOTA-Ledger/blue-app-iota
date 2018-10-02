#ifndef UI_MISC_H
#define UI_MISC_H

#include <stdbool.h>
#include <stdint.h>
#include "ui_types.h"

void state_go(uint8_t state, uint8_t idx);
void state_return(uint8_t state, uint8_t idx);
void backup_state(void);
void restore_state(void);

void abbreviate_addr(char *dest, const char *src);
void write_display(const char *string, UI_TEXT_POS pos);

void glyph_on(UI_GLYPH_TYPES g);
void glyph_off(UI_GLYPH_TYPES g);

void clear_glyphs(void);
void clear_display(void);

void display_glyphs(UI_GLYPH_TYPES g1, UI_GLYPH_TYPES g2);
void display_glyphs_confirm(UI_GLYPH_TYPES g1, UI_GLYPH_TYPES g2);

void write_text_array(const char *array, uint8_t len);

void value_convert_readability(void);
uint8_t get_tx_arr_sz(void);
uint8_t menu_to_tx_idx(void);
void reenter_tx_info(uint8_t state);

void display_advanced_tx_value(void);
void display_advanced_tx_address(void);

#endif // UI_MISC_H
