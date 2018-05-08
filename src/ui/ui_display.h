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

void display_init();
void display_welcome();
void display_about();
void display_version();
void display_more_info();
void display_idxs();
void display_addr();     // display pubkey on ledger
void display_addr_chk(); // display abbrv with chk
void display_tx_addr();  // display address in tx
void display_write_indexes();
void display_prompt_tx();
void display_warn_change();
void display_unknown_state();

#endif // UI_DISPLAY_H
