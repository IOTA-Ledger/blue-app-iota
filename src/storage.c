#include "storage.h"
#include "common.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"


// use internalStorage_t to temp hold the storage
typedef struct internalStorage_t {
    uint8_t initialized;
    uint32_t account_seed[5];

} internalStorage_t;

// N_storage_real will hold the actual address for NVRAM
WIDE internalStorage_t N_storage_real;
#define N_storage (*(WIDE internalStorage_t *)PIC(&N_storage_real))

bool flash_is_init()
{
    return N_storage.initialized == 0x01;
}

void init_flash()
{
    internalStorage_t storage;

    storage.initialized = 0x01;
    os_memset(storage.account_seed, 0, sizeof(uint32_t) * 5);

    nvm_write(&N_storage, (void *)&storage, sizeof(internalStorage_t));
}

uint32_t get_seed_idx(unsigned int account)
{
    return N_storage.account_seed[account];
}

void write_seed_index(unsigned int account, const unsigned int seed_idx)
{
    nvm_write(&N_storage.account_seed[account], (void *)&seed_idx,
              sizeof(uint32_t));
}
