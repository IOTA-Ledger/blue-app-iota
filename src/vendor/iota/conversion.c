#include "conversion.h"
#include "bigint.h"

#include <stdio.h>

static unsigned char bytes_out[48] = {0};

#define INT_LENGTH 12

static const uint32_t HALF_3_u[12] = {
                              0xa5ce8964,
                              0x9f007669,
                              0x1484504f,
                              0x3ade00d9,
                              0x0c24486e,
                              0x50979d57,
                              0x79a4c702,
                              0x48bbae36,
                              0xa9f6808b,
                              0xaa06a805,
                              0xa87fabdf,
                              0x5e69ebef
                        };


static const int32_t HALF_3[13] = { 0xF16B9C2D,
    0xDD01633C,
    0x3D8CF0EE,
    0xB09A028B,
    0x246CD94A,
    0xF1C6D805,
    0x6CEE5506,
    0xDA330AA3,
    0xFDE381A1,
    0xFE13F810,
    0xF97f039E,
    0x1B3DC3CE,
    0x00000001};

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";
int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], uint32_t words_out[], uint8_t word_len)
{
    for (int8_t i = word_len - 1; i >= 0; i--) {
        words_out[i] = 0;
        words_out[i] |= (bytes_in[(i)*4+3] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(i)*4+2] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(i)*4+1] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(i)*4+0] <<  0) & 0x000000FF;
    }
    return 0;
}

int words_to_bytes(const uint32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (int8_t i = word_len - 1; i >= 0; i--) {
      uint32_t value = words_in[i];
      bytes_out[i*4+0] = (value & 0x000000ff);
      bytes_out[i*4+1] = (value & 0x0000ff00) >> 8;
      bytes_out[i*4+2] = (value & 0x00ff0000) >> 16;
      bytes_out[i*4+3] = (value & 0xff000000) >> 24;
    }

    return 0;
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
    int32_t base[13] = {0};
    int32_t size = 13;
    trit_t trits[4]; // on final call only left 3 trits matter

    //instead of operating on all 243 trits at once, we will hotswap
    //4 trits at a time from our trints
    for(int8_t x = 60; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 60) ? 3 : 4;
        trint_to_trits(trints_in[x], &trits[0], get);

        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;

                for (int32_t j = 0; j < sz; j++) {
                    int64_t v = ((int64_t)base[j]&0xFFFFFFFF);// * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
                    carry = (int32_t)((v >> 32) & 0xFFFFFFFF);
                    //printf("[%i]carry: %u\n", i, carry);
                    base[j] = (int32_t) (v & 0xFFFFFFFF);
                }

                if (carry > 0) {
                    printf("ERR");
                    //base[sz] = carry;
                    //size++;
                }
            }

            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 60 & i == 2) {
                    bigint_add_int(base, 1, tmp, 13);
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
                }
                memcpy(base, tmp, 52);
                // todo sz>size stuff
            }
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }


    memcpy(words_out, base, 48);
    return 0;
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
    int32_t base[13] = {0};
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
    }


    uint32_t rem = 0;
    trit_t trits[4];
    for(int8_t x = 0; x < 61; x++) { // 61 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 60) ? 3 : 4;
        trits_to_trint(&trits[0], send);

        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;

                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 4 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
}

// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT
//probably convert since ledger doesn't have uint64
uint32_t swap32(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit

        if(i%5 == 4) //we need a new trint
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
        uint32_t sz;

        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
                uint64_t v = base[j];
                v = v * 3 + carry;

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
                //v holds full amount, base[j] holds up to uint32 max
                //printf("-v:%llu", v);
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
                base[sz] = carry;
                size++;
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    return 0;
}

int trints_to_words_u(const trint_t trints_in[], uint32_t words_out[])
{
    uint32_t base[12] = {0};
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //possibly add a case for if every val == -1
    for (int16_t i = 242; i-- > 0;) {

        if(i%5 == 4) //we need a new trint
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
        uint32_t sz;

        //printf("%d [%d]", i, trit);
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
                uint64_t v = base[j];
                v = v * 3 + carry;

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
                //v holds full amount, base[j] holds up to uint32 max
                //printf("-v:%llu", v);
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
                base[sz] = carry;
                size++;
            }
        }

        // add
        {
            uint32_t tmp[12];
            sz = bigint_add_int_u(base, trit, tmp, 12);
            memcpy(base, tmp, 48);
            if(sz > size) size = sz;
        }
    }

    //works up to here

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        uint32_t tmp[12];
        bigint_sub_bigint_u(base, HALF_3_u, tmp, 12);
        memcpy(base, tmp, 48);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    uint32_t base_tmp;
    for(uint8_t i=0; i < 6; i++) {
        base_tmp = base[i];
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    memcpy(words_out, base, 48);
    return 0;
}

int trits_to_words_u(const trit_t trits_in[], uint32_t words_out[])
{
    uint32_t base[12] = {0};
    uint32_t size = 1;
    for (int16_t i = 242; i-- > 0;) {
        uint8_t trit = trits_in[i] + 1;
        uint32_t sz;

        //printf("%d [%d]", i, trit);
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
                uint64_t v = base[j];
                v = v * 3 + carry;

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
                //v holds full amount, base[j] holds up to uint32 max
                //printf("-v:%llu", v);
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
                base[sz] = carry;
                size++;
            }
        }

        // add
        {
            uint32_t tmp[12];
            sz = bigint_add_int_u(base, trit, tmp, 12);
            memcpy(base, tmp, 48);
            if(sz > size) size = sz;
        }
    }

    //works up to here

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        uint32_t tmp[12];
        bigint_sub_bigint_u(base, HALF_3_u, tmp, 12);
        memcpy(base, tmp, 48);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    uint32_t base_tmp;
    for(uint8_t i=0; i < 6; i++) {
        base_tmp = base[i];
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    memcpy(words_out, base, 48);
    return 0;
}


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
        tmp = words[i];
        words[i] = words[j];
        words[j] = tmp;
    }
}
void print_words(uint32_t *words, int len) {
    printf("Uint32Array [\n");
    for(int i=0; i< len; i++) {
        printf("%u\n", words[i]);
    }
    printf("]\n\n\n");
}

int words_to_trits_u(const uint32_t words_in[], trit_t trits_out[])
{
    uint32_t base[12] = {0};
    uint32_t tmp[12] = {0};
    memcpy(base, words_in, 48);

    reverse_words(base, 12);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[11] >> 31 == 0) {
        //positive two's complement
        bigint_add_intarr_u(base, HALF_3_u, tmp, 12);
        memcpy(base, tmp, 48);

        //this part works
    } else {
        //negative number
        bigint_not_u(base, 12);
        //***** Doesn't seem to enter here - probably because uint..
        if(bigint_cmp_bigint_u(base, HALF_3_u, 12) > 0) {
            bigint_sub_bigint_u(base, HALF_3_u, tmp, 12);
            memcpy(base, tmp, 48);
            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u(base, 1, tmp, 12);
            memcpy(base, tmp, 48);

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
            memcpy(base, tmp, 48);
        }
    }

    // Same result up to here!!


    uint32_t rem = 0;
    for (int16_t i = 0; i < 242; i++) {
        rem = 0;
        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
                                      + rem : 0) + base[j];
            //radix is 3
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;

            base[j] = (uint32_t)q;
            rem = r;
        }
        trits_out[i] = rem - 1;

        if (flip_trits) {
            trits_out[i] = -trits_out[i];
        }
    }

    //words_to_trits_u works (same result as official
    return 0;
}

int words_to_trits(const int32_t words_in[], trit_t trits_out[])
{
    int32_t base[13] = {0};
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
    }


    uint32_t rem = 0;
    for (int16_t i = 0; i < 243; i++) {
        rem = 0;
        for (int8_t j = 13-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;

            base[j] = q;
            rem = r;
        }
        trits_out[i] = rem - 1;
        if (flip_trits) {
            trits_out[i] = -trits_out[i];
        }
    }
    return 0;
}


int words_to_trints_u_mem(uint32_t *words_in, trint_t *trints_out)
{
    uint32_t *base = words_in;

    reverse_words(base, 12);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[11] >> 31 == 0) {
        //positive two's complement
        bigint_add_intarr_u_mem(base, HALF_3_u, 12);

    } else {
        //negative number
        bigint_not_u(base, 12);
        //***** Doesn't seem to enter here - probably because uint..
        if(bigint_cmp_bigint_u(base, HALF_3_u, 12) > 0) {
            bigint_sub_bigint_u_mem(base, HALF_3_u, 12);

            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u_mem(base, 1, 12);

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            uint32_t tmp[12];
            bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
            memcpy(base, tmp, 48);
        }
    }

    // Same result up to here!!


    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
                                      + rem : 0) + base[j];
            //radix is 3
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
        }

        if(i%5 == 4) // we've finished a trint, store it
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
    }
    //set very last trit to 0
    trits[2] = 0;
    //the last trint %5 won't == 4 so store it manually
    trints_out[48] = trits_to_trint(&trits[0], 3);

    //words_to_trints_u works (same result as official
    return 0;
}

int words_to_trints_u(const uint32_t *words_in, trint_t *trints_out)
{
    uint32_t base[12] = {0};
    uint32_t tmp[12] = {0};
    memcpy(base, words_in, 48);

    reverse_words(base, 12);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[11] >> 31 == 0) {
        //positive two's complement
        bigint_add_intarr_u(base, HALF_3_u, tmp, 12);
        memcpy(base, tmp, 48);

        //this part works
    } else {
        //negative number
        bigint_not_u(base, 12);
        //***** Doesn't seem to enter here - probably because uint..
        if(bigint_cmp_bigint_u(base, HALF_3_u, 12) > 0) {
            bigint_sub_bigint_u(base, HALF_3_u, tmp, 12);
            memcpy(base, tmp, 48);
            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u(base, 1, tmp, 12);
            memcpy(base, tmp, 48);

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
            memcpy(base, tmp, 48);
        }
    }

    // Same result up to here!!


    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
                                      + rem : 0) + base[j];
            //radix is 3
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
        }

        if(i%5 == 4) // we've finished a trint, store it
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
    }
    //set very last trit to 0
    trits[2] = 0;
    //the last trint %5 won't == 4 so store it manually
    trints_out[48] = trits_to_trint(&trits[0], 3);

    //words_to_trints_u works (same result as official
    return 0;
}
