#ifndef S_SCREENS_H
#define S_SCREENS_H

#include "glyphs.h"

#ifdef TARGET_NANOS

#include "ui/nano/s_elements.h"

// screen for displaying back icon
static const bagl_element_t bagl_ui_omega_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_ALL, SCREEN_GLYPHS_ALL};

#else // NANOX

#include "ui/nano/x_elements.h"

static const bagl_element_t bagl_ui_omega_screen[] = {
    SCREEN_CLEAR,
    SCREEN_TITLE_TOP,
    SCREEN_TITLE_BOT,
    SCREEN_ADDRESS_1,
    SCREEN_ADDRESS_2,
    SCREEN_ADDRESS_3,
    SCREEN_ADDRESS_4,
    SCREEN_BIP_TITLE,
    SCREEN_BIP_1,
    SCREEN_BIP_2,
    SCREEN_MSG_ICON,
    SCREEN_MSG_ICON_MULTILINE_1,
    SCREEN_MSG_ICON_MULTILINE_2,
    SCREEN_GLYPHS_ALL};

#endif // TARGET NANOS/X

#endif // S_SCREENS_H
