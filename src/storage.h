#ifndef STORAGE_H
#define STORAGE_H

#include <stdbool.h>
#include <stdint.h>

bool flash_is_init();
uint32_t get_seed_idx(unsigned int idx);
void write_seed_index(unsigned int account, const unsigned int seed_idx);
uint8_t get_advanced_mode();
void write_advanced_mode(uint8_t mode);
void init_flash();

#endif // STORAGE_H
