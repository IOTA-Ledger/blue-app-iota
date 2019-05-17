#ifndef BLUE_TYPES_H
#define BLUE_TYPES_H

#include <stdint.h>
#include "iota/bundle.h"

#define TEXT_LEN_TX_TYPE 24
#define TEXT_LEN_VALUE_ABBREV 12
#define TEXT_LEN_VALUE_FULL 26
#define TEXT_LEN_BIP_PATH 36

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

    char tx_type[TEXT_LEN_TX_TYPE]; // Output/Input[]/Change[]:

    char abbrv_val[TEXT_LEN_VALUE_ABBREV]; // 1.566 Ki
    char full_val[TEXT_LEN_VALUE_FULL];    // 1,566,091 i

    char addr[94];

    char bip32_path[TEXT_LEN_BIP_PATH];

    uint8_t state;
    uint8_t menu_idx;

} UI_STATE_CTX_BLUE;

extern UI_STATE_CTX_BLUE blue_ui_state;

#endif // BLUE_TYPES_H
