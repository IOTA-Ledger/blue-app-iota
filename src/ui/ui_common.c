#include "ui_common.h"
#include "api.h"
#include <string.h>

#if defined TARGET_BLUE
#include "blue/blue_types.h"
#define MENU_IDX_BREAK blue_ui_state.menu_idx
#elif defined TARGET_NANOX
#include "nano/s_types.h"
#define MENU_IDX_BREAK ui_state.menu_idx / 2
#else
#include "nano/s_types.h"
#define MENU_IDX_BREAK ui_state.menu_idx / 2
#endif // TARGET_BLUE

/// the different IOTA units
const char IOTA_UNITS[][3] = {"i", "Ki", "Mi", "Gi", "Ti", "Pi"};

/// groups the string by adding a comma every 3 chars from the right
size_t str_add_commas(char *dst, const char *src, size_t num_len)
{
    char *p_dst = dst;
    const char *p_src = src;

    // ignore leading minus
    if (*p_src == '-') {
        *p_dst++ = *p_src++;
        num_len--;
    }
    for (int commas = 2 - num_len % 3; *p_src; commas = (commas + 1) % 3) {
        *p_dst++ = *p_src++;
        if (commas == 1) {
            *p_dst++ = ',';
        }
    }
    // remove the last comma and zero-terminate
    *--p_dst = '\0';

    return (p_dst - dst);
}

size_t snprint_int64(char *s, size_t n, int64_t val)
{
    // we cannot display the full range of int64 with this function
    if (ABS(val) >= MAX_INT_DEC * MAX_INT_DEC) {
        THROW(INVALID_PARAMETER);
    }

    if (ABS(val) < MAX_INT_DEC) {
        snprintf(s, n, "%d", (int)val);
    }
    else {
        // emulate printing of integers larger than 32 bit
        snprintf(s, n, "%d%09d", (int)(val / MAX_INT_DEC),
                 (int)(ABS(val) % MAX_INT_DEC));
    }
    return strnlen(s, n);
}

uint8_t menu_to_tx_idx(void)
{
    uint8_t i = 0, j = 0;

    // break at different points for blue vs nanos
    // nanos has 2 screens per tx blue has 1
    while (j <= api.bundle_ctx.last_tx_index && i <= MENU_IDX_BREAK) {
        if (api.bundle_ctx.values[j] != 0) {
            i++;
        }
        j++;
    }

    // j cannot be 0, because <=, so even if last_idx and menu_idx are 0,
    // it will still execute once (incrementing j in the process).

    // j will be incremented one beyond our desired index
    return j - 1;
}

// display full amount in base iotas without commas Ex. 3040981551 i
void write_full_val(int64_t val, char *dest, unsigned int len)
{
    // nano_s will pass length of 21 for buffersize
    char buffer[len];
    bool is_nanos = (len == 21);

    const size_t num_len = snprint_int64(buffer, sizeof buffer, val);

    // numbers shorter will have at most 3 commas and fit the text length
    // only worry about it if on nanos screen
    if (num_len > 13 && is_nanos) {
        snprintf(dest, len, "%s %s", buffer, IOTA_UNITS[0]);
    }
    else {
        const size_t chars_written = str_add_commas(dest, buffer, num_len);
        snprintf(dest + chars_written, len - chars_written, " %s",
                 IOTA_UNITS[0]);
    }
}

// displays brief amount with units Ex. 3.040 Gi
void write_readable_val(int64_t val, char *dest, unsigned int len)
{
    if (ABS(val) < 1000) {
        snprintf(dest, len, "%d %s", (int)(val), IOTA_UNITS[0]);
        return;
    }

    unsigned int base = 1;
    while (ABS(val) >= 1000 * 1000) {
        val /= 1000;
        base++;
    }
    if (base >= sizeof(IOTA_UNITS) / sizeof(IOTA_UNITS[0])) {
        THROW(INVALID_PARAMETER);
    }

    snprintf(dest, len, "%d.%03d %s", (int)(val / 1000), (int)(ABS(val) % 1000),
             IOTA_UNITS[base]);
}
