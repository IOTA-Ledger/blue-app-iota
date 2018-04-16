#ifndef MAIN_H
#define MAIN_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>
#include <stdio.h>
#include <math.h>
#include "storage.h"

extern unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];
extern ux_state_t ux;


unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len);
void io_seproxyhal_display(const bagl_element_t *element);
unsigned char io_event(unsigned char channel);

#endif // MAIN_H
