#include "aux.h"

#include <stdint.h>

// iota-related stuff
#include "vendor/iota/iota_types.h"
#include "vendor/iota/kerl.h"
#include "vendor/iota/conversion.h"
#include "vendor/iota/transaction.h"
#include "vendor/iota/addresses.h"

// Ideally include room for the null terminator
void uint_to_str(uint32_t i, char *str, uint8_t len) {
    snprintf(str, len, "%u", i);
}
// Ideally include room for null terminator
void int_to_str(int i, char *str, uint8_t len) {
    snprintf(str, len, "%d", i);
}

uint32_t str_to_int(char *str, uint8_t len) {
    uint32_t num = 0;
    //don't attempt to store more than 10 characters in a 32bit unsigned
    if(len > 10) len = 10;
    
    for(uint8_t i=0; i<len; i++){
        switch(str[i]) {
            case '0':
                num = (num * 10) + 0;
                break;
            case '1':
                num = (num * 10) + 1;
                break;
            case '2':
                num = (num * 10) + 2;
                break;
            case '3':
                num = (num * 10) + 3;
                break;
            case '4':
                num = (num * 10) + 4;
                break;
            case '5':
                num = (num * 10) + 5;
                break;
            case '6':
                num = (num * 10) + 6;
                break;
            case '7':
                num = (num * 10) + 7;
                break;
            case '8':
                num = (num * 10) + 8;
                break;
            case '9':
                num = (num * 10) + 9;
                break;
                //any other char means we are done
            default:
                return num;
        }
    }
    return num;
}

void get_seed(unsigned char *privateKey, uint8_t sz, uint32_t *seed_bigint) {
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
    const char test_seed[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
    chars_to_bigints(test_seed, seed_bigint, 81);
}

