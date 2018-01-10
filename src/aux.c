#include "main.h"
#include "ui.h"
#include "aux.h"


char debug_str[64];

//write_debug(&words, sizeof(words), TYPE_STR);
//write_debug(&int_val, sizeof(int_val), TYPE_INT);
void write_debug(void* o, unsigned int sz, uint8_t t) {

    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
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

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
    
    //kerl requires 424 bytes
    kerl_initialize();
    
    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
        memcpy(&bytes_in[sz], privateKey, 48-sz);
        
        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
    }
    
    trint_t seed_trints[49];
    { // localize the unencoded seed trits
        // Squeeze out the seed
        trit_t seed_trits[243];
        kerl_squeeze_trits(seed_trits, 243);
        
        specific_243trits_to_49trints(&seed_trits[0], &seed_trints[0]);
    }
    // testing seed trits first 5 are -1 -1 -1 0 -1
    // tested with trints and the first trint is -1 -1 -1 0 -1
   
    
// TODO - delete these commented out lines, change msg to return trints - and decode DIRECTLY
// into return buffer
// *----------------------------------------------------*
    
    // Convert trits to trytes
//    tryte_t seed_trytes[81];
//    trits_to_trytes(seed_trits, seed_trytes, 243);

    //char seed_chars[82];
    //trytes_to_chars(seed_trytes, seed_chars, 81);

    //null terminate seed
    //seed_chars[81] = '\0';
    
    //pass trits to private key func and let it handle the response
    get_private_key(&seed_trints[0], 0, msg);
}

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
   
/* Debug trints being passed */
    trit_t trits[5];
    trint_to_trits(seed_trints[0], &trits[0], 5);
    
    snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", trits[0], trits[1],
             trits[2], trits[3], trits[4]);
/* */
    //currently able to store 29 - [-1][-1][-1][0]
    trint_t private_key_trints[49 * 10]; //trints are still just int8_t but encoded
    mygenerate_private_key(seed_trints, idx, &private_key_trints[0]);
}




// TODO: make sure we can add more index than uint32
// all this does is increment the trit value by index
int myadd_index_to_seed(trint_t *trits, uint32_t index)
{
    trit_t tmp_trits[5];
    //TODO --  have it index based off of trints and not trits
    // for now we call with index 0 so who cares
    for (uint32_t i = 0; i < index; i++) {
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
            trits[offset] = trits[offset] + 1;
            if (trits[offset] > 1) {
                trits[offset] = -1;
            } else {
                carry = false;
            }
            if (carry) {
                offset++;
            }
        }
    }
    return 0;
}

//EITHER SWITCH TO ENTIRELY 4 TRITS PER BYTE, OR KEEP MEMORY OPTIMIZED IN 5, AND THEN CONVERT TO 4 ON THE FLY
// THIS WAY WE CAN GET THE EXACT BITS OF AN UNENCODED TRIT WITHOUT STORING THEM LIKE SHIT
// ALSO we can save 1 int8_t per 243 if we are doing it by 4's, so maybe done force clump to 243.
// would save 27 ints in the half of a private key
// which is only like 300 more bytes
//4 / byte is 61 trints so 61 * 27 - 1647 bytes
// 1647 bytes is 34.
// Convert to global memory and reduce any local trit[243]'s.

//re-code kerl to allow absorbing encoded trits
int mygenerate_private_key(trint_t *seed_trints, uint32_t index, trint_t *private_key)
{
    // Add index -- keep in mind fix index_to_seed
    myadd_index_to_seed(&seed_trints[0], index);
    
    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);
    kerl_squeeze_trints(&private_key[0], 49);
    
    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);
    return 0;
    
    //ignore i (which will do first half and second half and only do half)
    //int8_t level = 2;
    //for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) {
            //27 chunks makes up half the private key
            
            // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
            kerl_squeeze_trints(&private_key[0], 49);
        }
    //}
    return 0;
}

//write the private key in pieces to nvram, read only buffer it back into kerl absorb********************
int mygenerate_public_address(const trit_t private_key[], trit_t address_out[])
{
    //We now have trints[54][49] - 54 sets of 243 trits
    //digest it in groups of 2
    // Get digests
    trit_t digests[243*2];
    
    for (uint8_t i = 0; i < 2; i++) {
        trit_t key_fragment[243*27];
        memcpy(key_fragment, &private_key[i*243*27], 243*27);
        
        for (uint8_t j = 0; j < 27; j++) {
            //int progress = ((i*27 + j)*18519)/1000;
            //layoutProgress(_("Generating address."), progress);
            for (uint8_t k = 0; k < 26; k++) {
                ////kerl_initialize();
                kerl_absorb_trits(&key_fragment[j*243], 243);
                kerl_squeeze_trits(&key_fragment[j*243], 243);
            }
        }
        
        ////kerl_initialize();
        kerl_absorb_trits(key_fragment, 243*27);
        kerl_squeeze_trits(&digests[i*243], 243);
    }
    //layoutProgress(_("Generating address."), 1000);
    
    // Get address
    ////kerl_initialize();
    kerl_absorb_trits(digests, 243*2);
    kerl_squeeze_trits(address_out, 243);
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    trit_t tmp_trits[243];
    //break up trints into batches of 49 (243 trits)
    for (uint8_t i = 0; i < (len/49); i++) {
        //generate this batch of 243 trits
        specific_49trints_to_243trits(&trints_in[i*49], &tmp_trits[0]);
        //ship em off to be absorbed
        kerl_absorb_trits(&tmp_trits[0], 243);
    }
    return 0;
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
    trit_t tmp_trits[243];
    //squeeze the bytes into our temp buffer
    kerl_squeeze_trits(tmp_trits, 243);
    
    //use buffer to convert and return trints
    specific_243trits_to_49trints(&tmp_trits[0], trints_out);
    
    return 0;
}
