#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include "test_common.h"
#include "api.h"
#include "iota/seed.h"
#include "iota/bundle.h"
#include "ui/ui.h"

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

void ui_sign_tx()
{
    // the user signs everything
    user_sign_tx();
}

void ui_restore()
{
}

void ui_reset()
{
}

__attribute__((weak)) void seed_derive_from_bip32(const unsigned int *path,
                                                  unsigned int pathLength,
                                                  unsigned char *seed_bytes)
{
    UNUSED(path);
    UNUSED(pathLength);

    char msg[100];
    snprintf(msg, 100, "%s should not be called", __FUNCTION__);
    mock_assert(false, msg, __FILE__, __LINE__);

    memset(seed_bytes, 0, NUM_HASH_BYTES); // avoid linter warning
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

void io_timeout_set(const unsigned int ms)
{
    mock_assert(ms > 0, "invalid ms", __FILE__, __LINE__);
}

void io_timeout_reset()
{
}
