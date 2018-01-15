//
//  add_index_tront.c
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-12.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#include "add_index_tront.h"

//test the add index for tronts against the default trits
bool test_add_idx_tronts() {
    trit_t trits[243], new_trits[243];
    tront_t tronts[61];
    
    gen_trits(&trits[0], 243);
    
    //convert our randomly generated trits into tronts
    specific_243trits_to_61tronts(&trits[0], &tronts[0]);
    
    //arbitrarily choose 34 for adding index
    add_index_to_seed(&trits[0], 34);
    add_index_to_seed_tronts(&tronts[0], 34);
    
    //now that we've added index to tronts, convert back to trits
    specific_61tronts_to_243trits(&tronts[0], &new_trits[0]);
    
    //compare (and return) whether they equal)
    return compare_243trits(&trits[0], &new_trits[0]);
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
int add_index_to_seed_tronts(int8_t *tronts, uint32_t index)
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
                    tronts[(offset/4) - 1] = trits_to_tront(&tronts[0], send);
                
                //get new set of trits
                tront_to_trits(tronts[offset/4], &trits[0], send);
            }
            
            trits[offset % 4] = trits[offset % 4] + 1;
            if (trits[offset % 4] > 1) {
                trits[offset % 4] = -1;
            } else {
                //if we reach here, we are done so let's write the last trint
                carry = false;
                
                //use (uint8_t) to auto truncate offset/4
                if(offset < 4) tronts[0] = trits_to_tront(&trits[0], send);
                else tronts[(uint8_t)(offset/4)] = trits_to_tront(&trits[0], send);
            }
            if (carry) {
                offset++;
            }
            
            
        }
    }
    return 0;
}
