#ifndef IOTA_TYPES_H
#define IOTA_TYPES_H

#include <string.h>
#include <stdint.h>

typedef int8_t trit_t;
typedef int8_t tryte_t;

#define MIN_TRIT_VALUE -1
#define MAX_TRIT_VALUE 1

#define MIN_TRYTE_VALUE -13
#define MAX_TRYTE_VALUE 13

#define MAX_IOTA_VALUE INT64_C(2779530283277761) // (3^33-1) / 2

#define MIN_SECURITY_LEVEL 1
#define MAX_SECURITY_LEVEL 3

#endif // IOTA_TYPES_H
