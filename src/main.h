#ifndef MAIN_H
#define MAIN_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>
#include <stdio.h>
#include <math.h>

#define BIP44_PATH_LEN 5
#define BIP44_BYTE_LENGTH (BIP44_PATH_LEN * sizeof(unsigned int))
#define BIP44_ACCOUNT 4

#define TYPE_INT 1
#define TYPE_UINT 2
#define TYPE_STR 3

#define TOP_H 0
#define TOP 1
#define MID 2
#define BOT 3
#define BOT_H 4

#define LEDGER_MSG "LEDGER"
#define DEBUG_SEED "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR"

extern unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];
extern ux_state_t ux;


unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len);
void io_seproxyhal_display(const bagl_element_t *element);
unsigned char io_event(unsigned char channel);

void user_sign();
void user_deny();
uint32_t get_seed_idx(unsigned int idx);
uint8_t get_advanced_mode();
uint8_t get_browser_mode();
void write_advanced_mode(uint8_t mode);
void write_browser_mode(uint8_t mode);

#endif // MAIN_H
