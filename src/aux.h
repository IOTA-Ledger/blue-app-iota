#ifndef AUX_H
#define AUX_H

#include <stdbool.h>

bool validate_chars(char *chars, unsigned int num_chars, bool zero_padding);

void get_seed(const unsigned char *privateKey, unsigned int sz,
              unsigned char *seed_bytes);

#endif // AUX_H
