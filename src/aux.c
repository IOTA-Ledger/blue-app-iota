#include "aux.h"
#include <stdint.h>
#include <string.h>
#include "common.h"
#include "main.h"

#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "iota/conversion.h"

#define PAD_CHAR '9'

bool validate_chars(const char *chars, unsigned int num_chars)
{
    const size_t len = strnlen(chars, num_chars);
    for (unsigned int i = 0; i < len; i++) {
        const char c = chars[i];
        if (c != '9' && (c < 'A' || c > 'Z')) {
            return false;
        }
    }

    return true;
}

void rpad_chars(char *destination, const char *source, unsigned int num_chars)
{
    const size_t len = strnlen(source, num_chars);
    os_memcpy(destination, source, len);
    os_memset(destination + len, PAD_CHAR, num_chars - len);
}

void get_seed(const unsigned char *entropy, unsigned int n,
              unsigned char *seed_bytes)
{
#ifndef DEBUG_SEED
    // at least one chunk of entropy required
    if (n < NUM_HASH_BYTES) {
        THROW(INVALID_PARAMETER);
    }

    cx_sha3_t sha;
    kerl_initialize(&sha);

    for (unsigned int i = 0; i < n / NUM_HASH_BYTES; i++) {
        kerl_absorb_chunk(&sha, entropy + i * NUM_HASH_BYTES);
    }
    // TODO: should we use standard padding rules?
    if (n % NUM_HASH_BYTES != 0) {
        kerl_absorb_chunk(&sha, entropy + (n - NUM_HASH_BYTES));
    }

    kerl_squeeze_final_chunk(&sha, seed_bytes);
#else  // DEBUG_SEED
    UNUSED(entropy);
    UNUSED(n);

    chars_to_bytes(DEBUG_SEED, seed_bytes, NUM_HASH_TRYTES);
#endif // DEBUG_SEED
}
