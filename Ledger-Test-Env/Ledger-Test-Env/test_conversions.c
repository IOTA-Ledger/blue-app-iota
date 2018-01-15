//
//  test_conversions.c
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-12.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#include "test_conversions.h"

//generate 54 fragments - equivalent of entire private key
uint32_t frags = 54;

bool test_conversions() {
    int8_t trits[243 * frags], new_trits[243 * frags];
    
    gen_trits(&trits[0], 243*frags);
    
    int8_t trints[49 * frags];
    
    //read in 54 sets of 243 trits
    for(uint8_t i = 0; i < frags; i++) {
        specific_243trits_to_49trints(&trits[i * 243], &trints[i * 49]);
    }
    
    //this memory space is much more manageable
    //now let's convert back and verify they are the same
    for(uint8_t i = 0; i < frags; i++) {
        specific_49trints_to_243trits(&trints[i * 49], &new_trits[i * 243]);
    }
    
    return compare_trits(&trits[0], &new_trits[0], 243*frags);
}

