#include "api_tests.h"
#include "test_common.h"
#include "os.h"
#include "api.h"

void io_send(const void *ptr, unsigned int length, unsigned short sw)
{
    check_expected(ptr);
    check_expected(length);
    check_expected(sw);
}

/** Test that the defined constants are returned. */
static void test_get_app_config(void **state)
{
    UNUSED(state);

    api_initialize();

    unsigned char input[0]; // no input

    const GET_APP_CONFIG_OUTPUT output = {APPVERSION_MAJOR, APPVERSION_MINOR,
                                          APPVERSION_PATCH, MAX_BUNDLE_SIZE,
                                          APP_FLAGS};
    EXPECT_API_DATA_OK(get_app_config, 0, input, output);
}

int main(void)
{
    const struct CMUnitTest tests[] = {cmocka_unit_test(test_get_app_config)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
