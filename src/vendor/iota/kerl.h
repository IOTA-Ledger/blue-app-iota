/** @file kerl.h
 *  @brief Kerl functionality on raw byte data.
 */

#ifndef KERL_H
#define KERL_H

#include "common.h"

/** @brief Initializes the context for Kerl.
 *  @param sha3 the SHA context used.
 */
void kerl_initialize(cx_sha3_t *sha3);

/** @brief Absorb exactly one chunk of 48 bytes.
 *  @param sha3 the SHA context used for hashing.
 *  @param bytes bytes to absorb.
 */
void kerl_absorb_chunk(cx_sha3_t *sha3, const unsigned char* bytes);

/** @brief Absorb arbitrary number of bytes.
 *  @param sha3 the SHA context used for hashing.
 *  @param bytes bytes to absorb.
 */
void kerl_absorb_bytes(cx_sha3_t *sha3, const unsigned char* bytes, unsigned int len);

/** @brief Squeeze exactly one chunk of 48 bytes.
 *  @param sha3 the SHA context used for hashing.
 *  @param bytes result byte array
 */
void kerl_squeeze_chunk(cx_sha3_t *sha3, unsigned char* bytes);

/** @brief Squeeze exactly one chunk of 48 bytes without reinitializing the
 *         hash context to allow for multiple squeeze.
 *  This funtion should be called, if no further squeeze are performed on this
 *  context, as it avoid unnecessary reinitializations.
 *  @param sha3 the SHA context used for hashing.
 *  @param bytes result byte array
 */
void kerl_squeeze_final_chunk(cx_sha3_t *sha3, unsigned char *bytes_out);

/** @brief Squeeze multiple chunks of 48 byte data.
 *  @param sha3 the SHA context used for hashing.
 *  @param bytes result byte array
 *  @param len number of bytes to squeeze.
 */
void kerl_squeeze_bytes(cx_sha3_t *sha3, unsigned char* bytes, unsigned int len);

#endif // KERL_H
