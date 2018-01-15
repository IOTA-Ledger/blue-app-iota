//
//  misc.h
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-12.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#ifndef misc_h
#define misc_h

#include "main.h"
#include "aux.h"
#include "add_index_tront.h"
#include "test_conversions.h"

typedef int8_t trit_t;
typedef int8_t tryte_t;
typedef int8_t trint_t;
typedef int8_t tront_t;

bool print_result(bool b);
void print_bits(int8_t x);
bool compare_trits(trit_t *trits, trit_t *trits2, uint32_t sz);
void print_243trits(trit_t *trits);
void gen_trits(trit_t *trits, int sz);

#endif /* misc_h */
