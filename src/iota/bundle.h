#ifndef BUNDLE_H
#define BUNDLE_H

#include "conversion.h"
#include "kerl.h"

void create_bundle_bytes(int64_t value, const char *tag, uint32_t timestamp,
                         uint32_t current_index, uint32_t last_index, unsigned char *bytes);

#endif // BUNDLE_H
