#ifndef BLUE_CORE_H
#define BLUE_CORE_H

#include "os.h"
#include "os_io_seproxyhal.h"

void blue_display_main_menu(void);
void blue_ui_init(void);
void blue_display_getting_addr(void);
void blue_display_validating(void);
void blue_display_recv(void);
void blue_display_signing(void);
void blue_display_address(const unsigned char *addr_bytes);
void blue_sign_tx(void);
void blue_ui_reset(void);
void blue_ui_restore(void);
bool blue_ui_lock_forbidden(void);

#endif // BLUE_CORE_H
