#ifndef SEED_H
#define SEED_H

/** @brief Computes a valid IOTA seed based on the provided entropy.
 *  @param n number of entropy bytes
 *  @param seed_bytes target array to store the seed in 48 byte encoding
 */
void derive_seed_entropy(const unsigned char *entropy, unsigned int n,
                         unsigned char *seed_bytes);

void derive_seed_bip32(const unsigned int *path, unsigned int pathLength,
                       unsigned char *seed_bytes);

#endif // SEED_H
