#include "conversion.h"
#include <stdint.h>
#include "common.h"

#define INT_LENGTH 12
// base of the ternary system
#define BASE 3

// the middle of the domain described by 242 trits, i.e. \sum_{k=0}^{241} 3^k
static const uint32_t HALF_3[12] = {
    0xa5ce8964, 0x9f007669, 0x1484504f, 0x3ade00d9, 0x0c24486e, 0x50979d57,
    0x79a4c702, 0x48bbae36, 0xa9f6808b, 0xaa06a805, 0xa87fabdf, 0x5e69ebef};

// the two's complement of HALF_3_u, i.e. ~HALF_3_u + 1
static const uint32_t NEG_HALF_3[12] = {
    0x5a31769c, 0x60ff8996, 0xeb7bafb0, 0xc521ff26, 0xf3dbb791, 0xaf6862a8,
    0x865b38fd, 0xb74451c9, 0x56097f74, 0x55f957fa, 0x57805420, 0xa1961410};

// representing the value of the highes trit in the feasible domain, i.e 3^242
static const uint32_t LAST_TRIT[12] = {
    0x4b9d12c9, 0x3e00ecd3, 0x2908a09f, 0x75bc01b2, 0x184890dc, 0xa12f3aae,
    0xf3498e04, 0x91775c6c, 0x53ed0116, 0x540d500b, 0x50ff57bf, 0xbcd3d7df};

static const trit_t trits_mapping[27][3] = {
    {-1, -1, -1}, {0, -1, -1}, {1, -1, -1}, {-1, 0, -1}, {0, 0, -1}, {1, 0, -1},
    {-1, 1, -1},  {0, 1, -1},  {1, 1, -1},  {-1, -1, 0}, {0, -1, 0}, {1, -1, 0},
    {-1, 0, 0},   {0, 0, 0},   {1, 0, 0},   {-1, 1, 0},  {0, 1, 0},  {1, 1, 0},
    {-1, -1, 1},  {0, -1, 1},  {1, -1, 1},  {-1, 0, 1},  {0, 0, 1},  {1, 0, 1},
    {-1, 1, 1},   {0, 1, 1},   {1, 1, 1}};

// available tryte chars in the correct order
static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";

/* --------------------- trits > trytes and back */
// used for bytes to chars and back
int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[],
                    unsigned int tryte_len)
{
    for (unsigned int i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t)trytes_in[i] + 13;
        trits_out[i * 3 + 0] = trits_mapping[idx][0];
        trits_out[i * 3 + 1] = trits_mapping[idx][1];
        trits_out[i * 3 + 2] = trits_mapping[idx][2];
    }
    return 0;
}

int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[],
                    unsigned int trit_len)
{
    if (trit_len % 3 != 0) {
        return -1;
    }
    unsigned int tryte_len = trit_len / 3;

    for (unsigned int i = 0; i < tryte_len; i++) {
        trytes_out[i] = trits_in[i * 3 + 0] + trits_in[i * 3 + 1] * 3 +
                        trits_in[i * 3 + 2] * 9;
    }
    return 0;
}
/* --------------------- END trits > trytes */

/* --------------------- trytes > chars and back */
// used for bytes to chars and back
int chars_to_trytes(const char chars_in[], tryte_t trytes_out[],
                    unsigned int len)
{
    for (unsigned int i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
            trytes_out[i] = 0;
        }
        else if ((int8_t)chars_in[i] >= 'N') {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        }
        else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[],
                    unsigned int len)
{
    for (unsigned int i = 0; i < len; i++) {
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
}
/* --------------------- END trytes > chars */

void chars_to_trits(const char *chars, trit_t *trits, unsigned int chars_len)
{
    tryte_t trytes[chars_len];
    chars_to_trytes(chars, trytes, chars_len);
    trytes_to_trits(trytes, trits, chars_len);
}

/** @brief Returns true, if the long little-endian integer represents a negative
 *         number in two's complement.
 */
static inline bool bigint_is_negative(const uint32_t *bigint)
{
    // whether the most significant bit of the most significant byte is set
    return (bigint[12 - 1] >> (sizeof(bigint[0]) * 8 - 1) != 0);
}

static int bigint_cmp(const uint32_t *a, const uint32_t *b)
{
    for (unsigned int i = 12; i-- > 0;) {
        if (a[i] < b[i]) {
            return -1;
        }
        if (a[i] > b[i]) {
            return 1;
        }
    }
    return 0;
}

static inline bool addcarry_u32(uint32_t *r, uint32_t a, uint32_t b, bool c_in)
{
    const uint32_t sum = a + b + (c_in ? 1 : 0);
    const bool carry = (sum < a) || (c_in && (sum <= a));

    *r = sum;
    return carry;
}

static bool bigint_add(uint32_t *r, const uint32_t *a, const uint32_t *b)
{
    bool carry = false;
    for (unsigned int i = 0; i < 12; i++) {
        carry = addcarry_u32(&r[i], a[i], b[i], carry);
    }

    return carry;
}

static bool bigint_sub(uint32_t *r, const uint32_t *a, const uint32_t *b)
{
    bool carry = true;
    for (unsigned int i = 0; i < 12; i++) {
        carry = addcarry_u32(&r[i], a[i], ~b[i], carry);
    }

    return carry;
}

/** @brief adds a single 32-bit integer to a long little-endian integer.
 *  @return index of the most significant word which changed during the addition
 */
unsigned int bigint_add_u32_mem(uint32_t *a, uint32_t summand)
{
    bool carry = addcarry_u32(&a[0], a[0], summand, false);
    if (carry == false) {
        return 0;
    }

    for (unsigned int i = 1; i < 12; i++) {
        carry = addcarry_u32(&a[i], a[i], 0, true);
        if (carry == false) {
            return i;
        }
    }

    // overflow
    return 12;
}

/** @brief multiplies a single 8-bit integer with a long little-endian integer.
 *  @param ms_index the index of the most significant non-zero word of the
 *                  input integer. Words after this are not considered.
 *  @return the carry (one word) of the multiplication up to the byte which has
            the index specified in msb_index.
 */
static uint32_t bigint_mult_byte_mem(uint32_t *a, uint8_t factor,
                                     unsigned int ms_index)
{
    uint32_t carry = 0;

    for (unsigned int i = 0; i <= ms_index; i++) {
        const uint64_t v = (uint64_t)factor * a[i] + carry;

        carry = v >> 32;
        a[i] = v & 0xFFFFFFFF;
    }

    return carry;
}

/** @brief devides a long big-endian integer by a single 8-bit integer.
 *  @return remainder of the integer division.
 */
static uint32_t bigint_div_byte_mem(uint32_t *a, uint8_t divisor)
{
    uint32_t remainder = 0;

    for (unsigned int i = 12; i-- > 0;) {
        const uint64_t v = (uint64_t)0x100000000 * remainder + a[i];

        remainder = v % divisor;
        a[i] = (v / divisor) & 0xFFFFFFFF;
    }

    return remainder;
}

/** @brief Changes number to the corresponding representation of the number
 *         with the 242th trit set to 0.
 * @return true, if the number was changed, false otherwise.
 */
static bool bigint_set_last_trit_zero(uint32_t *bigint)
{
    if (bigint_is_negative(bigint)) {
        if (bigint_cmp(bigint, NEG_HALF_3) < 0) {
            bigint_add(bigint, bigint, LAST_TRIT);
            return true;
        }
    }
    else {
        if (bigint_cmp(bigint, HALF_3) > 0) {
            bigint_sub(bigint, bigint, LAST_TRIT);
            return true;
        }
    }
    return false;
}

/* --------------------- trits > bigint and back */
static void trits_to_bigint(const trit_t *trits, uint32_t *bigint)
{
    unsigned int ms_index = 0; // initialy there is no most significant word >0
    os_memset(bigint, 0, 12 * sizeof(bigint[0]));

    // ignore the 243th trit, as it cannot be fully represented in 48 bytes
    for (unsigned int i = 242; i-- > 0;) {
        // convert to non-balanced ternary
        const uint8_t trit = trits[i] + 1;

        const uint32_t carry = bigint_mult_byte_mem(bigint, BASE, ms_index);
        if (carry > 0) {
            // if there is carry we need to use the next higher byte
            bigint[++ms_index] = carry;
        }

        if (trit == 0) {
            // nothing to add
            continue;
        }

        const unsigned int last_changed_index =
            bigint_add_u32_mem(bigint, trit);
        if (last_changed_index > ms_index) {
            ms_index = last_changed_index;
        }
    }

    // convert to balanced ternary using two's complement
    if (bigint_cmp(bigint, HALF_3) >= 0) {
        bigint_sub(bigint, bigint, HALF_3);
    }
    else {
        // equivalent to bytes := ~(HALF_3 - bytes) + 1
        bigint_add(bigint, NEG_HALF_3, bigint);
    }
}

static void bigint_to_trits_mem(uint32_t *bigint, trit_t *trits)
{
    // the two's complement represention is only correct, if the number fits
    // into 48 bytes, i.e. has the 243th trit set to 0
    bigint_set_last_trit_zero(bigint);

    // convert to the (positive) number representing non-balanced ternary
    if (bigint_is_negative(bigint)) {
        bigint_sub(bigint, bigint, NEG_HALF_3);
    }
    else {
        bigint_add(bigint, bigint, HALF_3);
    }

    // ignore the 243th trit, as it cannot be fully represented in 48 bytes
    for (unsigned int i = 0; i < 242; i++) {
        const uint32_t rem = bigint_div_byte_mem(bigint, BASE);
        trits[i] = rem - 1; // convert back to balanced
    }
    // set the last trit to zero for consistency
    trits[242] = 0;
}

bool int64_to_trits(int64_t value, trit_t *trits, unsigned int num_trits)
{
    const bool is_negative = value < 0;
    if (is_negative) {
        value = -value;
    }

    os_memset(trits, 0, num_trits);

    for (unsigned int i = 0; i < num_trits; i++) {
        if (value == 0) {
            return false;
        }

        int rem = value % BASE;
        value = value / BASE;
        if (rem > 1) {
            rem = -1;
            value += 1;
        }

        trits[i] = is_negative ? -rem : rem;
    }

    return value != 0;
}
/* --------------------- END trits > bigint */

/** @brief Converts bigint consisting of 12 words into an array of bytes.
 *  It is represented using 48bytes in big-endiean, by reversing the order of
 *  the words. The endianness of the host machine is taken into account.
 */
static void bigint_to_bytes(const uint32_t *bigint, unsigned char *bytes)
{
    uint32_t *p = (uint32_t *)bytes;

    // reverse word order
    for (unsigned int i = 12; i-- > 0;) {
        // convert byte order if necessary
        *p++ = os_swap_u32(bigint[i]);
    }
}

/** @brief Converts an array of 48 bytes into a bigint consisting of 12 words.
 *  The bigint is represented using 48bytes in big-endiean. The endianness of
 * the host machine is taken into account.
 */
static void bytes_to_bigint(const unsigned char *bytes, uint32_t *bigint)
{
    const uint32_t *p = (const uint32_t *)bytes;

    // reverse word order
    for (unsigned int i = 12; i-- > 0;) {
        // convert byte order if necessary
        bigint[i] = os_swap_u32(*p);
        p++;
    }
}

void trits_to_bytes(const trit_t *trits, unsigned char *bytes)
{
    uint32_t bigint[12];
    trits_to_bigint(trits, bigint);
    bigint_to_bytes(bigint, bytes);
}

void chars_to_bytes(const char *chars, unsigned char *bytes,
                    unsigned int chars_len)
{
    for (unsigned int i = 0; i < chars_len / 81; i++) {
        trit_t trits[243];
        chars_to_trits(chars + i * 81, trits, 81);
        // bigint can only handle 242 trits
        trits[242] = 0;

        trits_to_bytes(trits, bytes + i * 48);
    }
}

static inline void bytes_to_trits(const unsigned char *bytes, trit_t *trits)
{
    uint32_t bigint[12];
    bytes_to_bigint(bytes, bigint);
    bigint_to_trits_mem(bigint, trits);
}

void bytes_to_chars(const unsigned char *bytes, char *chars,
                    unsigned int bytes_len)
{
    for (unsigned int i = 0; i < bytes_len / 48; i++) {
        tryte_t trytes[81];
        {
            trit_t trits[243];
            bytes_to_trits(bytes + i * 48, trits);
            trits_to_trytes(trits, trytes, 243);
        }
        trytes_to_chars(trytes, chars + i * 81, 81);
    }

    // make zero termnated
    chars[(bytes_len / 48) * 81] = '\0';
}

void bytes_set_last_trit_zero(unsigned char *bytes)
{
    uint32_t bigint[12];
    bytes_to_bigint(bytes, bigint);
    if (bigint_set_last_trit_zero(bigint)) {
        bigint_to_bytes(bigint, bytes);
    }
}

void bytes_add_u32_mem(unsigned char *bytes, uint32_t summand)
{
    if (summand > 0) {
        uint32_t bigint[12];

        bytes_to_bigint(bytes, bigint);
        bigint_add_u32_mem(bigint, summand);
        bigint_set_last_trit_zero(bigint);
        bigint_to_bytes(bigint, bytes);
    }
}
