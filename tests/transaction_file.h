#ifndef TRANSACTION_FILE_H
#define TRANSACTION_FILE_H

#include "api.h"

#define SIGNATURE_LENGTH 6561

void test_for_each_bundle(const char *file_name,
                          void (*test)(char *, int, TX_INPUT *, int, char *,
                                       char[][SIGNATURE_LENGTH]));

#endif // TRANSACTION_FILE_H
