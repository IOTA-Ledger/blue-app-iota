#include "storage.h"
#include "common.h"
#include "iota_io.h"

// use internalStorage_t to temp hold the storage
typedef struct internalStorage_t {
    uint8_t initialized;
    uint32_t account_seed_indexes[ACCOUNT_NUM];
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
    os_memset(&storage, 0, sizeof(internalStorage_t));

    storage.initialized = true;

    nvm_write(&N_storage, (void *)&storage, sizeof(internalStorage_t));
}

uint32_t get_seed_idx(unsigned int account)
{
    if (account >= ACCOUNT_NUM) {
        THROW(INVALID_PARAMETER);
    }

    return N_storage.account_seed_indexes[account];
}

void write_seed_index(unsigned int account, uint32_t seed_idx)
{
    if (account >= ACCOUNT_NUM) {
        THROW(INVALID_PARAMETER);
    }

    nvm_write(&N_storage.account_seed_indexes[account], (void *)&seed_idx,
              sizeof(uint32_t));
}
