#ifndef NANOS_MISC_H
#define NANOS_MISC_H

#include <stdbool.h>
#include <stdint.h>
#include "nanos_types.h"

void state_go(uint8_t state, uint8_t idx);
void backup_state(void);
void restore_state(void);

void abbreviate_addr(char *dest, const char *src);
void write_display(const char *string, UI_TEXT_POS pos);

void glyph_on(UI_GLYPH_TYPES_NANOS g);

void clear_display(void);

void display_glyphs(UI_GLYPH_TYPES_NANOS g1, UI_GLYPH_TYPES_NANOS g2);
void display_glyphs_confirm(UI_GLYPH_TYPES_NANOS g1, UI_GLYPH_TYPES_NANOS g2);

void write_text_array(const char *array, uint8_t len);

void value_convert_readability(void);

void display_advanced_tx_value(void);
void display_advanced_tx_address(void);

uint8_t get_tx_arr_sz(void);

#endif // NANOS_MISC_H
