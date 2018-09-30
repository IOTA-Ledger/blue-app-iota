#include "test_common.h"
#include <stdio.h>
#include "api.h"
#include "seed.h"
#include "storage.h"
#include "iota/bundle.h"
#include "ui/ui.h"
#include "keccak/sha3.h"

void throw_exception(const char *expression, const char *file, int line)
{
    mock_assert(false, expression, file, line);
}

void ui_display_main_menu()
{
}

void ui_display_getting_addr()
{
}

void ui_display_validating()
{
}

void ui_display_recv()
{
}

void ui_display_signing()
{
}

void ui_display_address(const unsigned char *addr_bytes)
{
    UNUSED(addr_bytes);
}

// forward declaration
void user_sign_tx(void);

void ui_sign_tx()
{
    // the user signs everything
    user_sign_tx();
}

void ui_restore()
{
}

bool storage_is_initialized()
{
    return true;
}

__attribute__((weak)) void seed_derive_from_bip32(const unsigned int *path,
                                                  unsigned int pathLength,
                                                  unsigned char *seed_bytes)
{
    UNUSED(path);
    UNUSED(pathLength);
    UNUSED(seed_bytes);

    char msg[100];
    snprintf(msg, 100, "%s should not be called", __FUNCTION__);
    mock_assert(false, msg, __FILE__, __LINE__);
}

__attribute__((weak)) void io_send(const void *ptr, unsigned int length,
                                   unsigned short sw)

{
    UNUSED(ptr);
    UNUSED(length);
    UNUSED(sw);

    char msg[100];
    snprintf(msg, 100, "%s should not be called", __FUNCTION__);
    mock_assert(false, msg, __FILE__, __LINE__);
}
