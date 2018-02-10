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

void any_trits_to_trints(trit_t *trits, trint_t *trints, size_t num_trits) {
    for (uint8_t i = 0; i < (num_trits / 243); i++) {
        specific_243trits_to_49trints(trits + i * 243, trints + i * 49);
    }
}

void any_trints_to_trits(trint_t *trints, trit_t *trits, size_t num_trints) {
    for (uint8_t i = 0; i < (num_trints / 49); i++) {
        specific_49trints_to_243trits(trints + i * 49, trits + i * 243);
    }
}


void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r) {
    uint8_t send = 0, count = 0;
    //send all trits in groups of 5 (last one just 3)
    for(uint8_t i = 0; i < 243; i += 5) {
        send = ((243 - i) < 5) ? 243 - i : 5;
        
        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
    for(uint8_t i = 0; i < 48; i++) {
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;
    
    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
        
        
        if(trits_r[j] > 1) trits_r[j] = 1;
        else if(trits_r[j] < -1) trits_r[j] = -1;
        
        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}

//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;
    
    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
        pow3_val *= 3;
    }
    
    return ret;
}


// Function to test Kerl and put the output in msg. You can just comment out the call in get_seed when in production.
void test_kerl(char *msg) {
    trint_t seed_trints[49];
    tryte_t seed_trytes[81] = {0};
    {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
        chars_to_trytes(test_kerl, seed_trytes, 81);
    }
    {
        trit_t seed_trits[81 * 3] = {0};
        trytes_to_trits(seed_trytes, seed_trits, 81);
        specific_243trits_to_49trints(seed_trits, seed_trints);
    }
    {
        cx_sha3_t sha3;
        kerl_initialize(&sha3);
        kerl_absorb_trints(&sha3, seed_trints, 49);
        kerl_absorb_trints(&sha3, seed_trints, 49);
        kerl_squeeze_trints(&sha3, seed_trints, 49);
    }
    {
        trit_t seed_trits[81 * 3] = {0};
        specific_49trints_to_243trits(seed_trints, seed_trits);
        trits_to_trytes(seed_trits, seed_trytes, 243);
        trytes_to_chars(seed_trytes, msg, 81);
    }
    {
        msg[81] = '\0';
    }
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

