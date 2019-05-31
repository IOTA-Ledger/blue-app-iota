#ifndef UI_COMMON_H
#define UI_COMMON_H

#include <stdint.h>

/** @brief Returns the tx index corresponding to the current menu entry.
 *  Meta transactions, i.e. transactions with 0-value, are skipped.
 */
unsigned int ui_state_get_tx_index(void);

/** @brief Writes formatted value in base iotas without commas to string.
 *  Ex. 3040981551 i
 *  @param s Pointer to a buffer where the resulting C-string is stored
 *  @param n Maximum number of bytes to be used in the buffer
 *  @param val Signed value to be formated
 */
void format_value_full(char *s, unsigned int n, int64_t val);

/** @brief Writes formatted value in short form with units.
 *  Ex. 3.040 Gi
 *  @param s Pointer to a buffer where the resulting C-string is stored
 *  @param n Maximum number of bytes to be used in the buffer
 *  @param val Signed value to be formated
 */
void format_value_short(char *s, unsigned int n, int64_t val);

#endif // UI_COMMON_H
