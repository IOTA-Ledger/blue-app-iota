//
//  add_index_trint.c
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-12.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#include "add_index_tront.h"

//test the add index for trints against the default trits
bool test_add_idx_trints() {
    trit_t trits[243], new_trits[243];
    trint_t trints[49];
    
    gen_trits(&trits[0], 243);
    
    //convert our randomly generated trits into trints
    specific_243trits_to_49trints(&trits[0], &trints[0]);
    
    //arbitrarily choose 34 for adding index
    add_index_to_seed(&trits[0], 34);
    add_index_to_seed_trints(&trints[0], 34);
    
    //now that we've added index to trints, convert back to trits
    specific_49trints_to_243trits(&trints[0], &new_trits[0]);
    
    //compare (and return) whether they equal)
    return compare_trits(&trits[0], &new_trits[0], 243);
}

int add_index_to_seed(int8_t *trits, uint32_t index)
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

// TODO: make sure we can add more index than uint32
// This may be an area where it's better just to have the seed in trits
// while adding index, then convert to trints later.
// Similarly is there no faster way to incr ??
int add_index_to_seed_trints(int8_t *trints, uint32_t index)
{
    int8_t trits[4];
    uint8_t send = 4;
    
    for (uint32_t i = 0; i < index; i++) {
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
            if(offset % 4 == 0) {// we need a new set of trits
                //if offset/4 == 60 we are on last trint of only 3
                // this would be equivalent to if offset == 240;
                send = (offset/4 == 60) ? 3 : 4;
                
                //before we get new trint, write old trint
                if(offset != 0) //if this is the first trint, dont write
                    trints[(offset/4) - 1] = trits_to_trint(&trints[0], send);
                
                //get new set of trits
                trint_to_trits(trints[offset/4], &trits[0], send);
            }
            
            trits[offset % 4] = trits[offset % 4] + 1;
            if (trits[offset % 4] > 1) {
                trits[offset % 4] = -1;
            } else {
                //if we reach here, we are done so let's write the last trint
                carry = false;
                
                //use (uint8_t) to auto truncate offset/4
                if(offset < 4) trints[0] = trits_to_trint(&trits[0], send);
                else trints[(uint8_t)(offset/4)] = trits_to_trint(&trits[0], send);
            }
            if (carry) {
                offset++;
            }
            
            
        }
    }
    return 0;
}

