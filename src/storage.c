#include "storage.h"

// use internalStorage_t to temp hold the storage
typedef struct internalStorage_t {
    uint8_t initialized;
    uint32_t account_seed[5];
    uint8_t advanced_mode;
    uint8_t browser_mode;
    
} internalStorage_t;

// N_storage_real will hold the actual address for NVRAM
WIDE internalStorage_t N_storage_real;
#define N_storage (*(WIDE internalStorage_t *)PIC(&N_storage_real))

uint8_t get_advanced_mode()
{
    return N_storage.advanced_mode;
}

uint8_t get_browser_mode()
{
    return N_storage.browser_mode;
}

void write_advanced_mode(uint8_t mode)
{
    // something must have gone wrong to receive a mode > 1
    if (mode > 1) {
        os_sched_exit(0);
        return;
    }
    
    // only write if mode is different
    if (mode != N_storage.advanced_mode)
        nvm_write(&N_storage.advanced_mode, (void *)&mode, sizeof(uint8_t));
}

void write_browser_mode(uint8_t mode)
{
    // something must have gone wrong to receive a mode > 1
    if (mode > 1) {
        os_sched_exit(0);
        return;
    }
    
    // only write if mode is different
    if (mode != N_storage.browser_mode)
        nvm_write(&N_storage.browser_mode, (void *)&mode, sizeof(uint8_t));
}

bool flash_is_init()
{
    return N_storage.initialized == 0x01;
}

void init_flash()
{
    internalStorage_t storage;
    
    storage.initialized = 0x01;
    os_memset(storage.account_seed, 0, sizeof(uint32_t) * 5);
    storage.account_seed[0] = 0;
    storage.account_seed[1] = 4;
    storage.account_seed[2] = 9;
    storage.account_seed[3] = 22;
    storage.account_seed[4] = 762;
    storage.advanced_mode = 0;
    storage.browser_mode = 0;
    
    nvm_write(&N_storage, (void *)&storage, sizeof(internalStorage_t));
}

void incr_seed_idx(unsigned int account)
{
    // TODO - still write the index of the last TX in bundle (change)
    // can't keep track of indexes in advanced mode
    if(get_advanced_mode())
        return;
    
    uint32_t seed_idx = N_storage.account_seed[account];
    seed_idx++;
    
    nvm_write(&N_storage.account_seed[account], (void *)&seed_idx, sizeof(uint32_t));
}

uint32_t get_seed_idx(unsigned int account)
{
    return N_storage.account_seed[account];
}

void write_seed_index(unsigned int account, const unsigned int seed_idx)
{
    nvm_write(&N_storage.account_seed[account],
              (void *)&seed_idx, sizeof(uint32_t));
}
