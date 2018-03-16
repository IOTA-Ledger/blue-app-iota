#ifndef API_H
#define API_H

#include "main.h"
#include "iota/signing.h"

#define CLA 0x80

// Instructions
#define INS_SET_SEED 0x01
#define INS_PUBKEY 0x02
#define INS_TX 0x03
#define INS_SIGN 0x04


// state bit flags
#define SEED_SET (1 << 0)
#define BUNDLE_INITIALIZED (1 << 1)
#define BUNDLE_FINALIZED (1 << 2)
#define SIGNING_STARTED (1 << 3)

#define IO_STRUCT struct __attribute__((packed, may_alias))

#define SET_SEED_REQUIRED_STATE 0
#define SET_SEED_FORBIDDEN_STATE 0

typedef IO_STRUCT SET_SEED_INPUT {
        int64_t bip44_path[BIP44_PATH_LEN];
        int64_t security;
} SET_SEED_INPUT;

// no SET_SEED_OUTPUT

#define PUBKEY_REQUIRED_STATE (SEED_SET)
#define PUBKEY_FORBIDDEN_STATE 0

typedef IO_STRUCT PUBKEY_INPUT {
        int64_t address_idx;
} PUBKEY_INPUT;

typedef IO_STRUCT PUBKEY_OUTPUT {
        char address[81];
} PUBKEY_OUTPUT;

#define TX_REQUIRED_STATE (SEED_SET)
#define TX_FORBIDDEN_STATE (BUNDLE_FINALIZED)

typedef IO_STRUCT TX_INPUT {
        char address[81];
        int64_t address_idx;
        int64_t value;
        char tag[27];
        int64_t current_index;
        int64_t last_index;
        int64_t timestamp;
} TX_INPUT;

typedef IO_STRUCT TX_OUTPUT {
        bool finalized;
        char bundle_hash[81];
} TX_OUTPUT;

#define SIGN_REQUIRED_STATE (SEED_SET | BUNDLE_FINALIZED)
#define SIGN_FORBIDDEN_STATE 0

typedef IO_STRUCT SIGN_INPUT {
        int64_t transaction_idx;
} SIGN_INPUT;

typedef IO_STRUCT SIGN_OUTPUT {
        char signature_fragment[SIGNATURE_FRAGMENT_SIZE * 81];
        bool fragments_remaining;
} SIGN_OUTPUT;


void api_initialize();

unsigned int api_set_seed(unsigned char *input_data, unsigned int len);
unsigned int api_pubkey(unsigned char *input_data, unsigned int len);
unsigned int api_tx(unsigned char *input_data, unsigned int len);
unsigned int api_sign(unsigned char *input_data, unsigned int len);

#endif // API_H
