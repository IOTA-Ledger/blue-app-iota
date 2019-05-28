#include "ui/ui.h"
#include <stdbool.h>
#include "os_io_seproxyhal.h"

#define WAIT_EVENT()                                                           \
    io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,                         \
                           sizeof(G_io_seproxyhal_spi_buffer), 0)

void ui_force_draw()
{
    bool display_event_occurred = false;

    while (!UX_DISPLAYED()) {
        UX_DISPLAY_NEXT_ELEMENT();
        WAIT_EVENT();
        display_event_occurred = true;
    }

    // this is only necessary, if anything has actually been displayed
    if (display_event_occurred) {
        // if everything is in the buffer, the next general status renders it
        io_seproxyhal_general_status();
        WAIT_EVENT();
    }
}
