//
//  misc.c
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-12.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#include "misc.h"

void gen_trits(int8_t *trits, int sz) {
    int8_t new_trits[sz];
    time_t t;
    sleep(2);
    /* Intializes random number generator */
    srand((unsigned) time(&t));
    
    for(int i=0; i<sz; i++) {
        int r = rand();      // returns a pseudo-random integer between 0 and RAND_MAX
        new_trits[i] = (r % 3) - 1;
    }
    
    memcpy(trits, &new_trits[0], sz);
}

void print_243trits(int8_t *trits) {
    printf("---------------\n");
    for(uint8_t i = 0; i < 243; i++) {
        printf("[%d] ", trits[i]);
    }
    printf("\n---------------\n");
}

bool compare_trits(trit_t *trits, trit_t *trits2, uint32_t sz) {
    for(uint8_t i=0; i < sz; i++) {
        if(trits[i] != trits2[i]) return false;
    }
    return true;
}

void print_bits(int8_t x) {
    int8_t ch_array[8];
    for(int i=7; i >= 0; i--)
    {
        if(x == 0) ch_array[i] = 0;
        else {
            ch_array[i] = x & 1;
            x = x >>1;
        }
    }
    
    for(int i=0; i<8; i++)
        printf("%d", ch_array[i]);
    
    printf("\n");
}

bool print_result(bool b) {
    if(b) printf("True");
    else printf("False");
    return b;
}
