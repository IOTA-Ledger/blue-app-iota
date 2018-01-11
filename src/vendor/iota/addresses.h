#ifndef ADDRESSES_H
#define ADDRESSES_H

#include "iota_types.h"

int add_index_to_seed(trit_t trits[], uint32_t index);
int generate_private_key(trit_t *seed_trits, uint32_t index, trint_t *private_key);
int generate_public_address(const trit_t private_key[], trit_t address_out[]);

//Generate based on trints
int add_index_to_seed_trints(trint_t *trints, uint32_t index);
int generate_private_key_half(trint_t *seed_trints, uint32_t index, trint_t *private_key);

#endif // ADDRESSES_H
