#include "test_common.h"
#include "api_tests.h"
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

    GET_APP_CONFIG_OUTPUT output = {0};
    output.app_flags = APP_FLAGS;
    output.app_version_major = APPVERSION_MAJOR;
    output.app_version_minor = APPVERSION_MINOR;
    output.app_version_patch = APPVERSION_PATCH;

    EXPECT_API_DATA_OK(get_app_config, input, output);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_get_app_config)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
