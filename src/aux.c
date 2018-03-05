#include "aux.h"

#include <stdint.h>

// iota-related stuff
#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "iota/conversion.h"
#include "iota/addresses.h"
#include "iota/common.h"

#define MAX_64_INT 9223372036854775807

#define T_64 -64
#define T_32_U 32
#define T_32 -32
#define T_16_U 16
#define T_16 -16
#define T_8_U 8
#define T_8 -8


// len specifies max size of buffer
// if buffer doesn't fit whole int, returns null
void int_to_str(int64_t num, char *str, uint8_t len)
{
    // minimum buffer size of 2 (digit + \0)
    if (len < 2)
        return;

    int64_t i = 0;
    bool isNeg = false;

    // handle 0 first
    if (num == 0) {
        str[0] = '0';
        str[1] = '\0';
        return;
    }

    if (num < 0) {
        isNeg = true;
        num = -num;
    }

    // -922....808 is valid but gibberish
    if (num < -MAX_64_INT)
        num = MAX_64_INT;

    while (num != 0) {
        uint8_t rem = num % 10;
        str[i++] = rem + '0';
        num = num / 10;

        // ensure we have room for full int + null term
        if (i == len || (i == len - 1 && isNeg)) {
            str[0] = '\0';
            return;
        }
    }

    if (isNeg)
        str[i++] = '-';

    str[i--] = '\0';

    // reverse the string
    for (uint8_t j = 0; j < i; j++, i--) {
        char c = str[j];
        str[j] = str[i];
        str[i] = c;
    }
}

// safely takes 2^pow-1 up to max 64 bit val
int64_t pow2(int8_t pow)
{
    int64_t num = 2;

    if (pow > 32)
        return MAX_64_INT;

    for (uint8_t i = 0; i < pow - 1; i++)
        num *= 2;

    return num - 1;
}

int64_t get_max_val(int8_t bits)
{
    // if < 0 means signed type, so one less bit for value
    if (bits < 0)
        bits = -bits - 1;

    return pow2(bits);
}

int64_t get_min_val(int8_t bits)
{
    // unsigned type always min 0
    if (bits >= 0)
        return 0;

    // bits is negative
    bits = -bits - 1;

    return -pow2(bits);
}

// len specifies length of number (789 is 3 digits).
// any large enough number works (reads until non digit char)
// integer overflow sets to largest possible int
int64_t str_to_int(char *str, uint8_t len, uint8_t *err, int8_t type)
{
    *err = 0; // start off without error
    bool isNeg = false;
    int64_t num = 0;
    int64_t max_val = get_max_val(type);
    int64_t min_val = get_min_val(type);

    // max val is 0 on invalid type
    if (max_val == 0) {
        *err = 3;
        return 0;
    }

    if (str[0] == '-') {
        isNeg = true;
        str++;
    }
    for (uint8_t i = 0; i < len; i++) {
        // ensure it is still a number
        if (str[i] < '0' || str[i] > '9')
            break;

        // ensure we don't overflow on multiplication
        if (num > max_val / 10) {
            *err = 1;
            break;
        }
        // ensure we don't overflow on addition
        if (num * 10 > max_val - (str[i] - '0')) {
            *err = 2;
            break;
        }

        num = (num * 10) + str[i] - '0';
    }

    // overflow detected so set to largest int
    if (*err)
        num = max_val;

    if (isNeg)
        num = -num;

    if (num < min_val) {
        *err = 3;
        return min_val;
    }

    return num;
}

int64_t bytes_to_int(unsigned char *bytes, uint8_t len)
{
    int64_t num = 0;

    // don't attempt to read more than 8 bytes into 64 bit int
    len = MIN(len, 8);

    for (int i = 0; i < len; i++) {
        num = (num << 8) + bytes[i];
    }

    return num;
}

void get_seed(const unsigned char *privateKey, uint8_t sz,
              unsigned char *seed_bytes)
{
    // {
    //   // localize bytes_in variable to discard it when we are done
    //   unsigned char bytes_in[48];
    //
    //   // kerl requires 424 bytes
    //   kerl_initialize();
    //
    //   // copy our private key into bytes_in
    //   // for now just re-use the last 16 bytes to fill bytes_in
    //   memcpy(&bytes_in[0], privateKey, sz);
    //   memcpy(&bytes_in[sz], privateKey, 48-sz);
    //
    //   // absorb these bytes
    //   kerl_absorb_bytes(&bytes_in[0], 48);
    // }

    // override for testing purposes
    const char test_seed[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETE"
                             "RPETERPETERPETERPETERPETERPETERR";
    chars_to_bytes(test_seed, seed_bytes, 81);
}
