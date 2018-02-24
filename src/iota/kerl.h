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

/** @brief Reinitialize the context with the given Kerl state.
 *  A reinitialized context can then be used to squeeze further chunks.
 *  @param sha3 the SHA context used for hashing
 *  @param state_bytes byte array containing the 48 byte Kerl state
 */
void kerl_reinitialize(cx_sha3_t *sha3, const unsigned char *state_bytes);

/** @brief Absorb exactly one chunk of 48 bytes.
 *  @param sha3 the SHA context used for hashing
 *  @param bytes bytes to absorb.
 */
void kerl_absorb_chunk(cx_sha3_t *sha3, const unsigned char* bytes);

/** @brief Absorb arbitrary number of bytes.
 *  @param sha3 the SHA context used for hashing
 *  @param bytes bytes to absorb.
 */
void kerl_absorb_bytes(cx_sha3_t *sha3, const unsigned char* bytes, unsigned int len);

/** @brief Squeeze exactly one chunk of 48 bytes.
 *  This function automatically reinitializes kerl in the corresponding state.
 *  @param sha3 the SHA context used for hashing
 *  @param bytes result byte array
 */
void kerl_squeeze_chunk(cx_sha3_t *sha3, unsigned char* bytes);

/** @brief Squeeze exactly one chunk of 48 bytes without reinitializing the
 *         hash context to allow for multiple squeeze.
 *  This funtion should be called, if no further squeeze are performed on this
 *  context, as it avoid unnecessary reinitializations.
 *  @param sha3 the SHA context used for hashing
 *  @param bytes result byte array
 */
void kerl_squeeze_final_chunk(cx_sha3_t *sha3, unsigned char *bytes_out);

/** @brief Squeeze multiple chunks of 48 byte data.
 *  @param sha3 the SHA context used for hashing
 *  @param bytes result byte array
 *  @param len number of bytes to squeeze.
 */
void kerl_squeeze_bytes(cx_sha3_t *sha3, unsigned char* bytes, unsigned int len);

/** @brief Squeeze exactly one chunk of 48 bytes also returning the kerl state.
 *  The hash returned is identical to kerl_squeeze_chunk().
 *  The 48 byte kerl state can then be used in kerl_initialize_squeeze() to put any SHA context in the state.
 *  @param sha3 the SHA context used for hashing
 *  @param state_bytes target byte array to store the 48 byte state
 *  @param bytes result byte array
 */
void kerl_state_squeeze_chunk(cx_sha3_t *sha3, unsigned char *state_bytes, unsigned char *bytes);

#endif // KERL_H
