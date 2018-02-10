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

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len);
int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len);
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len);
int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len);
int bigint_not(int32_t bigint[], uint8_t len);

//my adds
int bigint_add_intarr_u(const uint32_t bigint_in[], const uint32_t int_in[], uint32_t bigint_out[], uint8_t len);

int bigint_add_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len);
int bigint_not_u(uint32_t bigint[], uint8_t len);
int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len);
int bigint_sub_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len);
int bigint_add_int_u(const uint32_t bigint_in[], uint32_t int_in, uint32_t bigint_out[], uint8_t len);


int bigint_add_int_u_mem(uint32_t bigint_in[], uint32_t int_in, uint8_t len);
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len);
int bigint_add_intarr_u_mem(uint32_t *bigint_in, const uint32_t *int_in, uint8_t len);

#endif /* bigint_h */
