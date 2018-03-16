#ifndef AUX_H
#define AUX_H

#include <stdbool.h>

/** @brief Checks whether a given string is a valid base-27 encoding.
 *  Input is checked until num_chars or zero character is reached.
 *  @param chars string to check
 *  @param num_chars number of expected charecters
 *  @param zero_padding true, if the string should be padded with '9's
 */
bool validate_chars(char *chars, unsigned int num_chars, bool zero_padding);

/** @brief Computes a valid IOTA seed based on the provided entropy.
 *  @param n number of entropy bytes
 *  @param seed_bytes target array to store the seed in 48 byte encoding
 */
void get_seed(const unsigned char *entropy, unsigned int n,
              unsigned char *seed_bytes);

#endif // AUX_H
