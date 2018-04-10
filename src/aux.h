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

#endif // AUX_H
