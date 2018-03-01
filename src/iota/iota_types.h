#ifndef IOTA_TYPES_H
#define IOTA_TYPES_H

#include <string.h>
#include <stdint.h>
#include <stdbool.h>

typedef int8_t trit_t;
typedef int8_t tryte_t;

#define MIN_TRYTE_VALUE -13
#define MAX_TRYTE_VALUE 13

#define MAX_IOTA_VALUE INT64_C(2779530283277761) // (3^33-1) / 2

#endif // IOTA_TYPES_H
