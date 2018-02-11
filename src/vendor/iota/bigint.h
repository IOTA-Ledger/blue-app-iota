//
//  bigint.h
//  Ledger-Test-Env
//
//  Created by Tyler Hann on 2018-01-13.
//  Copyright © 2018 Tyler Hann. All rights reserved.
//

#ifndef bigint_h
#define bigint_h

#include "iota_types.h"

//fulladd
struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry);
struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry);


//bigint add
int bigint_add_int_u(const uint32_t bigint_in[], uint32_t int_in,
                     uint32_t bigint_out[], uint8_t len);
int bigint_add_int_u_mem(uint32_t *bigint_in, uint32_t int_in, uint8_t len);

int bigint_add_intarr_u_mem(uint32_t *bigint_in, const uint32_t *int_in, uint8_t len);

//bigint sub
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len);
int bigint_sub_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[],
                        uint32_t bigint_out[], uint8_t len);

//misc
int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[],
                           const uint32_t bigint_two[], uint8_t len);
int bigint_not_u(uint32_t bigint[], uint8_t len);

#endif /* bigint_h */
