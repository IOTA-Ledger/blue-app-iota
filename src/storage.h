#ifndef STORAGE_H
#define STORAGE_H

#include <stdbool.h>
#include <stdint.h>

bool flash_is_init();
uint32_t get_seed_idx(unsigned int idx);
void write_seed_index(unsigned int account, const unsigned int seed_idx);
void init_flash();

#endif // STORAGE_H
