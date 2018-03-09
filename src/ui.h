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
#define TOP 1
#define MID 2
#define BOT 3

//UI STATES
#define TOTAL_STATES 4
#define STATE_EXIT 4

#define BUTTON_L 0
#define BUTTON_R 1
#define BUTTON_B 2

#define BUTTON_BAD 255

#define STATE_WELCOME 0
#define STATE_TX_SIGN 1
#define STATE_TX_BAL 1
#define STATE_TX_SPEND 2
#define STATE_TX_ADDR 3
#define STATE_TX_CALCULATING 4

void ui_init(void);
void ui_reset(void);
void ui_display_message(void *o, uint8_t sz, uint8_t t,
                      void *o2, uint8_t sz2, uint8_t t2,
                      void *o3, uint8_t sz3, uint8_t t3);

void ui_sign_tx(uint64_t b, uint64_t o, const char *a, uint8_t len);

#endif // UI_H


