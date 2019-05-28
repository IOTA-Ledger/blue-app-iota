#ifndef NANO_BUTTONS_H
#define NANO_BUTTONS_H

#include "ui/nano/nano_types.h"

int button_main_menu(UI_BUTTON_PRESS button_press);
int button_about(UI_BUTTON_PRESS button_press);
void button_version(UI_BUTTON_PRESS button_press);
int button_more_info(UI_BUTTON_PRESS button_press);
int button_bip_path(UI_BUTTON_PRESS button_press);
int button_address_full(UI_BUTTON_PRESS button_press);
void button_address_digest(UI_BUTTON_PRESS button_press);
int button_bundle_addr(UI_BUTTON_PRESS button_press);
void button_bundle(UI_BUTTON_PRESS button_press);

#endif // NANO_BUTTONS_H
