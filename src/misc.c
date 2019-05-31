#include "misc.h"
#include <string.h>
#include "os.h"

#define PAD_CHAR '9'

bool validate_chars(const char *chars, unsigned int num_chars)
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

void rpad_chars(char *destination, const char *source, unsigned int num_chars)
{
    const size_t len = strnlen(source, num_chars);
    os_memcpy(destination, source, len);
    os_memset(destination + len, PAD_CHAR, num_chars - len);
}
