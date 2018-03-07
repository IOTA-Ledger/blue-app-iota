cmake_minimum_required(VERSION 3.6)
project(c_light_wallet)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES
        src/iota/addresses.c
        src/iota/addresses.h
        src/iota/common.h
        src/iota/conversion.c
        src/iota/conversion.h
        src/iota/iota_types.h
        src/iota/kerl.c
        src/iota/kerl.h
        src/keccak/macros.h
        src/keccak/options.h
        src/keccak/sha3.c
        src/keccak/sha3.h
        src/main.c
        src/main.h
        Makefile)

add_executable(c_light_wallet ${SOURCE_FILES})