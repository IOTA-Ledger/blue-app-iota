#ifndef UI_MISC_H
#define UI_MISC_H

#include <stdbool.h>
#include <stdint.h>
#include "ui_types.h"

void state_go(uint8_t state, uint8_t idx);
void state_return(uint8_t state, uint8_t idx);
void backup_state(void);
void set_backup(uint8_t state, uint8_t menu_idx);
void restore_state(void);

void abbreviate_addr(char *dest, const char *src, uint8_t len);
void write_display(void *o, uint8_t type, UI_TEXT_POS pos);

int8_t int_to_str(int64_t num, char *str, uint8_t len, uint8_t radix);

void glyph_on(char *c);
void glyph_off(char *c);

void clear_glyphs(void);
void clear_display(void);

void display_glyphs(char *c1, char *c2);
void display_glyphs_confirm(char *c1, char *c2);

void write_text_array(char *array, uint8_t len);

uint8_t get_num_digits(int64_t val);
void value_convert_readability(void);
uint8_t get_tx_arr_sz(void);
uint8_t menu_to_tx_idx(void);
void reenter_tx_info(uint8_t state);

void display_advanced_tx_value(void);
void display_advanced_tx_address(void);

// Menu creation
void get_init_menu(char *msg);
void get_welcome_menu(char *msg);
void get_about_menu(char *msg);
void get_more_info_menu(char *msg);
void get_address_menu(char *msg);

#endif // UI_MISC_H
