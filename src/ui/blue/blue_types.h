#ifndef BLUE_TYPES_H
#define BLUE_TYPES_H

#include <stdint.h>
#include "iota/bundle.h"

// UI STATES
typedef enum { STATE_MAIN, STATE_SETTINGS, STATE_TX } UI_STATES_BLUE;

typedef struct UI_STATE_CTX_BLUE {

    // tx information
    int64_t val;

    char addr[90];

    uint8_t state;
    uint8_t menu_idx;

} UI_STATE_CTX_BLUE;

extern UI_STATE_CTX_BLUE blue_ui_state;

#endif // BLUE_TYPES_H
