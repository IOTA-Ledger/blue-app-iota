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

#define TYPE_INT 1
#define TYPE_UINT 2
#define TYPE_STR 3

#define TOP_H 0
#define TOP 1
#define MID 2
#define BOT 3
#define BOT_H 4

#define BUTTON_L 0
#define BUTTON_R 1
#define BUTTON_B 2

#define BUTTON_BAD 255

// UI STATES
#define TOTAL_STATES 14
#define STATE_EXIT TOTAL_STATES

#define STATE_MENU_INIT 0
#define STATE_MENU_WELCOME 1
#define STATE_CALC 2
#define STATE_RECV 3
#define STATE_SEND 4
#define STATE_TX_BAL 5
#define STATE_TX_SPEND 6
#define STATE_TX_ADDR 7
#define STATE_TX_APPROVE 8
#define STATE_TX_DENY 9
#define STATE_MENU_DISP_ADDR 10
#define STATE_MENU_DISP_IDX 11
#define STATE_MENU_ADVANCED 12
#define STATE_MENU_BROWSER 13

// Size of Menu
#define MENU_INIT_LEN 5
#define MENU_WELCOME_LEN 6
#define MENU_DISP_ACCOUNTS_LEN 6
#define MENU_ADVANCED_LEN 2
#define MENU_BROWSER_LEN 2

/* To create a new UI screen -
 - #define new STATE_ here, incr TOTAL_STATES/STATE_EXIT
 - Define what to display (ui_display_state)
 - Define state transitions (init_state_transitions)
 - Define special button functions (ui_handle_button)

 - If scrollable menu screen:
        - #define Size of Menu
        - Create msg to display (ui_display_state)
        - Define behavior (ui_handle_text_array) */

void ui_init(bool first_run);
void ui_reset(void);
void ui_display_message(void *o, uint8_t sz, uint8_t t,
                      void *o2, uint8_t sz2, uint8_t t2,
                      void *o3, uint8_t sz3, uint8_t t3);

void ui_sign_tx(int64_t b, int64_t o, const char *a, uint8_t len);
void ui_display_welcome();
void ui_display_calc();
void ui_display_recv();
void ui_display_sending();
void ui_force_draw();

#endif // UI_H


