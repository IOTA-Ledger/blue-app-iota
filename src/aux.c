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
    
    // A trint_t is 5 trits encoded as 1 int8_t - Used to massively
    // reduce RAM required
    trint_t seed_trints[49];
    kerl_squeeze_trints(&seed_trints[0], 49);
    
/* ----- This code is left here to test absorb/squeeze. (the above squeeze trints)
            should generate the same trits as squeeze_trits and converting after
 
 * /     // ------ TAKE OUT THE SPACE BETWEEN * AND / HERE TO UNCOMMENT IT QUICKLY
    {
        //testing absorb and squeeze, I get 0 -1 1 -1 -1
        trit_t seed_trits[243];
        specific_49trints_to_243trits(&seed_trints[0], &seed_trits[0]);
        //absorb/squeeze via trits, then via trints, both should be same!
        kerl_absorb_trints(&seed_trints[0], 49);
        kerl_squeeze_trints(&seed_trints[0], 49);
        
//        kerl_absorb_trits(seed_trits, 243);
//        kerl_squeeze_trits(seed_trits, 243);

/*      Debug trints being passed
 
 * / // --------- AND TAKE OUT SPACE HERE
        trit_t trits[5];
        trint_to_trits(seed_trints[0], &trits[0], 5);
        
        //set this to seed_trits[0...5] to test abosrb/squeeze via trints
        //set to trits[0...5] to test via trits
        snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", seed_trits[0], seed_trits[1],
                 seed_trits[2], seed_trits[3], seed_trits[4]);
    }
    return; // when testing absorb/squeeze all we care about is done right here
*/
   
    
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
    
    //pass trints to private key func and let it handle the response
    get_private_key(&seed_trints[0], 0, msg);
}

//write func to get private key
void get_private_key(trint_t *seed_trints, uint32_t idx, char *msg) {
    // Generating public key takes about 1min per half (2min total)
    // Set k=25 in public key code to make it about 10s total
    
    trint_t public_key_trints[49];
    { // localize the memory for private key
        //currently able to store 31 - [-1][-1][-1][0][-1]
        trint_t private_key_trints[49 * 27]; //trints are still just int8_t but encoded
        
        //generate private key using level 1 for first half
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 1, msg);
        //use this half to generate half public key 1
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 1);
        
        //use level 2 to generate second half of private key
        generate_private_key_half(seed_trints, idx, &private_key_trints[0], 2, msg);
        
        //finally level 2 to generate second half of public key (and then digests both)
        generate_public_address_half(&private_key_trints[0], &public_key_trints[0], 2);
    }
    // 12s to get here if k=25, 2min otherwise
    //now public key will hold the actual public address
    trit_t pub_trits[243];
    specific_49trints_to_243trits(&public_key_trints[0], &pub_trits[0]);
    
    tryte_t seed_trytes[81];
    trits_to_trytes(pub_trits, seed_trytes, 243);
    
    trytes_to_chars(seed_trytes, msg, 81);
    
    //null terminate the public key
    msg[81] = '\0';
}

