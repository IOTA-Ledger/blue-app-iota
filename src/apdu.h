#ifndef APDU_H
#define APDU_H

#include "iota/signing.h"

#define CHECK_STATE(state, INS) ( \
                (((state) & INS ## _REQUIRED_STATE) != INS ## _REQUIRED_STATE) \
                || ((state) & INS ## _FORBIDDEN_STATE))

#define CLA 0x80

// Instructions
#define INS_SET_SEED 0x01
#define INS_PUBKEY 0x02
#define INS_TX 0x03
#define INS_SIGN 0x04

// states
#define SEED_SET (1 << 0)
#define BUNDLE_INITIALIZED (1 << 1)
#define BUNDLE_FINALIZED (1 << 2)
#define SIGNING_STARTED (1 << 3)

#define SET_SEED_REQUIRED_STATE 0
#define SET_SEED_FORBIDDEN_STATE 0

typedef struct __attribute__((__packed__)) SET_SEED_INPUT {
        int64_t bip44_path[BIP44_PATH_LEN];
} SET_SEED_INPUT;

// no SET_SEED_OUTPUT

#define PUBKEY_REQUIRED_STATE (SEED_SET)
#define PUBKEY_FORBIDDEN_STATE 0

typedef struct __attribute__((__packed__)) PUBKEY_INPUT {
        int64_t address_idx;
        // int64_t security; // use hard-coded security for now
} PUBKEY_INPUT;

typedef struct __attribute__((__packed__)) PUBKEY_OUTPUT {
        char address[81];
} PUBKEY_OUTPUT;

#define TX_REQUIRED_STATE (SEED_SET)
#define TX_FORBIDDEN_STATE (BUNDLE_FINALIZED)

typedef struct __attribute__((__packed__)) TX_INPUT {
        char address[81];
        int64_t address_idx;
        int64_t value;
        char tag[27];
        int64_t current_index;
        int64_t last_index;
        int64_t timestamp;
} TX_INPUT;

typedef struct __attribute__((__packed__)) TX_OUTPUT {
        bool finalized;
        int64_t tag_increment;
        char bundle_hash[81];
} TX_OUTPUT;

#define SIGN_REQUIRED_STATE (SEED_SET | BUNDLE_FINALIZED)
#define SIGN_FORBIDDEN_STATE 0

typedef struct __attribute__((__packed__)) SIGN_INPUT {
        int64_t transaction_idx;
        // int64_t security; // use hard-coded security for now
} SIGN_INPUT;

typedef struct __attribute__((__packed__)) SIGN_OUTPUT {
        char signature_fragment[SIGNATURE_FRAGMENT_SIZE * 81];
        uint32_t fragment_index;
        uint32_t last_fragment;
} SIGN_OUTPUT;

#endif // APDU_H
