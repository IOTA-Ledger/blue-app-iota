#include "kerl.h"
#include "conversion.h"
#include "os.h"
#include "cx.h"

//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
    return 0;
}

//absorbing trits happens in 243 trit chunks
int kerl_absorb_trits(trit_t *trits_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/243); i++) {
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        trits_to_words(trits_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
}


int kerl_squeeze_trits(trit_t trits_out[], uint16_t len)
{
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
    words_to_trits(words, trits_out);

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
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
    words_to_trints(words, &trints_out[0]);


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
