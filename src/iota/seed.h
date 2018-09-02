#ifndef SEED_H
#define SEED_H

/** @brief Derives an IOTA seed from the provided BIP32 path.
 * @param path array representing the path
 * @param pathLength nuber of path levels
 * @param target array for the computed seed as big-endian 48-byte integer
 */
void seed_derive_from_bip32(const unsigned int *path, unsigned int pathLength,
                            unsigned char *seed_bytes);

#endif // SEED_H
