#include "aux.h"
#include <stdint.h>
#include "main.h"

#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "iota/conversion.h"

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


bool validate_chars(char *chars, unsigned int num_chars, bool zero_padding)
{
    const size_t len = strnlen(chars, num_chars);
    for (unsigned int i = 0; i < len; i++) {
        const char c = chars[i];
        if (c != '9' && (c < 'A' || c > 'Z')) {
            return false;
        }
    }

    if (zero_padding) {
        for (unsigned int i = len; i < num_chars; i++) {
            chars[i] = '9';
        }
    }

    return true;
}

void get_seed(const unsigned char *entropy, unsigned int n,
              unsigned char *seed_bytes)
{
#ifndef DEBUG_SEED
    // at least one chunk of entropy required
    if (n < 48) {
        THROW(INVALID_PARAMETER);
    }

    cx_sha3_t sha;
    kerl_initialize(&sha);

    for (unsigned int i = 0; i < n / 48; i++) {
        kerl_absorb_chunk(&sha, entropy + i * 48);
    }
    // TODO: should we use standard padding rules?
    if (n % 48 != 0) {
        kerl_absorb_chunk(&sha, entropy + (n - 48));
    }

    kerl_squeeze_final_chunk(&sha, seed_bytes);
#else  // DEBUG_SEED
    UNUSED(entropy);
    UNUSED(n);

    chars_to_bytes(DEBUG_SEED, seed_bytes, 81);
#endif // DEBUG_SEED
}
