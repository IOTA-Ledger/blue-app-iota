#include "iota/conversion.h"
#include <limits.h>
#include <stdint.h>
#include "iota/iota_types.h"
#include "os.h"

#define UINT32_WIDTH 32

// numer of u32 elements in one bigint array
#define BIGINT_LENGTH 12

// chunk sizes
#define NUM_CHUNK_TRYTES (NUM_HASH_TRYTES)
#define NUM_CHUNK_BYTES (NUM_HASH_BYTES)

// base of the ternary system
#define BASE 3

// base of the ternary system represented in bytes
#define TRYTE_BASE 27

// the middle of the domain described by 242 trits, i.e. \sum_{k=0}^{241} 3^k
static const uint32_t HALF_3[BIGINT_LENGTH] = {
    0xa5ce8964, 0x9f007669, 0x1484504f, 0x3ade00d9, 0x0c24486e, 0x50979d57,
    0x79a4c702, 0x48bbae36, 0xa9f6808b, 0xaa06a805, 0xa87fabdf, 0x5e69ebef};

// the two's complement of HALF_3_u, i.e. ~HALF_3_u + 1
static const uint32_t NEG_HALF_3[BIGINT_LENGTH] = {
    0x5a31769c, 0x60ff8996, 0xeb7bafb0, 0xc521ff26, 0xf3dbb791, 0xaf6862a8,
    0x865b38fd, 0xb74451c9, 0x56097f74, 0x55f957fa, 0x57805420, 0xa1961410};

// the value of the highest trit in the feasible domain, i.e 3^242
static const uint32_t TRIT_243[BIGINT_LENGTH] = {
    0x4b9d12c9, 0x3e00ecd3, 0x2908a09f, 0x75bc01b2, 0x184890dc, 0xa12f3aae,
    0xf3498e04, 0x91775c6c, 0x53ed0116, 0x540d500b, 0x50ff57bf, 0xbcd3d7df};

// the value of the highest trit in one tryte, i.e 3^3
#define TRIT_4 9

// lookup table to convert a single tryte into the corresponding three trits
static const trit_t TRITS_TABLE[UTRYTE_MAX + 1][3] = {
    {-1, -1, -1}, {0, -1, -1}, {1, -1, -1}, {-1, 0, -1}, {0, 0, -1}, {1, 0, -1},
    {-1, 1, -1},  {0, 1, -1},  {1, 1, -1},  {-1, -1, 0}, {0, -1, 0}, {1, -1, 0},
    {-1, 0, 0},   {0, 0, 0},   {1, 0, 0},   {-1, 1, 0},  {0, 1, 0},  {1, 1, 0},
    {-1, -1, 1},  {0, -1, 1},  {1, -1, 1},  {-1, 0, 1},  {0, 0, 1},  {1, 0, 1},
    {-1, 1, 1},   {0, 1, 1},   {1, 1, 1}};

// lookup table to convert a single tryte into its char in base-27 encoding
static const char CHARS_TABLE[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";

static void trytes_to_trits(const tryte_t *trytes_in, trit_t *trits_out,
                            unsigned int trytes_len)
{
    for (unsigned int i = 0; i < trytes_len; i++) {
        const unsigned int idx = *trytes_in++ - TRYTE_MIN;
        const trit_t *trits_mapping = TRITS_TABLE[idx];

        *trits_out++ = trits_mapping[0];
        *trits_out++ = trits_mapping[1];
        *trits_out++ = trits_mapping[2];
    }
}

static void trits_to_trytes(const trit_t *trits_in, tryte_t *trytes_out,
                            unsigned int trits_len)
{
    for (unsigned int i = 0; i < trits_len / TRITS_PER_TRYTE; i++) {
        trytes_out[i] = *trits_in++;
        trytes_out[i] += *trits_in++ * BASE;
        trytes_out[i] += *trits_in++ * BASE * BASE;
    }
}

static void chars_to_trytes(const char *chars_in, tryte_t *trytes_out,
                            unsigned int chars_len)
{
    for (unsigned int i = 0; i < chars_len; i++) {
        if (chars_in[i] == '9') {
            trytes_out[i] = 0;
        }
        else if (chars_in[i] >= 'N') {
            trytes_out[i] = chars_in[i] - 'N' + TRYTE_MIN;
        }
        else {
            trytes_out[i] = chars_in[i] - 'A' + 1;
        }
    }
}

static void trytes_to_chars(const tryte_t *trytes_in, char *chars_out,
                            unsigned int trytes_len)
{
    for (unsigned int i = 0; i < trytes_len; i++) {
        chars_out[i] = CHARS_TABLE[trytes_in[i] - TRYTE_MIN];
    }
}

/** @brief Sets the last (3rd) trit in a single tryte to set to zero.
 *  @return value of the tryte without the last trit
 */
static inline tryte_t tryte_set_last_trit_zero(tryte_t tryte)
{
    if (tryte > TRYTE_MAX - TRIT_4) {
        return tryte - TRIT_4;
    }
    if (tryte < TRYTE_MIN + TRIT_4) {
        return tryte + TRIT_4;
    }
    return tryte;
}

/** @brief Returns true, if the bigint represents a negative number in two's
 *         complement.
 */
static inline bool bigint_is_negative(const uint32_t *bigint)
{
    // whether the most significant bit of the most significant byte is set
    return (bigint[BIGINT_LENGTH - 1] >> (UINT32_WIDTH - 1) != 0);
}

/** @brief Compares to bigints.
 *  @return -1 if a < b, 1 if a > b; or 0 if they are equal
 */
static int bigint_cmp(const uint32_t *a, const uint32_t *b)
{
    for (unsigned int i = BIGINT_LENGTH; i-- > 0;) {
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
    for (unsigned int i = 0; i < BIGINT_LENGTH; i++) {
        carry = addcarry_u32(&r[i], a[i], b[i], carry);
    }

    return carry;
}

static bool bigint_sub(uint32_t *r, const uint32_t *a, const uint32_t *b)
{
    bool carry = true;
    for (unsigned int i = 0; i < BIGINT_LENGTH; i++) {
        carry = addcarry_u32(&r[i], a[i], ~b[i], carry);
    }

    return carry;
}

/** @brief adds a single 32-bit integer to a bigint.
 *  @return index of the most significant word which changed during the addition
 */
static unsigned int bigint_add_u32_mem(uint32_t *a, uint32_t summand)
{
    bool carry = addcarry_u32(&a[0], a[0], summand, false);
    if (carry == false) {
        return 0;
    }

    for (unsigned int i = 1; i < BIGINT_LENGTH; i++) {
        carry = addcarry_u32(&a[i], a[i], 0, true);
        if (carry == false) {
            return i;
        }
    }

    // overflow
    return BIGINT_LENGTH;
}

/** @brief multiplies a single 32-bit integer with a bigint.
 *  @param ms_index the index of the most significant non-zero word of the
 *                  input integer. Words after this are not considered.
 *  @return the carry (one word) of the multiplication up to the byte which has
            the index specified in msb_index.
 */
static uint32_t bigint_mult_u32_mem(uint32_t *a, uint32_t factor,
                                    unsigned int ms_index)
{
    uint32_t carry = 0;

    for (unsigned int i = 0; i <= ms_index; i++) {
        const uint64_t v = (uint64_t)factor * a[i] + carry;

        carry = v >> UINT32_WIDTH;
        a[i] = v & UINT32_MAX;
    }

    return carry;
}

/** @brief devides a bigint by a single 32-bit integer.
 *  @param ms_index the index of the most significant non-zero word of the
 *                  input integer. Words after this are not considered.
 *  @return remainder of the integer division.
 */
static uint32_t bigint_div_u32_mem(uint32_t *a, uint32_t divisor,
                                   unsigned int ms_index)
{
    uint32_t remainder = 0;

    for (unsigned int i = ms_index + 1; i-- > 0;) {
        const uint64_t v = (UINT64_C(1) + UINT32_MAX) * remainder + a[i];

        remainder = (v % divisor) & UINT32_MAX;
        a[i] = (v / divisor) & UINT32_MAX;
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
            bigint_add(bigint, bigint, TRIT_243);
            return true;
        }
    }
    else {
        if (bigint_cmp(bigint, HALF_3) > 0) {
            bigint_sub(bigint, bigint, TRIT_243);
            return true;
        }
    }
    return false;
}

static void trytes_to_bigint(const tryte_t *trytes, uint32_t *bigint)
{
    // initialy there is no non-zero word
    unsigned int ms_index = 0;
    os_memset(bigint, 0, BIGINT_LENGTH * sizeof(bigint[0]));

    // special case for the last tryte only holding two trits of value
    bigint[0] = tryte_set_last_trit_zero(trytes[NUM_CHUNK_TRYTES - 1]) + 4;

    for (unsigned int i = NUM_CHUNK_TRYTES - 1; i-- > 0;) {
        // convert to non-balanced ternary
        const uint8_t tryte = trytes[i] + (TRYTE_BASE / 2);

        const uint32_t carry =
            bigint_mult_u32_mem(bigint, TRYTE_BASE, ms_index);
        if (carry > 0 && ms_index < BIGINT_LENGTH - 1) {
            // if there is a carry, we need to use the next higher word
            bigint[++ms_index] = carry;
        }

        if (tryte == 0) {
            // nothing to add
            continue;
        }

        const unsigned int last_changed_index =
            bigint_add_u32_mem(bigint, tryte);
        if (last_changed_index > ms_index) {
            ms_index = last_changed_index;
        }
    }

    // substract the middle of the domain to get balanced ternary
    // as there cannot be any overflows with 242 trits, a simple substraction
    // yields the correct result in two's complement representation
    bigint_sub(bigint, bigint, HALF_3);
}

static void trits_to_bigint(const trit_t *trits, uint32_t *bigint)
{
    tryte_t trytes[NUM_HASH_TRYTES];
    trits_to_trytes(trits, trytes, NUM_HASH_TRITS);
    trytes_to_bigint(trytes, bigint);
}

static void bigint_to_trytes_mem(uint32_t *bigint, tryte_t *trytes)
{
    // the two's complement represention is only correct, if the number fits
    // into 48 bytes, i.e. has the 243th trit set to 0
    bigint_set_last_trit_zero(bigint);

    // convert to the (positive) number representing non-balanced ternary
    bigint_add(bigint, bigint, HALF_3);

    // it is safe to assume that initially each word is non-zero
    unsigned int ms_index = BIGINT_LENGTH - 1;
    for (unsigned int i = 0; i < NUM_CHUNK_TRYTES - 1; i++) {
        const uint32_t rem = bigint_div_u32_mem(bigint, TRYTE_BASE, ms_index);
        trytes[i] = rem - (TRYTE_BASE / 2); // convert back to balanced

        // decrement index, if most significant word turned zero
        if (ms_index > 0 && bigint[ms_index] == 0) {
            ms_index--;
        }
    }

    // special case for the last tryte, where no further division is necessary
    trytes[NUM_CHUNK_TRYTES - 1] =
        tryte_set_last_trit_zero(bigint[0] - (TRYTE_BASE / 2));
}

/** @brief Converts bigint consisting of 12 words into an array of bytes.
 *  It is represented using 48bytes in big-endian, by reversing the order of
 *  the words. The endianness of the host machine is taken into account.
 */
static void bigint_to_bytes(const uint32_t *bigint, unsigned char *bytes)
{
    // reverse word order
    for (unsigned int i = BIGINT_LENGTH; i-- > 0; bytes += 4) {
        const uint32_t num = bigint[i];

        bytes[0] = (num >> (3 * CHAR_BIT)) & 0xFF;
        bytes[1] = (num >> (2 * CHAR_BIT)) & 0xFF;
        bytes[2] = (num >> (1 * CHAR_BIT)) & 0xFF;
        bytes[3] = (num >> 0) & 0xFF;
    }
}

/** @brief Converts an array of 48 bytes into a bigint consisting of 12 words.
 *  The bigint is represented using 48bytes in big-endian. The endianness of
 * the host machine is taken into account.
 */
static void bytes_to_bigint(const unsigned char *bytes, uint32_t *bigint)
{
    // reverse word order
    for (unsigned int i = BIGINT_LENGTH; i-- > 0; bytes += 4) {
        bigint[i] = (uint32_t)bytes[0] << (3 * CHAR_BIT) |
                    (uint32_t)bytes[1] << (2 * CHAR_BIT) |
                    (uint32_t)bytes[2] << (1 * CHAR_BIT) |
                    (uint32_t)bytes[3] << 0;
    }
}

void chars_to_trits(const char *chars, trit_t *trits, unsigned int chars_len)
{
    tryte_t trytes[chars_len];
    chars_to_trytes(chars, trytes, chars_len);
    trytes_to_trits(trytes, trits, chars_len);
}

bool s64_to_trits(const int64_t value, trit_t *trits, unsigned int num_trits)
{
    os_memset(trits, 0, num_trits);

    // nothing to compute for zero value
    if (value == 0) {
        return false;
    }

    const bool is_negative = value < 0;
    uint64_t v_abs;
    if (value == INT64_MIN) {
        // inverting INT64_MIN might lead to undefined behavior
        v_abs = INT64_MAX + UINT64_C(1);
    }
    else if (is_negative) {
        v_abs = -value;
    }
    else {
        v_abs = value;
    }

    for (unsigned int i = 0; i < num_trits; i++) {
        if (v_abs == 0) {
            return false;
        }

        int rem = (v_abs % BASE) & INT_MAX;
        v_abs = v_abs / BASE;
        if (rem > BASE / 2) {
            // lend one from the next highest digit
            v_abs += 1;
            rem -= BASE;
        }

        trits[i] = is_negative ? -rem : rem;
    }

    return v_abs != 0;
}

bool u32_to_trits(const uint32_t value, trit_t *trits, unsigned int num_trits)
{
    uint32_t v = value;
    os_memset(trits, 0, num_trits);

    for (unsigned int i = 0; i < num_trits; i++) {
        if (v == 0) {
            return false;
        }

        int rem = (v % BASE) & INT_MAX;
        v = v / BASE;
        if (rem > BASE / 2) {
            // lend one from the next highest digit
            v += 1;
            rem -= BASE;
        }

        trits[i] = rem;
    }

    return v != 0;
}

void trits_to_bytes(const trit_t *trits, unsigned char *bytes)
{
    uint32_t bigint[BIGINT_LENGTH];
    trits_to_bigint(trits, bigint);
    bigint_to_bytes(bigint, bytes);
}

static void trytes_to_bytes(const tryte_t *trytes, unsigned char *bytes)
{
    uint32_t bigint[BIGINT_LENGTH];
    trytes_to_bigint(trytes, bigint);
    bigint_to_bytes(bigint, bytes);
}

void bytes_to_trytes(const unsigned char *bytes, tryte_t *trytes)
{
    uint32_t bigint[BIGINT_LENGTH];
    bytes_to_bigint(bytes, bigint);
    bigint_to_trytes_mem(bigint, trytes);
}

void chars_to_bytes(const char *chars, unsigned char *bytes,
                    unsigned int chars_len)
{
    for (unsigned int i = 0; i < chars_len / NUM_CHUNK_TRYTES; i++) {
        tryte_t trytes[NUM_CHUNK_TRYTES];
        chars_to_trytes(chars + i * NUM_CHUNK_TRYTES, trytes, NUM_CHUNK_TRYTES);
        trytes_to_bytes(trytes, bytes + i * NUM_CHUNK_BYTES);
    }
}

void bytes_to_chars(const unsigned char *bytes, char *chars,
                    unsigned int bytes_len)
{
    for (unsigned int i = 0; i < bytes_len / NUM_CHUNK_BYTES; i++) {
        tryte_t trytes[NUM_CHUNK_TRYTES];
        bytes_to_trytes(bytes + i * NUM_CHUNK_BYTES, trytes);
        trytes_to_chars(trytes, chars + i * NUM_CHUNK_TRYTES, NUM_CHUNK_TRYTES);
    }
}

void bytes_set_last_trit_zero(unsigned char *bytes)
{
    uint32_t bigint[BIGINT_LENGTH];
    bytes_to_bigint(bytes, bigint);
    if (bigint_set_last_trit_zero(bigint)) {
        bigint_to_bytes(bigint, bytes);
    }
}

void bytes_add_u32_mem(unsigned char *bytes, uint32_t summand)
{
    if (summand > 0) {
        uint32_t bigint[BIGINT_LENGTH];

        bytes_to_bigint(bytes, bigint);
        bigint_add_u32_mem(bigint, summand);
        bigint_set_last_trit_zero(bigint);
        bigint_to_bytes(bigint, bytes);
    }
}
