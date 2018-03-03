#include "aux.h"

#include <stdint.h>

// iota-related stuff
#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "iota/conversion.h"
#include "iota/addresses.h"

// len specifies max size of buffer
// if buffer doesn't fit whole int, returns null
void int_to_str(int64_t num, char *str, uint8_t len)
{
    // don't do anything if buffer isn't big enough
    if (len < 2) {
        return;
    }

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

// len specifies length of number (789 is 3 digits).
// any large enough number works (reads until non digit char)
// too large overflows the integer
int64_t str_to_int(char *str, uint8_t len)
{
    bool isNeg = false;
    int64_t num = 0;
    // including negative sign, max 20 chars in 64 bit int
    if (len > 20)
        len = 20;

    if (str[0] == '-') {
        isNeg = true;
        str++;
    }

    for (uint8_t i = 0; i < len; i++) {
        // ensure it is still a number
        if (str[i] < '0' || str[i] > '9')
            break;

        num = (num * 10) + str[i] - '0';
    }

    if (isNeg)
        num = -num;

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
