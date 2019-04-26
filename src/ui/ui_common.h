#ifndef UI_COMMON_H
#define UI_COMMON_H

#include <string.h>
#include <stdint.h>

/// the largest power of 10 that still fits into int32
#define MAX_INT_DEC INT64_C(1000000000)

extern const char IOTA_UNITS[6][3];

size_t str_add_commas(char *dst, const char *src, size_t num_len);
size_t snprint_int64(char *s, size_t n, int64_t val);
uint8_t menu_to_tx_idx(void);
void write_full_val(int64_t val, char *dest, unsigned int len);
void write_readable_val(int64_t val, char *dest, unsigned int len);

#endif // UI_COMMON_H
