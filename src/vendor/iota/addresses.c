#include "addresses.h"
#include "kerl.h"
#include "../../aux.h"

// TODO: make sure we can add more index than uint32
int add_index_to_seed(trit_t trits[], uint32_t index)
{
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

int generate_private_key(trit_t *seed_trits, uint32_t index, trint_t *private_key)
{
    return 0;
    trit_t tmp[243];
    memcpy(tmp, seed_trits, 243);
    
    // Add index
    add_index_to_seed(tmp, index);
    
    kerl_initialize();
    kerl_absorb_trits(tmp, 243);
    kerl_squeeze_trits(tmp, 243);
    
    kerl_initialize();
    kerl_absorb_trits(tmp, 243);
    
    //trit_t private_key - (it costs 49 trints to store 243 trits)
    //int8_t trints[54][49]; will be the format that holds the private key
    
    int8_t level = 2;
    for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) { //we do this 54 times
            // each of the 54 times we have 81 trytes (243 trits)
            
            // squeeze out 243 trits, but store it much more efficiently
            // we need 49 bytes to store 243 trits (5 trits per byte)
            kerl_squeeze_trits(&tmp[0], 243);
            
            //each call stores 49 trints into buffer (so j*49), each loop in i stores 27 j's (*49)
            specific_243trits_to_49trints(&tmp[0], &private_key[i*27*49 +j*49]);
        }
    }
    return 0;
}

int generate_public_address(const trit_t private_key[], trit_t address_out[])
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
                kerl_initialize();
                kerl_absorb_trits(&key_fragment[j*243], 243);
                kerl_squeeze_trits(&key_fragment[j*243], 243);
            }
        }

        kerl_initialize();
        kerl_absorb_trits(key_fragment, 243*27);
        kerl_squeeze_trits(&digests[i*243], 243);
    }
	//layoutProgress(_("Generating address."), 1000);

    // Get address
    kerl_initialize();
    kerl_absorb_trits(digests, 243*2);
    kerl_squeeze_trits(address_out, 243);
    return 0;
}

// TODO: make sure we can add more index than uint32
// Just incr trit value, wrapping around
int add_index_to_seed_trints(trint_t *trints, uint32_t index)
{
    trit_t trits[5];
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

// generates half of a private key to encoded format of trints
int generate_private_key_half(trint_t *seed_trints, uint32_t index, trint_t *private_key)
{
    // Add index -- keep in mind fix index_to_seed
    add_index_to_seed_trints(&seed_trints[0], index);
    
    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);
    kerl_squeeze_trints(&private_key[0], 49);
    
    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);
    
    //Set level to be 1 - only do first half of private key for now
    int8_t level = 1;
    for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) {
            //27 chunks makes up half the private key
            
            // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
            kerl_squeeze_trints(&private_key[j * 49], 49);
        }
    }
    return 0;
}

int generate_public_address_half(const trit_t private_key[], trit_t address_out[])
{
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

