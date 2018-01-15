//
//  add_index_trint.h
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-12.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#ifndef add_index_tront_h
#define add_index_tront_h

#include "main.h"
#include "aux.h"
#include "test_conversions.h"
#include "misc.h"

typedef int8_t trit_t;
typedef int8_t tryte_t;
typedef int8_t trint_t;
typedef int8_t trint_t;

bool test_add_idx_trints(void);
int add_index_to_seed_trints(trint_t *trints, uint32_t index);
int add_index_to_seed(trit_t *trits, uint32_t index);

#endif /* add_index_trint_h */

