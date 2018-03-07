#include "aux.h"

#include <stdint.h>

#include "iota/common.h"
#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "iota/conversion.h"


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

void get_seed(const unsigned char *privateKey, unsigned int sz,
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
