#ifndef AUX_H
#define AUX_H

#include <stdbool.h>

/** @brief Checks whether a given string is a valid base-27 encoding.
 *  Input is checked until num_chars or zero character is reached.
 *  @param chars string to check
 *  @param num_chars number of expected charecters
 */
bool validate_chars(const char *chars, unsigned int num_chars);

/** @brief Copies chars and adds padding if shorter than the expected length.
 *  @param destination target string
 *  @param source string to copy and pad
 *  @param num_chars number of expected charecters
 */
void rpad_chars(char *destination, const char *source, unsigned int num_chars);

/** @brief Computes a valid IOTA seed based on the provided entropy.
 *  @param n number of entropy bytes
 *  @param seed_bytes target array to store the seed in 48 byte encoding
 */
void get_seed(const unsigned char *entropy, unsigned int n,
              unsigned char *seed_bytes);

#endif // AUX_H
