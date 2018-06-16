cmake_minimum_required(VERSION 3.1)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules)

project(iota-ledger-test C)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED TRUE)

enable_testing()

# Support code coverage
option(SUPPORT_COVERAGE "Code Coverage" OFF)

if(SUPPORT_COVERAGE)
    include(CodeCoverage)
    append_coverage_compiler_flags()
endif()

find_package(CMocka REQUIRED)
include_directories(${CMOCKA_INCLUDE_DIR})

include_directories(
    "../src"
    "../src/iota"
    "../src/keccak"
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wshadow -Wcast-align")

# enable compilation on host
add_definitions(
    -DNO_BOLOS
    -DKERL_TEST_FOLDER="${CMAKE_SOURCE_DIR}/kerl-spec/test_vectors"
    -DTEST_FOLDER="${CMAKE_SOURCE_DIR}/test_vectors"
)

add_library(iota-ledger SHARED
    "../src/iota/addresses.c"
    "../src/iota/bundle.c"
    "../src/iota/conversion.c"
    "../src/iota/kerl.c"
    "../src/iota/signing.c"
    "../src/keccak/sha3.c"
    "../src/api.c"
    "../src/aux.c"
    "test_mocks.c"
)

add_executable(conversion_test conversion_test.c)
target_link_libraries(conversion_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(conversion_test ${CMAKE_CURRENT_BINARY_DIR}/conversion_test)

add_executable(kerl_test kerl_test.c hash_file.c)
target_link_libraries(kerl_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(kerl_test ${CMAKE_CURRENT_BINARY_DIR}/kerl_test)

add_executable(address_test address_test.c hash_file.c)
target_link_libraries(address_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(address_test ${CMAKE_CURRENT_BINARY_DIR}/address_test)

add_executable(bundle_test bundle_test.c)
target_link_libraries(bundle_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(bundle_test ${CMAKE_CURRENT_BINARY_DIR}/bundle_test)

add_executable(signing_test signing_test.c)
target_link_libraries(signing_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(signing_test ${CMAKE_CURRENT_BINARY_DIR}/signing_test)

add_executable(set_seed_test set_seed_test.c)
target_link_libraries(set_seed_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(set_seed_test ${CMAKE_CURRENT_BINARY_DIR}/set_seed_test)

add_executable(pubkey_test pubkey_test.c)
target_link_libraries(pubkey_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(pubkey_test ${CMAKE_CURRENT_BINARY_DIR}/pubkey_test)

add_executable(tx_test tx_test.c transaction_file.c)
target_link_libraries(tx_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(tx_test ${CMAKE_CURRENT_BINARY_DIR}/tx_test)

add_executable(sign_test sign_test.c transaction_file.c)
target_link_libraries(sign_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(sign_test ${CMAKE_CURRENT_BINARY_DIR}/sign_test)

add_executable(get_app_config_test get_app_config_test.c)
target_link_libraries(get_app_config_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(get_app_config_test ${CMAKE_CURRENT_BINARY_DIR}/sign_test)

if(SUPPORT_COVERAGE)
    set(COVERAGE_EXCLUDES '/usr/*')

    SETUP_TARGET_FOR_COVERAGE(
        NAME test_coverage
        EXECUTABLE ctest
    )
endif()
