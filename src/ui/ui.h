#ifndef UI_H
#define UI_H

#include <stdbool.h>
#include "iota/bundle.h"

/* To create a new UI screen -
 - #define new STATE_ , incr TOTAL_STATES/STATE_EXIT [ui_types.h]
 - Define what to display (ui_build_display) [ui_handling.c]
 - Define state transitions (init_state_transitions) [ui.c]
 - Define special button functions (ui_handle_button) [ui_handling.c]

 - If scrollable menu screen, also do:
 - #define Size of Menu [ui_types.h]
 - Create msg to display [ui_misc.c]
 - Define behavior (ui_handle_menus) [ui_handling.c] */

void ui_init(bool flash_is_init);

void ui_display_welcome();
void ui_display_calc();
void ui_display_recv();
void ui_display_signing();
void ui_display_address(const unsigned char *addr_bytes);
void ui_sign_tx(BUNDLE_CTX *bundle_ctx);
void ui_restore();

#endif // UI_H
