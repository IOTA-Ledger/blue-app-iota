#ifndef TRANSACTION_FILE_H
#define TRANSACTION_FILE_H

#include "api.h"

void test_for_each_bundle(const char *file_name,
                          void (*test)(char *, TX_INPUT *, char *));

#endif // TRANSACTION_FILE_H
