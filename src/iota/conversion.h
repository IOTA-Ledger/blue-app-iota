/** @file conversion.h
 *  @brief Function for ternary related conversions.
 */

#ifndef CONVERSION_H
#define CONVERSION_H

#include <stddef.h>
#include <stdint.h>
#include "iota_types.h"

/** @brief Converts a balanced ternary number in base-27 encoding into its
 *         trit representation.
 *  @param chars base-27 encoded ternary number
 *  @param trits target trit array
 *  @param chars_len length of the input char array
 */
void chars_to_trits(const char *chars, trit_t *trits, unsigned int chars_len);

/** @brief Converts a single signed integer into its ternary representation.
 *  @param value signed integer to convert
 *  @param trits target trit array
 *  @param num_trits number of trits to convert
 *  @return true, if an overflow occured and the given integer could not be
            completely represented with this number of trits, false otherwise.
 */
bool int64_to_trits(int64_t value, trit_t *trits, unsigned int num_trits);

/** @brief Converts a balanced ternary number into a big-enadian binary integer.
 *  The input must consist of exactly one 243-trit chunk and is converted into
 *  one big-endian 48-byte integer.
 *  @param trits trit array consisting of exectly 243 trits
 *  @param bytes target byte array
 */
void trits_to_bytes(const trit_t *trits, unsigned char *bytes);

/** @brief Converts a balanced ternary number in base-27 encoding into a
 *         big-enadian binary integer.
 *  The input must consist of multiples of 81-char chunks, each chunk is
 *  converted into a big-endian 48-byte integer
 *  @param chars base-27 encoded ternary number
 *  @param bytes target byte array
 *  @param chars_len length of the input
 */
void chars_to_bytes(const char *chars, unsigned char *bytes, unsigned int chars_len);

/** @brief Converts a big-enadian binary integer into a balanced ternary number
 *         in base-27 encoding.
 *  The input must consist of one or more big-endian 48-byte integers, each
 *  integer is sequentially converted into 81 chars and zero-terminated in the end.
 *  @param bytes input big-endian 48-byte integers
 *  @param chars zero-terminated base-27 encoded ternary representation
 *  @param bytes_len number of input bytes
 */
void bytes_to_chars(const unsigned char *bytes, char *chars, unsigned int bytes_len);

/** @brief Sets the 243th trit to zero.
 *  If the byte array represents a balanced ternary number which has the
 *  243th trit set to +1/-1, the number is adapted to the corresponding
 *  binary where this trit is 0.
 *  @param bytes array consisting of 48 bytes.
 */
void bytes_set_last_trit_zero(unsigned char *bytes);

/** @brief Adds a single integer to a 48-byte big-enadian integer.
 *  The bytes are changed in such a way, that they are still a vaild big-endian
 *  binary representation of a ternary number, i.e. the 243th trit is set to 0.
 *  @param bytes input big-endian 48-byte integer
 *  @param summand unsigned number to add
 */
void bytes_add_u32_mem(unsigned char *bytes, uint32_t summand);

#endif // CONVERSION_H
