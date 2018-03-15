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
#define TYPE_STR 2

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
#define STATE_TX_BAL 2
#define STATE_TX_PAY 3
#define STATE_TX_ADDR 4
#define STATE_TX_APPROVE 5
#define STATE_TX_DENY 6
#define STATE_MENU_DISP_IDX 7
#define STATE_MENU_ADVANCED 8
#define STATE_MENU_BROWSER 9
#define STATE_MENU_ADV_WARN 10
#define STATE_MENU_DISP_ADDR 11
#define STATE_MENU_TX_ADDR 12
#define STATE_DISP_ADDR_CHK 13

// Size of Menu
#define MENU_INIT_LEN 5
#define MENU_WELCOME_LEN 5
#define MENU_ACCOUNTS_LEN 6
#define MENU_ADVANCED_LEN 2
#define MENU_BROWSER_LEN 2
#define MENU_ADV_WARN_LEN 3
#define MENU_ADDR_LEN 7

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

void ui_render();
void ui_build_display();
void ui_display_welcome();
void ui_display_calc();
void ui_display_recv();
void ui_display_sending();
void ui_display_address(char *a, uint8_t len);
void ui_force_draw();

void ui_sign_tx(int64_t b, int64_t o, const char *a, uint8_t len);

#endif // UI_H


