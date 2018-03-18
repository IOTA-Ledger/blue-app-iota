#ifndef ADDRESSES_H
#define ADDRESSES_H

#include "iota_types.h"

void get_public_addr(const unsigned char *seed_bytes, uint32_t idx,
                     unsigned int security, unsigned char *address_bytes);

/** @brief Computes the full address string in base-27 encoding.
 *  The full address consists of the actual address (81 chars) plus 9 chars of
 *  checksum.
 */
void get_address_with_checksum(const unsigned char *address_bytes,
                               char *full_address);

#endif // ADDRESSES_H
