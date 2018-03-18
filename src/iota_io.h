#ifndef IOTA_IO_H
#define IOTA_IO_H

void io_initialize();
void io_send(const void *ptr, unsigned int length, unsigned short sw);
unsigned int iota_dispatch();

#define CLA 0x80

/* ---  INS  --- */

#define INS_NONE        0x00

#define INS_SET_SEED    0x01
#define INS_PUBKEY      0x02
#define INS_TX          0x03
#define INS_SIGN        0x04
#define INS_DISP_ADDR   0x05

/* ---  IO constants  --- */

#define OFFSET_CLA               0
#define OFFSET_INS               1
#define OFFSET_P1                2
#define OFFSET_P2                3
#define OFFSET_P3                4
#define OFFSET_CDATA             5

#define SW_OK                    0x9000

#define SW_WRONG_LENGTH          0x6700

#define SW_SECURITY_STATUS_NOT_SATISFIED 0x6982

#define SW_WRONG_P1P2            0x6b00
#define SW_INCORRECT_LENGTH_P3   0x6c00
#define SW_INS_NOT_SUPPORTED     0x6d00
#define SW_CLA_NOT_SUPPORTED     0x6e00
#define SW_COMMAND_NOT_ALLOWED   0x6900
#define SW_COMMAND_INVALID_DATA  0x6984
#define SW_COMMAND_INVALID_STATE 0x6985
#define SW_APP_NOT_INITIALIZED   0x6986

#define SW_UNKNOWN               0x6f00

#endif // IOTA_IO_H
