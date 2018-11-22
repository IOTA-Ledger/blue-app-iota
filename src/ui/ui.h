#ifndef UI_H
#define UI_H

#include <stdbool.h>
#include "ui_types.h"

/* To create a new generic UI screen -
 - #define new STATE_ [ui_types.h]
 - Add entries in ui_build_display and ui_handle_button [ui.c]
 - Create display/button functions [ui_display.c/ui_buttons.c]

 - If text menu screen, also do:
 - #define Size of Menu [ui_types.h]
 - Create msg to display [ui_text.c] */

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

void ui_queue_reset_if_locked(void);

void ui_set_screen(UI_SCREENS s);

void ui_timeout_tick(void);
void ui_timeout_start(void);
void ui_timeout_stop(void);

#endif // UI_H
