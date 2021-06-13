#ifndef UI_H
#define UI_H

#include "bolos_target.h"
#ifndef TARGET_BLUE
#include "ux.h"
#endif

// the following implementation are different for Blue and Nano
void ui_init(void);
void ui_display_main_menu(void);
void ui_display_getting_addr(void);
void ui_display_validating(void);
void ui_display_recv(void);
void ui_display_signing(void);
void ui_display_address(const unsigned char *addr_bytes);
void ui_sign_tx(void);
void ui_reset(void);
void ui_restore(void);

#endif // UI_H
