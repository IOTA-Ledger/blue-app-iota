#include "conversion.h"
#include <stdio.h>
#include "bigint.h"
#include "common.h"

#define INT_LENGTH 12

// the middle of the domain described by 242 trits, i.e. \sum_{k=0}^{241} 3^k
static const uint32_t HALF_3_u[12] = {
    0xa5ce8964, 0x9f007669, 0x1484504f, 0x3ade00d9, 0x0c24486e, 0x50979d57,
    0x79a4c702, 0x48bbae36, 0xa9f6808b, 0xaa06a805, 0xa87fabdf, 0x5e69ebef};

// the two's complement of HALF_3_u, i.e. ~HALF_3_u + 1
static const uint32_t NEG_HALF_3_u[12] = {
    0x5a31769c, 0x60ff8996, 0xeb7bafb0, 0xc521ff26, 0xf3dbb791, 0xaf6862a8,
    0x865b38fd, 0xb74451c9, 0x56097f74, 0x55f957fa, 0x57805420, 0xa1961410};

// TODO: remove, no longer needed
static const int32_t HALF_3[13] = {
    0xF16B9C2D, 0xDD01633C, 0x3D8CF0EE, 0xB09A028B, 0x246CD94A,
    0xF1C6D805, 0x6CEE5506, 0xDA330AA3, 0xFDE381A1, 0xFE13F810,
    0xF97f039E, 0x1B3DC3CE, 0x00000001};

// representing the value of the highes trit in the feasible domain, i.e 3^242
static const uint32_t LAST_TRIT[12] = {
    0x4b9d12c9, 0x3e00ecd3, 0x2908a09f, 0x75bc01b2, 0x184890dc, 0xa12f3aae,
    0xf3498e04, 0x91775c6c, 0x53ed0116, 0x540d500b, 0x50ff57bf, 0xbcd3d7df};

// the two's complement of LAST_TRIT, i.e. ~LAST_TRIT + 1
static const uint32_t NEG_LAST_TRIT[12] = {
    0xb462ed37, 0xc1ff132c, 0xd6f75f60, 0x8a43fe4d, 0xe7b76f23, 0x5ed0c551,
    0xcb671fb,  0x6e88a393, 0xac12fee9, 0xabf2aff4, 0xaf00a840, 0x432c2820};

// available tryte chars in the correct order
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

void chars_to_bigints(const char *chars, uint32_t *bigints, uint16_t chars_len)
{
    for (uint16_t i = 0; i < chars_len / 81; i++) {
        trit_t trits[243];
        {
            tryte_t trytes[81];
            chars_to_trytes(chars + i * 81, trytes, 81);
            trytes_to_trits(trytes, trits, 81);
        }

        // bigint can only handle 242 trits
        trits[242] = 0;
        trits_to_bigint(trits, bigints + i * 12);
    }
}

void bigints_to_chars(const uint32_t *bigints, char *chars, uint16_t bigint_len)
{
    for (uint16_t i = 0; i < bigint_len / 12; i++) {
        tryte_t trytes[81];
        {
            trit_t trits[243];
            bigint_to_trits(bigints + i * 12, trits);
            trits_to_trytes(trits, trytes, 243);
        }

        trytes_to_chars(trytes, chars + i * 81, 81);
    }

    // make zero termnated
    chars[(bigint_len / 12) * 81] = '\0';
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

// Converts bigint consisting of 12 words into an array of bytes.
// It is represented using 48bytes in big-endiean, by reversing the order of the
// words. The endianness of the host machine is taken into account.
void bigint_to_bytes(const uint32_t *bigint, unsigned char *bytes)
{
    uint32_t *p = (uint32_t *)bytes;

    // reverse word order
    for (int8_t i = 11; i >= 0; i--) {
        // convert byte order if necessary
        *p++ = os_swap_u32(bigint[i]);
    }
}

// Converts an array of 48 bytes into a bigint consisting of 12 words.
// The bigint is represented using 48bytes in big-endiean. The endianness of the
// host machine is taken into account.
void bytes_to_bigint(const unsigned char *bytes, uint32_t *bigint)
{
    const uint32_t *p = (const uint32_t *)bytes;

    // reverse word order
    for (int8_t i = 11; i >= 0; i--) {
        // convert byte order if necessary
        bigint[i] = os_swap_u32(*p);
        p++;
    }
}

static inline bool is_negative(const uint32_t *bigint)
{
    return (bigint[INT_LENGTH - 1] >> 31 != 0);
}

void bigint_set_last_trit_zero(uint32_t *bigint) {

  if (is_negative(bigint)) {
    if (bigint_cmp_bigint_u(bigint, NEG_HALF_3_u, INT_LENGTH) < 0) {
      bigint_sub_bigint_u_mem(bigint, NEG_LAST_TRIT, INT_LENGTH);
    }
  } else {
    if (bigint_cmp_bigint_u(bigint, HALF_3_u, INT_LENGTH) > 0) {
      bigint_sub_bigint_u_mem(bigint, LAST_TRIT, INT_LENGTH);
    }
  }
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
                os_memcpy(base, tmp, 52);
                // todo sz>size stuff
            }
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        os_memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }


    os_memcpy(words_out, base, 48);
    return 0;
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
    int32_t base[13] = {0};
    int32_t tmp[13] = {0};
    os_memcpy(tmp, words_in, 48);
    bool flip_trits = false;

    if (is_negative(words_in)) {
        tmp[12] = 0xFFFFFFFF;
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            os_memcpy(base, tmp, 52);
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

int trints_to_bigint_mem(const trint_t *trints_in, uint32_t *base)
{
    uint32_t size = 1;
    trit_t trits[5];

    // initialize bigint to zero
    memset(base, 0, 12 * 4);

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit

        if(i%5 == 4) //we need a new trint
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);

        uint32_t sz;
        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;

        // the last trit must be 0, as it cannot be fully represented in 48bytes
        if (i==242) { trit = 1; }

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
            os_memcpy(base, tmp, 48);
            if(sz > size) size = sz;
        }
    }

    //works up to here

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        uint32_t tmp[12];
        bigint_sub_bigint_u(base, HALF_3_u, tmp, 12);
        os_memcpy(base, tmp, 48);
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

    //outputs correct words according to official js
    os_memcpy(words_out, base, 48);
    return 0;
}

int trits_to_bigint(const trit_t *trits_in, uint32_t *bigint)
{
    // initialize bigint to zero
    memset(bigint, 0, INT_LENGTH * 4);

    uint16_t size = 1;
    for (uint16_t i = 242; i-- > 0;) {
        // the last trit must be 0, as it cannot be fully represented in 48bytes
        uint8_t trit = (i == 242 ? 0 : trits_in[i]) + 1;
        uint32_t sz;

        //printf("%d [%d]", i, trit);
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
                uint64_t v = bigint[j];
                v = v * 3 + carry;

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                bigint[j] = (uint32_t) (v & 0xFFFFFFFF);
                //v holds full amount, base[j] holds up to uint32 max
                //printf("-v:%llu", v);
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
                bigint[sz] = carry;
                size++;
            }
        }

        // add
        sz = bigint_add_int_u_mem(bigint, trit, INT_LENGTH);
        if(sz > size) {
            size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, bigint, INT_LENGTH) <= 0 ) {
        bigint_sub_bigint_u_mem(bigint, HALF_3_u, INT_LENGTH);
    } else {
        uint32_t tmp[INT_LENGTH];
        bigint_sub_bigint_u(HALF_3_u, bigint, tmp, INT_LENGTH);
        bigint_not_u(tmp, INT_LENGTH);
        bigint_add_int_u(tmp, 1, bigint, INT_LENGTH);
    }

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

int bigint_to_trits(const uint32_t *bigint, trit_t *trits_out)
{
    uint32_t base[INT_LENGTH] = {0};
    memcpy(base, bigint, INT_LENGTH * 4);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[INT_LENGTH - 1] >> 31 == 0) {
        //positive two's complement
        bigint_add_intarr_u_mem(base, HALF_3_u, INT_LENGTH);

    } else {
        //negative number
        bigint_not_u(base, INT_LENGTH);

        if(bigint_cmp_bigint_u(base, HALF_3_u, INT_LENGTH) > 0) {
            bigint_sub_bigint_u_mem(base, HALF_3_u, INT_LENGTH);

            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u_mem(base, 1, INT_LENGTH);

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            uint32_t tmp[INT_LENGTH];
            bigint_sub_bigint_u(HALF_3_u, base, tmp, INT_LENGTH);
            memcpy(base, tmp, INT_LENGTH * 4);
        }
    }

    uint32_t rem = 0;
    for (int16_t i = 0; i < 242; i++) {
        rem = 0;
        for (int8_t j = INT_LENGTH - 1; j >= 0 ; j--) {
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

    trits_out[242] = 0;

    //words_to_trits_u works (same result as official
    return 0;
}

int words_to_trits(const int32_t words_in[], trit_t trits_out[])
{
    int32_t base[13] = {0};
    int32_t tmp[13] = {0};
    os_memcpy(tmp, words_in, 48);
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
            os_memcpy(base, tmp, 52);
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


int bigint_to_trints_mem(uint32_t *bigint_in, trint_t *trints_out)
{
    uint32_t *base = bigint_in;

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
            os_memcpy(base, tmp, 48);
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
    os_memcpy(base, words_in, 48);

    reverse_words(base, 12);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[11] >> 31 == 0) {
        //positive two's complement
        bigint_add_intarr_u(base, HALF_3_u, tmp, 12);
        os_memcpy(base, tmp, 48);

        //this part works
    } else {
        //negative number
        bigint_not_u(base, 12);
        //***** Doesn't seem to enter here - probably because uint..
        if(bigint_cmp_bigint_u(base, HALF_3_u, 12) > 0) {
            bigint_sub_bigint_u(base, HALF_3_u, tmp, 12);
            os_memcpy(base, tmp, 48);
            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u(base, 1, tmp, 12);
            os_memcpy(base, tmp, 48);

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
            os_memcpy(base, tmp, 48);
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
