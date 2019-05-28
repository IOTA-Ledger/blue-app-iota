#ifndef ADDRESSES_H
#define ADDRESSES_H

#include <stdint.h>

/** @brief Computes the public address.
 *  @parm seed_bytes the seed as big-endian 48-byte integer
 *  @idx index of the address
 *  @security securtiy level
 *  @address_bytes address as a big-endian 48-byte integer
 */
void get_public_addr(const unsigned char *seed_bytes, uint32_t idx,
                     unsigned int security, unsigned char *address_bytes);

/** @brief Computes the full address string in base-27 encoding.
 *  The full address consists of the actual address (81 chars) plus 9 chars of
 *  checksum.
 *  @param address_bytes the address, i.e. hash, in binarary representation
 *  @full_address target for the full address as a string
 */
void get_address_with_checksum(const unsigned char *address_bytes,
                               char *full_address);

#endif // ADDRESSES_H
