#ifndef MACROS_H
#define MACROS_H

#include "os.h"

#define NO_INLINE __attribute__((noinline))

// additional supported features
#define APP_FLAGS 0

/// Turn a symbol into a string.
#define AS_STRING(x) AS_STRING_INTERNAL(x)
#define AS_STRING_INTERNAL(x) #x

#define MEMCLEAR(x) os_memset(&(x), 0, sizeof(x))

/// Devide x by y and round up.
#define CEILING(x, y)                                                          \
    ({                                                                         \
        typeof(y) _y = (y);                                                    \
        (((x) + _y - 1) / _y);                                                 \
    })

/// Absolute value of x.
#define ABS(x)                                                                 \
    ({                                                                         \
        typeof(x) _x = (x);                                                    \
        _x < 0 ? -_x : _x;                                                     \
    })

/// Assigns the value of src to dest and returns whether there was an overflow.
#define ASSIGN(dest, src)                                                      \
    ({                                                                         \
        typeof(src) _x = (src);                                                \
        typeof(dest) _y = _x;                                                  \
        (_x == _y && ((_x < 1) == (_y < 1)) ? (void)((dest) = _y), 1 : 0);     \
    })

/// Returns whether x is min <= x <= max.
#define IN_RANGE(x, min, max)                                                  \
    ({                                                                         \
        typeof(x) _x = (x);                                                    \
        (_x >= (min) && _x <= (max));                                          \
    })

/// Typesafe array size computation.
#define ARRAY_SIZE(arr)                                                        \
    (sizeof(arr) / sizeof((arr)[0]) +                                          \
     sizeof(typeof(int[1 - 2 * !!__builtin_types_compatible_p(                 \
                                   typeof(arr), typeof(&(arr)[0]))])) *        \
         0)

/// Throws an error together with a debug message
#define THROW_MSG(msg, error)                                                  \
    ({                                                                         \
        PRINTF(msg " in %s: %d\n", __FILE__, __LINE__);                        \
        THROW((error));                                                        \
    })

/// Throws INVALID_PARAMETER exception with addition debug info
#define THROW_PARAMETER(x) THROW_MSG("invalid " x, INVALID_PARAMETER)

/// Throws provided error, if condition does not apply
#define VALIDATE(cond, error)                                                  \
    ({                                                                         \
        if (!(cond)) {                                                         \
            THROW_MSG("validation error", error);                              \
        }                                                                      \
    })

#endif // MACROS_H
