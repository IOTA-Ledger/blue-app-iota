#ifndef ADDRESSES_H
#define ADDRESSES_H

#include "iota_types.h"

#define MAX_SECURITY 3

void get_public_addr(const unsigned char *seed_bytes, uint32_t idx,
                     unsigned int security, unsigned char *address_bytes);

void get_address_checksum(const char *address, char *checksum);

#endif // ADDRESSES_H
