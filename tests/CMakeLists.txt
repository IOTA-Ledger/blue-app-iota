cmake_minimum_required(VERSION 3.0)

project(iota-ledger-test C)
enable_testing()

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules)

find_package(CMocka REQUIRED)
include_directories(${CMOCKA_INCLUDE_DIR})

include_directories(
    "../src"
    "../src/vendor/trezor-crypto"
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wshadow")

# enable compilation on host
add_definitions(
    -DNO_BOLOS
    -DTEST_FOLDER="${CMAKE_SOURCE_DIR}/kerl-spec/test_vectors"
)

add_library(iota-ledger SHARED
    "../src/vendor/iota/addresses.c"
    "../src/vendor/iota/bigint.c"
    "../src/vendor/iota/conversion.c"
    "../src/vendor/iota/kerl.c"
    "../src/vendor/trezor-crypto/sha3.c"
    "../src/aux.c"
)

add_executable(conversion_test conversion_test.c)
target_link_libraries(conversion_test ${CMOCKA_LIBRARIES} iota-ledger)
add_test(conversion_test ${CMAKE_CURRENT_BINARY_DIR}/conversion_test)
