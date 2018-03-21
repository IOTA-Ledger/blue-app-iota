#ifndef UI_HANDLING_H
#define UI_HANDLING_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>
#include <stdio.h>
#include <math.h>
#include "main.h"
#include "api.h"

#include "ui_types.h"
#include "ui_misc.h"

void ui_build_display();
void ui_handle_menus(uint8_t state, uint8_t translated_mask);
void ui_handle_button(uint8_t state, uint8_t button_mask);

#endif // UI_HANDLING_H
