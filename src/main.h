#ifndef MAIN_H
#define MAIN_H

#include <stdbool.h>
#include <stdio.h>
#include <math.h>

// IOTA-Related APIs
#define INS_GET_PUBKEY 0x01
#define INS_BAD_PUBKEY 0x02
#define INS_GOOD_PUBKEY 0x04
#define INS_CHANGE_INDEX 0x08
#define INS_SIGN 0x10
#define INS_GET_MULTI_SEND 0x20

//very last chunk or will there be more?
#define TX_MORE 0x00
#define TX_END 0x01

#define TX_ADDR 0x01
#define TX_VAL 0x02
#define TX_TAG 0x04
#define TX_TIME 0x08
#define TX_CUR 0x10
#define TX_LAST 0x20

// all of the fields for the tx are filled
#define TX_FULL 0x3F
// end IOTA-Related APIs


#endif // MAIN_H
