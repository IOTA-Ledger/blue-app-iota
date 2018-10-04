#*******************************************************************************
#   Ledger Blue
#   (c) 2016 Ledger
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#*******************************************************************************

ifeq ($(BOLOS_SDK),)
$(error BOLOS_SDK is not set)
endif
include $(BOLOS_SDK)/Makefile.defines

# Main app configuration

APPNAME = "IOTA"
APPVERSION_MAJOR = 0
APPVERSION_MINOR = 4
APPVERSION_PATCH = 1
APPVERSION = $(APPVERSION_MAJOR).$(APPVERSION_MINOR).$(APPVERSION_PATCH)
APP_LOAD_PARAMS = --path "44'/4218'" --appFlags 0x00 $(COMMON_LOAD_PARAMS)

ICONNAME = nanos_app_iota.gif

# Build configuration

APP_SOURCE_PATH += src
SDK_SOURCE_PATH += lib_stusb lib_stusb_impl

DEFINES += APPVERSION_MAJOR=$(APPVERSION_MAJOR)
DEFINES += APPVERSION_MINOR=$(APPVERSION_MINOR)
DEFINES += APPVERSION_PATCH=$(APPVERSION_PATCH)
DEFINES += APPVERSION=\"$(APPVERSION)\"

DEFINES += OS_IO_SEPROXYHAL IO_SEPROXYHAL_BUFFER_SIZE_B=128
DEFINES += HAVE_BAGL HAVE_SPRINTF
DEFINES += HAVE_IO_USB HAVE_L4_USBLIB IO_USB_MAX_ENDPOINTS=6 IO_HID_EP_LENGTH=64 HAVE_USB_APDU

# U2F support
SDK_SOURCE_PATH += lib_u2f
DEFINES += USB_SEGMENT_SIZE=64
DEFINES += U2F_PROXY_MAGIC=\"IOT\"
DEFINES += HAVE_IO_U2F HAVE_U2F

# Development flags
APP_LOAD_PARAMS += --path "44'/01'"
DEFINES += HAVE_BOLOS_APP_STACK_CANARY HAVE_PRINTF PRINTF=screen_printf
# Release flags
# DEFINES += BOLOS_RELEASE PRINTF\(...\)=

# Compiler, assembler, and linker

ifneq ($(BOLOS_ENV),)
$(info BOLOS_ENV=$(BOLOS_ENV))
CLANGPATH := $(BOLOS_ENV)/clang-arm-fropi/bin/
GCCPATH := $(BOLOS_ENV)/gcc-arm-none-eabi-5_3-2016q1/bin/
else
$(info BOLOS_ENV is not set: falling back to CLANGPATH and GCCPATH)
endif
ifeq ($(CLANGPATH),)
$(info CLANGPATH is not set: clang will be used from PATH)
endif
ifeq ($(GCCPATH),)
$(info GCCPATH is not set: arm-none-eabi-* will be used from PATH)
endif

CC := $(CLANGPATH)clang
CFLAGS += -O3 -Os

AS := $(GCCPATH)arm-none-eabi-gcc
AFLAGS +=

LD := $(GCCPATH)arm-none-eabi-gcc
LDFLAGS += -O3 -Os
LDLIBS += -lm -lgcc -lc

# Main rules

all: default

load: all
	python -m ledgerblue.loadApp $(APP_LOAD_PARAMS)

delete:
	python -m ledgerblue.deleteApp $(COMMON_DELETE_PARAMS)

# import rules to compile glyphs(/pone)
include $(BOLOS_SDK)/Makefile.glyphs

# Import generic rules from the SDK
include $(BOLOS_SDK)/Makefile.rules
