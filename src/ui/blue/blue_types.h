#ifndef BLUE_TYPES_H
#define BLUE_TYPES_H

#include <stdint.h>
#include "iota/bundle.h"

#define TX_TYPE_TEXT_LEN 24
#define ABBRV_VAL_TEXT_LEN 12
#define FULL_VAL_TEXT_LEN 26
#define BIP_TEXT_LEN 36

// Address chunks after being broken up
#define CHUNK1 0
#define CHUNK2 31
#define CHUNK3 62
#define CHUNK_CHK 84

#define TX_TYPE_SPLIT 8

// UI STATES
typedef enum {
    STATE_MAIN,
    STATE_SETTINGS,
    STATE_TX,
    STATE_RECV,
    STATE_SIGN
} UI_STATES_BLUE;

typedef struct UI_STATE_CTX_BLUE {

    // tx information
    int64_t val;

    char tx_type[TX_TYPE_TEXT_LEN]; // Output/Input[]/Change[]:

    char abbrv_val[ABBRV_VAL_TEXT_LEN]; // 1.566 Ki
    char full_val[FULL_VAL_TEXT_LEN];   // 1,566,091 i

    char addr[94];

    char bip32_path[BIP_TEXT_LEN];

    uint8_t state;
    uint8_t menu_idx;

} UI_STATE_CTX_BLUE;

extern UI_STATE_CTX_BLUE blue_ui_state;

#endif // BLUE_TYPES_H
