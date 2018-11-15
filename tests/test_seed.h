#ifndef TEST_SEED_H
#define TEST_SEED_H

#include "test_common.h"
#include <string.h>
#include "api_tests.h"

void test_valid_security_levels(void **state);
void test_security_level_zero(void **state);
void test_security_level_four(void **state);
void test_valid_path_lengths(void **state);
void test_path_length_zero(void **state);
void test_path_length_six(void **state);

#endif // TEST_SEED_H