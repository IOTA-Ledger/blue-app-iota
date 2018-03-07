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

#define TYPE_INT 1
#define TYPE_UINT 2
#define TYPE_STR 3
#define TOP 1
#define MID 2
#define BOT 3

// data starts at apdu[5]
#define APDU_HEADER_LENGTH 5
// defines byte that says length
#define APDU_BODY_LENGTH_OFFSET 4
#define APDU_TX_TYPE 3
#define APDU_MORE 2


// Error codes
#define INCOMPLETE_TX 0x6D18
#define UNKNOWN_TX_TYPE 0x6D00
#define LAST_IDX_ERROR 0x6D04
#define IDX_OUT_OF_ORDER 0x6D08
#define UNBALANCED_TX 0x6D10
#define TEST_ERROR 0x9876
#define BAD_ADDR 0x6D22
#define NO_SEED_IDX 0x6D28


#define LEDGER_MSG "LEDGER"

extern unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];
extern ux_state_t ux;


unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len);
void io_seproxyhal_display(const bagl_element_t *element);
unsigned char io_event(unsigned char channel);


#endif // MAIN_H
