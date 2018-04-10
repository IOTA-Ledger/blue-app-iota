#ifndef TRANSACTION_FILE_H
#define TRANSACTION_FILE_H

#include "api.h"

#define SIGNATURE_LENGTH 4374

void test_for_each_bundle(const char *file_name,
                          void (*test)(char *, TX_INPUT *, char *,
                                       char[][SIGNATURE_LENGTH]));

#endif // TRANSACTION_FILE_H
