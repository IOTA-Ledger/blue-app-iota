#ifndef UI_DISPLAY_H
#define UI_DISPLAY_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>
#include <stdio.h>
#include <math.h>
#include "../storage.h"
#include "../api.h"

#include "ui_types.h"
#include "ui_misc.h"

void display_menu_init();
void display_menu_welcome();
void display_menu_advanced();
void display_menu_adv_warn();
void display_menu_disp_idx();
void display_menu_disp_addr();
void display_addr_chk();
void display_menu_tx_addr();
void display_init_ledger();
void display_prompt_tx();
void display_unknown_state();

#endif // UI_DISPLAY_H
