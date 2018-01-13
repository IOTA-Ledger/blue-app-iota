#ifndef UI_H
#define UI_H

#include "os.h"
#include "cx.h"
#include "os_io_seproxyhal.h"
#include "bagl.h"
#include <stdbool.h>
#include <stdio.h>
#include <math.h>

unsigned int bagl_ui_nanos_screen1_button(unsigned int, unsigned int);
unsigned int bagl_ui_nanos_screen2_button(unsigned int, unsigned int);
unsigned int bagl_ui_sample_blue_button(unsigned int, unsigned int);

const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e);
const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e);
const bagl_element_t* io_seproxyhal_touch_approve(const bagl_element_t *e);

void ui_idle(void);
void ui_display_main();
void ui_display_debug(void *o, unsigned int sz, uint8_t t);

#endif // UI_H
