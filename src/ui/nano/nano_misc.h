#ifndef NANO_MISC_H
#define NANO_MISC_H

#include <stdint.h>
#include "api.h"
#include "macros.h"
#include "ui/nano/nano_types.h"

void nano_state_set(UI_STATES_NANO state, uint8_t idx);
void nano_state_set_ignore(void);
void nano_state_backup(void);
void nano_state_restore(void);

/// Returns the length of the bundle menu.
uint8_t get_menu_bundle_len(void);

/// Writes formatted value to string according to current ui state.
void format_value(int64_t val, char text[TEXT_LEN]);

/// Writes formated abbreviated address to string.
void format_address_abbrev(const char *addr, char text[TEXT_LEN]);

/// Writes formated checksum of the given address to string.
void format_address_checksum(const char *addr, char text[TEXT_LEN]);

/// Writes formated full address to multiple strings.
void format_address_full(const char *addr, char text[][TEXT_LEN]);

/// Writes formated BIP32 path to two strings.
void format_bip_path(const API_CTX *api, char text[2][TEXT_LEN]);

/// Sets the draw flag for the elements associated to the given screen.
void nano_draw_screen(UI_SCREENS_NANO screen);

/// Copies the given text into draw buffer for corresponding text position.
void nano_draw_text(const char *text, UI_TEXT_POS pos);

/// Copies the given text into the text position according to the ui state.
void nano_draw_menu_text(const char text[][TEXT_LEN], unsigned int rows);

/// Returns draw buffer for corresponding text position.
static inline char *nano_get_text_buffer(UI_TEXT_POS pos)
{
    switch (pos) {
    case TOP_H:
    case TOP:
        return ui_text.top_str;
    case BOT:
    case BOT_H:
        return ui_text.bot_str;
    case MID:
        return ui_text.mid_str;
#ifdef TARGET_NANOX
    case POS_X:
        return ui_text.x_str;
#endif
    default:
        THROW_PARAMETER("pos");
    }
}

/// Sets the draw flags for a variable number of elements.
#define NANO_DRAW_ELEMENTS(...)                                                \
    ({                                                                         \
        const UI_ELEMENTS_NANO elements[] = {__VA_ARGS__};                     \
        for (unsigned int i = 0; i < ARRAY_SIZE(elements); i++) {              \
            ui_state.flags.elements |= 1U << elements[i];                      \
        }                                                                      \
    })

#endif // NANO_MISC_H
