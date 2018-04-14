#ifndef STORAGE_H
#define STORAGE_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>

bool flash_is_init();
void incr_seed_idx(unsigned int idx);
uint32_t get_seed_idx(unsigned int idx);
void write_seed_index(unsigned int account, const unsigned int seed_idx);
uint8_t get_advanced_mode();
void write_advanced_mode(uint8_t mode);
void init_flash();

#endif // STORAGE_H
