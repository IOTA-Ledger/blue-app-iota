#ifndef IOTA_TYPES_H
#define IOTA_TYPES_H

#include <stdint.h>
#include "iota/kerl.h"

typedef int8_t trit_t;
typedef int8_t tryte_t;

#define TRIT_MIN (-1)
#define TRIT_MAX 1

#define TRYTE_MIN (-13)
#define TRYTE_MAX 13
#define UTRYTE_MAX 26

#define TRITS_PER_TRYTE 3

#define MAX_IOTA_VALUE INT64_C(2779530283277761) // (3^33-1) / 2

#define MIN_SECURITY_LEVEL 1
#define MAX_SECURITY_LEVEL 3

#define NUM_HASH_TRYTES 81
#define NUM_HASH_TRITS (NUM_HASH_TRYTES * TRITS_PER_TRYTE)
#define NUM_HASH_BYTES (KERL_HASH_SIZE)
#define NUM_CHECKSUM_TRYTES 9
#define NUM_ADDRESS_TRYTES (NUM_HASH_TRYTES + NUM_CHECKSUM_TRYTES)
#define NUM_TAG_TRYTES 27

#define NUM_HASH_FRAGMENT_TRYTES 27

#endif // IOTA_TYPES_H
