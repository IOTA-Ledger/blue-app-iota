#ifndef S_CORE_H
#define S_CORE_H

#include <stdint.h>
#include "s_types.h"

void nano_set_screen(UI_SCREENS_NANO s);
void nanos_ui_init(void);
void nanos_display_main_menu(void);
void nanos_display_getting_addr(void);
void nanos_display_validating(void);
void nanos_display_recv(void);
void nanos_display_signing(void);
void nanos_display_address(const unsigned char *addr_bytes);
void nanos_sign_tx(void);
void nanos_ui_reset(void);
void nanos_ui_restore(void);

bool nanos_ui_lock_forbidden(void);

#endif // S_CORE_H
