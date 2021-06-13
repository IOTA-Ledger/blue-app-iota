#include "chars_utils.h"
#include <string.h>
#include "os.h"

#define PAD_CHAR '9'

bool validate_chars(const char *chars, const unsigned int num_chars)
{
    const size_t len = strnlen(chars, num_chars);
    for (unsigned int i = 0; i < len; i++) {
        const char c = chars[i];
        if (c != '9' && (c < 'A' || c > 'Z')) {
            return false;
        }
    }

    return true;
}

bool validate_chars_exact(const char *chars, const unsigned int num_chars)
{
    if (strnlen(chars, num_chars) < num_chars) {
        return false;
    }

    return validate_chars(chars, num_chars);
}

void rpad_chars(char *destination, const char *source,
                const unsigned int num_chars)
{
    const size_t len = strnlen(source, num_chars);
    memcpy(destination, source, len);
    memset(destination + len, PAD_CHAR, num_chars - len);
}
