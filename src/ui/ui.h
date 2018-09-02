#ifndef UI_H
#define UI_H

#include <stdbool.h>
#include "iota/bundle.h"
#include "api.h"

/* To create a new UI screen -
 - #define new STATE_ [ui_types.h]
 - Define what to display (ui_build_display) [ui_handling.c]
 - Define special button functions (ui_handle_button) [ui_handling.c]

 - If scrollable menu screen, also do:
 - #define Size of Menu [ui_types.h]
 - Create msg to display [ui_misc.c]
 - Define behavior (ui_handle_menus) [ui_handling.c] */

void ui_init(bool flash_is_init);

void ui_display_welcome(void);
void ui_display_getting_addr(void);
void ui_display_validating(void);
void ui_display_recv(void);
void ui_display_signing(void);
void ui_display_address(const unsigned char *addr_bytes);
void ui_sign_tx(void);
void ui_reset(void);
void ui_restore(void);

void ui_render(void);
void ui_force_draw(void);

#endif // UI_H
