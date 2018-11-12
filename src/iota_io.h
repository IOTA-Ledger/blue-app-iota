#ifndef IOTA_IO_H
#define IOTA_IO_H

#define BIP32_PATH_MIN_LEN 2
#define BIP32_PATH_MAX_LEN 5

void io_initialize(void);
void io_send(const void *ptr, unsigned int length, unsigned short sw);
unsigned int iota_dispatch(void);

/* ---  CLA  --- */

#define CLA 0x7A

/* ---  INS  --- */

#define INS_NONE 0x00

#define INS_PUBKEY 0x02
#define INS_TX 0x03
#define INS_SIGN 0x04

#define INS_GET_APP_CONFIG 0x10

#define INS_RESET 0xFF

/* ---  P1  --- */

#define P1_RESET_EVERYTHING 0x00
#define P1_RESET_PARTIAL 0x01

#define P1_PUBKEY_NO_DISPLAY 0x00
#define P1_PUBKEY_DISPLAY 0x01

/* ---  IO constants  --- */

#define OFFSET_CLA 0
#define OFFSET_INS 1
#define OFFSET_P1 2
#define OFFSET_P2 3
#define OFFSET_P3 4
#define OFFSET_CDATA 5

#define SW_OK 0x9000

#define SW_INCORRECT_LENGTH 0x6700

#define SW_SECURITY_STATUS_NOT_SATISFIED 0x6982
#define SW_CONDITIONS_OF_USE_NOT_SATISFIED 0x6985
#define SW_SECURITY_APP_LOCKED 0x6983

#define SW_INCORRECT_DATA 0x6a80

#define SW_WRONG_P1P2 0x6b00
#define SW_INCORRECT_LENGTH_P3 0x6c00
#define SW_INS_NOT_SUPPORTED 0x6d00
#define SW_CLA_NOT_SUPPORTED 0x6e00
#define SW_COMMAND_NOT_ALLOWED 0x6900
#define SW_COMMAND_INVALID_DATA 0x6984
#define SW_COMMAND_INVALID_STATE 0x6985
#define SW_BAD_SEED 0x6987

#define SW_TX_INVALID_INDEX 0x6991
#define SW_TX_INVALID_ORDER 0x6992
#define SW_TX_INVALID_META 0x6993
#define SW_TX_INVALID_OUTPUT 0x6994

#define SW_BUNDLE_ERROR 0x69a0

#define SW_UNKNOWN 0x6f00

#endif // IOTA_IO_H
