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

#endif // STORAGE_H
