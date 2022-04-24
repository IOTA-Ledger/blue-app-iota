#include "ui/ui.h"
#include <stdbool.h>
#include "os_io_seproxyhal.h"
#include "ux.h"

#define WAIT_EVENT()                                                           \
    io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,                         \
                           sizeof(G_io_seproxyhal_spi_buffer), 0)

void ui_force_draw()
{
    UX_WAIT_DISPLAYED();
}
