#ifndef AUX_H
#define AUX_H

#include <stdbool.h>
#include <stdint.h>

void int_to_str(int64_t num, char *str, uint8_t len);

bool validate_chars(char *chars, unsigned int num_chars, bool zero_padding);

void get_seed(const unsigned char *privateKey, unsigned int sz,
              unsigned char *seed_bytes);

#endif // AUX_H
