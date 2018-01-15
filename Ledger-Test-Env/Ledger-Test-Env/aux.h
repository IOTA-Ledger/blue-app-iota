#ifndef AUX_H
#define AUX_H

#include "main.h"
#include "add_index_tront.h"
#include "test_conversions.h"
#include "misc.h"

typedef int8_t trit_t;
typedef int8_t tryte_t;
typedef int8_t trint_t;
typedef int8_t trint_t;

int8_t trits_to_trint(int8_t *trits, int8_t sz);
void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz);
void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r);
void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r);


#endif // AUX_H

