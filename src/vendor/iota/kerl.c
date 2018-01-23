#include "kerl.h"
#include "conversion.h"
#include "os.h"
#include "cx.h"

//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char sha3_bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, sha3_bytes_out);
    return 0;
}

int kerl_finalize(unsigned char *bytes_out, uint16_t len)
{
    memcpy(bytes_out, sha3_bytes_out, len);
    return 0;
}

uint32_t change_endianess(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

//absorbing trits happens in 243 trit chunks
int kerl_absorb_trits(trit_t *trits_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/243); i++) {
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        trits_to_words_u(trits_in, words);

        // swap endianness on little-endian hardware
        for(uint8_t i=0; i<12; i++) {
            words[i] = change_endianess(words[i]);
        }
        memcpy(bytes, words, 48);
        // words_to_bytes(words, bytes, 12);

        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
}


int kerl_squeeze_trits(trit_t trits_out[], uint16_t len)
{
    unsigned char bytes_out[48];
    int32_t words[12];

    kerl_finalize(bytes_out, 48);

    // swap endianness on little-endian hardware
    memcpy(words, bytes_out, 48);
    for(uint8_t i=0; i<12; i++) {
        words[i] = change_endianess(words[i]);
    }
    // bytes_to_words(bytes_out, words, 12);

    words_to_trits_u(words, trits_out);

    // Last trit zero
    trits_out[242] = 0;

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
        // First, convert to bytes
        uint32_t words[12];
        memset(words, 0, sizeof(words));
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words_u_mem(trints_in, words);

        // swap endianness on little-endian hardware
        for(uint8_t i=0; i<12; i++) {
            words[i] = change_endianess(words[i]);
        }
        memcpy(bytes, words, 48);
        // words_to_bytes(words, bytes, 12);

        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len)
{
    unsigned char bytes_out[48];
    int32_t words[12];

    kerl_finalize(bytes_out, 48);

    // swap endianness on little-endian hardware
    memcpy(words, bytes_out, 48);
    for(uint8_t i=0; i<12; i++) {
        words[i] = change_endianess(words[i]);
    }
    // bytes_to_words(bytes_out, words, 12);

    words_to_trints_u_mem(words, &trints_out[0]);

    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
    trits[2] = 0; //set last trit to 0
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
}
