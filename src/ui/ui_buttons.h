#ifndef UI_BUTTONS_H
#define UI_BUTTONS_H

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

uint8_t button_init(uint8_t button_mask);
uint8_t button_welcome(uint8_t button_mask);
uint8_t button_advanced(uint8_t button_mask);
uint8_t button_adv_warn(uint8_t button_mask);
uint8_t button_disp_idx(uint8_t button_mask);
uint8_t button_disp_addr(uint8_t button_mask);
uint8_t button_disp_addr_chk(uint8_t button_mask);
uint8_t button_tx_addr(uint8_t button_mask);
uint8_t button_init_ledger(uint8_t button_mask);
uint8_t button_warn_change(uint8_t button_mask);
void button_prompt_tx(uint8_t button_mask);
void button_handle_menu_idx(uint8_t button_mask, uint8_t array_sz);

#endif // UI_BUTTONS_H
