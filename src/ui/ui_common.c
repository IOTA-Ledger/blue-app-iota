#include "ui/ui_common.h"
#include <stdint.h>
#include <string.h>
#include "api.h"
#include "iota/bundle.h"
#include "macros.h"
#include "os.h"

#ifdef TARGET_BLUE
#include "blue/blue_types.h"
#define MENU_IDX_BREAK blue_ui_state.menu_idx
#else
#include "nano/nano_types.h"
#define MENU_IDX_BREAK ui_state.menu_idx / 2
#endif // TARGET_BLUE

/// the largest power of 10 that still fits into int32
#define MAX_INT_DEC INT64_C(1000000000)

/// the different IOTA units
static const char IOTA_UNITS[][3] = {"i", "Ki", "Mi", "Gi", "Ti", "Pi"};
// the max number of iota units
#define MAX_IOTA_UNIT ARRAY_SIZE(IOTA_UNITS)

/// Groups the string by adding a comma every 3 chars from the right.
static size_t str_add_commas(char *dst, const char *src, size_t num_len)
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

/** @brief Writes signed integer to string.
 *  @return the number of chars that have been written
 */
static size_t format_s64(char *s, const size_t n, const int64_t val)
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

void format_value_full(char *s, const unsigned int n, const int64_t val)
{
    char buffer[n];

    const size_t num_len = format_s64(buffer, sizeof(buffer), val);
    const size_t num_len_comma = num_len + (num_len - (val < 0 ? 2 : 1)) / 3;

    // if the length with commas plus the unit does not fit
    if (num_len_comma + 3 > n) {
        snprintf(s, n, "%s %s", buffer, IOTA_UNITS[0]);
    }
    else {
        const size_t chars_written = str_add_commas(s, buffer, num_len);
        snprintf(s + chars_written, n - chars_written, " %s", IOTA_UNITS[0]);
    }
}

void format_value_short(char *s, const unsigned int n, int64_t val)
{
    if (ABS(val) < 1000) {
        snprintf(s, n, "%d %s", (int)(val), IOTA_UNITS[0]);
        return;
    }

    unsigned int base = 1;
    while (ABS(val) >= 1000 * 1000) {
        val /= 1000;
        base++;
    }
    if (base >= MAX_IOTA_UNIT) {
        THROW(INVALID_PARAMETER);
    }

    snprintf(s, n, "%d.%03d %s", (int)(val / 1000), (int)(ABS(val) % 1000),
             IOTA_UNITS[base]);
}

unsigned int ui_state_get_tx_index()
{
    unsigned int i = 0;

    for (unsigned int j = 0; j <= api.ctx.bundle.bundle.last_tx_index; j++) {
        // ignore meta tx
        if (api.ctx.bundle.bundle.values[j] != 0) {
            if (i++ == MENU_IDX_BREAK) {
                return j;
            }
        }
    }

    THROW_PARAMETER("menu_idx");
}
