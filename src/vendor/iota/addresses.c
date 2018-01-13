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
    trit_t tmp[243];
    memcpy(tmp, seed_trits, 243);
    
    // Add index
    add_index_to_seed(tmp, index);
    
    kerl_initialize();
    kerl_absorb_trits(tmp, 243);
    kerl_squeeze_trits(tmp, 243);
    
    kerl_initialize();
    kerl_absorb_trits(tmp, 243);
    
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
// This may be an area where it's better just to have the seed in trits
// while adding index, then convert to trints later.
// Similarly is there no faster way to incr ??
int add_index_to_seed_trints(int8_t *trints, uint32_t index)
{
    int8_t trits[5];
    uint8_t send = 5;
    
    for (uint32_t i = 0; i < index; i++) {
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
            if(offset % 5 == 0) {// we need a new set of trits
                //if offset/5 == 48 we are on last trint of only 3
                // this would be equivalent to if offset == 240;
                send = (offset/5 == 48) ? 3 : 5;
                
                //before we get new trint, write old trint
                if(offset != 0) //if this is the first trint, dont write
                    trints[(offset/5) - 1] = trits_to_trint(&trits[0], send);
                
                //get new set of trits
                trint_to_trits(trints[offset/5], &trits[0], send);
            }
            
            trits[offset % 5] = trits[offset % 5] + 1;
            if (trits[offset % 5] > 1) {
                trits[offset % 5] = -1;
            } else {
                //if we reach here, we are done so let's write the last trint
                carry = false;
                
                //use (uint8_t) to auto truncate offset/5
                if(offset < 5) trints[0] = trits_to_trint(&trits[0], send);
                else trints[(uint8_t)(offset/5)] = trits_to_trint(&trits[0], send);
            }
            if (carry) {
                offset++;
            }
            
            
        }
    }
    return 0;
}

// generates half of a private key to encoded format of trints
// use level 1 for first half, level 2 for second half
int generate_private_key_half(trint_t *seed_trints, uint32_t index,
                              trint_t *private_key, uint8_t level, char *msg)
{
    // Add index -- keep in mind fix index_to_seed
    add_index_to_seed_trints(&seed_trints[0], index);
    
/*    //Printing seed here will show us how our add_index went
 * /
    trit_t trits[5];
    trint_to_trits(seed_trints[0], &trits[0], 5);
    
    snprintf(&msg[0], 64, "[%d][%d][%d][%d][%d]\n", trits[0], trits[1],
             trits[2], trits[3], trits[4]);
 /* */
    
    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);
    kerl_squeeze_trints(&private_key[0], 49);
    
    kerl_initialize();
    kerl_absorb_trints(&seed_trints[0], 49);
    
    //level == 1 means generate first half of private key
    for (uint8_t j = 0; j < 27; j++) {
        //27 chunks makes up half the private key
        
        // THIS SHOULD TAKE ROUGHLY 3 SECONDS ELSE IT HUNG
        kerl_squeeze_trints(&private_key[j * 49], 49);
        
        //the first level just store it, if second half, discard
        //entire first half (OPTIMIZE!!!)
        if(j == 26 && level != 1) {
            j = 0;  //reset j so it can just go again,
                    //overwriting first half with second half
            level = 1; // use this as a flag to tell it to not enter infinite loop
        }
    }
    return 0;
}

//Generate the public key half at a time
//Use level 1 to generate first half, level 2 to generate second half
int generate_public_address_half(trint_t *private_key, trint_t *address_out, uint8_t level)
{
    for(uint8_t j = 0; j < 27; j++) {
        // each piece get's kerl'd 26 times(?)
        for(uint8_t k = 0; k < 26; k++) {
            //temp set k=25 to make this a LOT faster
            k = 25;
            kerl_initialize();
            kerl_absorb_trints(&private_key[j*49], 49);
            kerl_squeeze_trints(&private_key[j*49], 49);
        }
    }
    
    //the 27th kerl generates the digests
    kerl_initialize();
    kerl_absorb_trints(private_key, 49*27); // re-absorb the entire private key
    
    // use level 1 to pass the first half of the private key, store
    // digest in public key for now to save RAM
    if(level == 1)
        kerl_squeeze_trints(address_out, 49); // Store the first digest just in address_out{
    else {
        //done with private key, so store the second digest in private key
        kerl_squeeze_trints(private_key, 49);
        
        //now get address
        kerl_initialize();
        //address out stores first half, private key stores second half
        kerl_absorb_trints(address_out, 49);
        kerl_absorb_trints(private_key, 49);
        //finally publish the public key
        kerl_squeeze_trints(address_out, 49);
    }
    
    return 0;
}

