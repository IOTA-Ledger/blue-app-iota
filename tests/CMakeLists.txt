cmake_minimum_required(VERSION 3.6)
project(iota-ledger-test C)

include(CTest)
include(ExternalProject)
include(GNUInstallDirs)

find_package(Git REQUIRED)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED TRUE)

# ------------------------------------------------------------------------------
# Includes
# ------------------------------------------------------------------------------

include_directories(
    "../src"
    "../src/iota"
    ${CMAKE_SOURCE_DIR}
)
include_directories(SYSTEM ${CMAKE_BINARY_DIR}/include)

# ------------------------------------------------------------------------------
# Cmocka
# ------------------------------------------------------------------------------

list(APPEND CMOCKA_CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}"
    "-DCMAKE_BUILD_TYPE=Debug"
    "-DUNIT_TESTING=OFF"
    "-DWITH_EXAMPLES=OFF"
)

ExternalProject_Add(
    cmocka
    GIT_REPOSITORY      https://git.cryptomilk.org/projects/cmocka.git
    GIT_TAG             cmocka-1.1.5
    GIT_SHALLOW         1
    CMAKE_ARGS          ${CMOCKA_CMAKE_ARGS}
    PREFIX              ${CMAKE_BINARY_DIR}/external
)

set(CMOCKA_SHARED_LIBRARY
    "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}/${CMAKE_SHARED_LIBRARY_PREFIX}cmocka${CMAKE_SHARED_LIBRARY_SUFFIX}"
)

add_library(libcmocka SHARED IMPORTED)
set_target_properties(libcmocka PROPERTIES
    IMPORTED_LOCATION ${CMOCKA_SHARED_LIBRARY}
)
add_dependencies(libcmocka cmocka)

# ------------------------------------------------------------------------------
# Clang Tidy
# ------------------------------------------------------------------------------

option(ENABLE_CLANG_TIDY "Enable clang-tidy. Use clang-tidy to detect potential code problems." OFF)

if(ENABLE_CLANG_TIDY)

    find_program(CLANG_TIDY_BIN clang-tidy)
    if(CLANG_TIDY_BIN)
        message(STATUS "Found clang-tidy: " ${CLANG_TIDY_BIN})
    else()
        message(FATAL_ERROR "Unable to locate clang-tidy")
    endif()

    list(APPEND CLANG_TIDY_BIN_ARGS
        -header-filter='${CMAKE_SOURCE_DIR}/*'
        -checks=bugprone-*,clang-analyzer-*,misc-*,performance-*,portability-*,readability-*,-readability-braces-around-statements
    )

    set(CMAKE_C_CLANG_TIDY ${CLANG_TIDY_BIN} ${CLANG_TIDY_BIN_ARGS})

endif()

# ------------------------------------------------------------------------------
# include-what-you-use
# ------------------------------------------------------------------------------

option(ENABLE_INCLUDE_WHAT_YOU_USE "Enable include-what-you-use. Use include-what-you-use to sanitize header-include dependencies." OFF)

if(ENABLE_INCLUDE_WHAT_YOU_USE)

    find_program(INCLUDE_WHAT_YOU_USE_BIN include-what-you-use)
    if(INCLUDE_WHAT_YOU_USE_BIN)
        message(STATUS "Found include-what-you-use: " ${INCLUDE_WHAT_YOU_USE_BIN})
    else()
        message(FATAL_ERROR "Unable to locate include-what-you-use")
    endif()

    list(APPEND INCLUDE_WHAT_YOU_USE_BIN_ARGS
        -Xiwyu --transitive_includes_only
    )

    set(CMAKE_C_INCLUDE_WHAT_YOU_USE ${INCLUDE_WHAT_YOU_USE_BIN} ${INCLUDE_WHAT_YOU_USE_BIN_ARGS})

endif()

# ------------------------------------------------------------------------------
# AddressSanitizer
# ------------------------------------------------------------------------------

set(CMAKE_C_FLAGS_ASAN
    "-O1 -g -fsanitize=address -fsanitize-address-use-after-scope -fno-omit-frame-pointer -fno-optimize-sibling-calls"
    CACHE STRING "Flags used by the C compiler during ASan builds."
    FORCE)
set(CMAKE_EXE_LINKER_FLAGS_ASAN
    "-fuse-ld=gold"
    CACHE STRING "Flags used for linking binaries during ASan builds."
    FORCE)
set(CMAKE_SHARED_LINKER_FLAGS_ASAN
    "-fuse-ld=gold"
    CACHE STRING "Flags used by the shared libraries linker during ASan builds."
    FORCE)

mark_as_advanced(
    CMAKE_C_FLAGS_ASAN
    CMAKE_EXE_LINKER_FLAGS_ASAN
    CMAKE_SHARED_LINKER_FLAGS_ASAN
)

# ------------------------------------------------------------------------------
# UndefinedBehaviorSanitizer
# ------------------------------------------------------------------------------

set(CMAKE_C_FLAGS_UBSAN
    "-fsanitize=undefined"
    CACHE STRING "Flags used by the C compiler during UBSan builds."
    FORCE)
set(CMAKE_EXE_LINKER_FLAGS_UBSAN
    "-fuse-ld=gold"
    CACHE STRING "Flags used for linking binaries during UBSan builds."
    FORCE)
set(CMAKE_SHARED_LINKER_FLAGS_UBSAN
    "-fuse-ld=gold"
    CACHE STRING "Flags used by the shared libraries linker during UBSan builds."
    FORCE)

mark_as_advanced(
    CMAKE_C_FLAGS_UBSAN
    CMAKE_EXE_LINKER_FLAGS_UBSAN
    CMAKE_SHARED_LINKER_FLAGS_UBSAN
)

# ------------------------------------------------------------------------------
# Coverage
# ------------------------------------------------------------------------------

set(CMAKE_C_FLAGS_COVERAGE
    "-g -O0 -fprofile-arcs -ftest-coverage"
    CACHE STRING "Flags used by the C compiler during coverage builds."
    FORCE)
set(CMAKE_EXE_LINKER_FLAGS_COVERAGE
    "--coverage"
    CACHE STRING "Flags used for linking binaries during coverage builds."
    FORCE)
set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE
    "--coverage"
    CACHE STRING "Flags used by the shared libraries linker during coverage builds."
    FORCE)

mark_as_advanced(
    CMAKE_C_FLAGS_COVERAGE
    CMAKE_EXE_LINKER_FLAGS_COVERAGE
    CMAKE_SHARED_LINKER_FLAGS_COVERAGE
)

# ------------------------------------------------------------------------------
# Tests
# ------------------------------------------------------------------------------

# Set a default build type if none was specified
set(DEFAULT_BUILD_TYPE "Release")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${DEFAULT_BUILD_TYPE}' as none was specified.")
    set(CMAKE_BUILD_TYPE
        ${DEFAULT_BUILD_TYPE}
        CACHE STRING "Choose the type of build."
        FORCE
    )
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
        "Debug" "Release" "ASan" "UBSan" "Coverage"
    )
endif()

if(NOT IOTA_LEDGER_APP_SOURCE_DIR)
    set(IOTA_LEDGER_APP_SOURCE_DIR
        "${CMAKE_SOURCE_DIR}/../src"
        CACHE STRING "Path of the Ledger app sources."
        FORCE
    )
endif()
if(NOT EXISTS ${IOTA_LEDGER_APP_SOURCE_DIR})
    message(FATAL_ERROR "Folder `${IOTA_LEDGER_APP_SOURCE_DIR}` does not exists. Please specify source folder by setting IOTA_LEDGER_APP_SOURCE_DIR.")
else()
    message(STATUS "Using IOTA Ledger app source folder: " ${IOTA_LEDGER_APP_SOURCE_DIR})
endif()

# enable all warnings
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wshadow -Wcast-align -Wmissing-prototypes -Wstrict-prototypes")

# use the same flags as in the BOLOS Makefile
set(CMAKE_C_FLAGS_RELEASE "-O3 -Os")

# enable compilation on host
add_definitions(
    -DTARGET_NANOS
    -DKERL_TEST_FOLDER="${CMAKE_SOURCE_DIR}/kerl-spec/test_vectors"
    -DTEST_FOLDER="${CMAKE_SOURCE_DIR}/test_vectors"
)

file(GLOB iota_sources "${IOTA_LEDGER_APP_SOURCE_DIR}/iota/*.c")
add_library(iota-ledger SHARED
    ${iota_sources}
    "${IOTA_LEDGER_APP_SOURCE_DIR}/api.c"
    "${IOTA_LEDGER_APP_SOURCE_DIR}/misc.c"
    "keccak/sha3.c"
    "test_mocks.c"
    "os.c"
)

add_library(test-utils SHARED
    "hash_file.c"
    "transaction_file.c"
)
target_link_libraries(test-utils libcmocka)

macro(do_test str)
    add_executable(${str}_test ${str}_test.c)
    add_test(${str}_test ${str}_test)
    target_link_libraries(${str}_test iota-ledger test-utils libcmocka)
endmacro(do_test)

do_test(address)
do_test(bundle)
do_test(conversion)
do_test(kerl)
do_test(seed)
do_test(signing)

# API end-to-end tests
do_test(pubkey)
do_test(tx)
do_test(sign)
do_test(get_app_config)
do_test(reset)
