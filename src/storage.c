#include "storage.h"
#include "common.h"
#include "iota_io.h"

typedef struct {
    bool initialized;
} internalStorage_t;

// N_storage_real will hold the actual address for NVRAM
WIDE internalStorage_t N_storage_real;
#define N_storage (*(WIDE internalStorage_t *)PIC(&N_storage_real))

void storage_initialize()
{
    internalStorage_t storage;
    os_memset(&storage, 0, sizeof(internalStorage_t));

    storage.initialized = true;

    nvm_write(&N_storage, (void *)&storage, sizeof(internalStorage_t));
}

bool storage_is_initialized()
{
    return N_storage.initialized;
}
