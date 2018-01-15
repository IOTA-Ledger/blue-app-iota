//
//  test_transactions.c
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-13.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#include "test_transactions.h"

void tag_increment(trit_t trits[])
{
    // Add one
    uint8_t offset = 0;
    bool carry = true;
    while(carry && offset < 81) {
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
