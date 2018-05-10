#include "storage.h"
#include "common.h"
#include "iota_io.h"

// initially, the seed indices will be set to this value
#define INITIAL_SEED_INDEX 0

typedef struct {
    bool initialized;
    uint32_t account_seed_indexes[ACCOUNT_NUM];
} internalStorage_t;

// N_storage_real will hold the actual address for NVRAM
WIDE internalStorage_t N_storage_real;
#define N_storage (*(WIDE internalStorage_t *)PIC(&N_storage_real))

void storage_initialize()
{
    internalStorage_t storage;
    os_memset(&storage, 0, sizeof(internalStorage_t));

    storage.initialized = true;
    for (unsigned int i = 0; i < ACCOUNT_NUM; i++) {
        storage.account_seed_indexes[i] = INITIAL_SEED_INDEX;
    }

    nvm_write(&N_storage, (void *)&storage, sizeof(internalStorage_t));
}

bool storage_is_initialized()
{
    return N_storage.initialized;
}

uint32_t storage_get_seed_index(unsigned int account)
{
    if (!storage_is_initialized()) {
        THROW(INVALID_STATE);
    }
    if (account >= ACCOUNT_NUM) {
        THROW(INVALID_PARAMETER);
    }

    return N_storage.account_seed_indexes[account];
}

void storage_write_seed_index(unsigned int account, uint32_t seed_index)
{
    if (!storage_is_initialized()) {
        THROW(INVALID_STATE);
    }
    if (account >= ACCOUNT_NUM) {
        THROW(INVALID_PARAMETER);
    }

    // only write a changed value
    if (N_storage.account_seed_indexes[account] != seed_index) {
        nvm_write(&N_storage.account_seed_indexes[account], &seed_index,
                  sizeof(uint32_t));
    }
}
