#ifndef NANO_CORE_H
#define NANO_CORE_H

#include <stdint.h>
#include "nano_types.h"

void nano_set_screen(UI_SCREENS_NANO s);
const bagl_element_t *ux_element_preprocessor(const bagl_element_t *element);

#endif // NANO_CORE_H
