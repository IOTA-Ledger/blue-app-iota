#ifndef UI_H
#define UI_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>
#include <stdio.h>
#include <math.h>
#include "main.h"

#include "ui_types.h"
#include "ui_misc.h"
#include "ui_handling.h"

/* To create a new UI screen -
 - #define new STATE_ , incr TOTAL_STATES/STATE_EXIT [ui_types.h]
 - Define what to display (ui_build_display) [ui_handling.c]
 - Define state transitions (init_state_transitions) [ui.c]
 - Define special button functions (ui_handle_button) [ui_handling.c]
 
 - If scrollable menu screen, also do:
 - #define Size of Menu [ui_types.h]
 - Create msg to display [ui_misc.c]
 - Define behavior (ui_handle_menus) [ui_handling.c] */

void ui_render();
void ui_force_draw();

void ui_init(bool flash_is_init);

void ui_display_welcome();
void ui_display_calc();
void ui_display_recv();
void ui_display_sending();
void ui_display_address(char *a, uint8_t len);
void ui_sign_tx(int64_t b, int64_t p, const char *a, uint8_t len);

#endif // UI_H


