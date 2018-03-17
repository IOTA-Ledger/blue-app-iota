#ifndef UI_MISC_H
#define UI_MISC_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>
#include <stdio.h>
#include <math.h>
#include "main.h"

#include "ui_types.h"

void state_go(uint8_t state, uint8_t idx);
void state_return(uint8_t state, uint8_t idx);

void abbreviate_addr(char *dest, const char *src, uint8_t len);
void write_display(void *o, uint8_t type, uint8_t pos);

void glyph_on(char *c);
void glyph_off(char *c);

void clear_glyphs();
void clear_display();

void display_glyphs(char *c1, char *c2);
void display_glyphs_confirm(char *c1, char *c2);

void write_text_array(char *array, uint8_t len);

bool display_value(int64_t val, uint8_t str_defn);
void value_convert_readability();

// Menu creation
void get_init_menu(char *msg);
void get_welcome_menu(char *msg);
void get_disp_idx_menu(char *msg);
void get_advanced_menu(char *msg);
void get_browser_menu(char *msg);
void get_adv_warn_menu(char *msg);
void get_address_menu(char *msg);

#endif // UI_MISC_H


