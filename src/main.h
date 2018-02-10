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
#define BOT 2

// data starts at apdu[5]
#define APDU_HEADER_LENGTH 5
// defines byte that says length
#define APDU_BODY_LENGTH_OFFSET 4

#define CLA 0x80

#define INS_GET_PUBKEY 0x01
#define INS_BAD_PUBKEY 0x02
#define INS_GOOD_PUBKEY 0x4
#define INS_CHANGE_INDEX 0x08
#define INS_SIGN 0x10

#define P1_LAST 0x80
#define P1_MORE 0x00


extern cx_sha256_t hash;
extern unsigned char hashTainted;     // notification to restart the hash

extern unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];
extern ux_state_t ux;


unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len);
void io_seproxyhal_display(const bagl_element_t *element);
unsigned char io_event(unsigned char channel);
bool nvram_is_init();


#endif // MAIN_H

