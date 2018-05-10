#ifndef STORAGE_H
#define STORAGE_H

#include <stdbool.h>
#include <stdint.h>

/** @brief Initializes the flash storage. */
void storage_initialize();

/** @brief Returns whether the flash storage has already been initialized.
 *  @return true, if storage is initialized, false otherwise
 */
bool storage_is_initialized();

/** @brief Returns the stored index of the last change address.
 *  @param account index of the account
 */
uint32_t storage_get_seed_index(unsigned int account);

/** @brief Writes a new index to flash.
 *  @param account index of the account
 *  @param seed_index the index to write
 */
void storage_write_seed_index(unsigned int account, uint32_t seed_index);

#endif // STORAGE_H
