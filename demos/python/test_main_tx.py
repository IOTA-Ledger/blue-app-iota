#!/usr/bin/env python
#*******************************************************************************
#*   Ledger Blue
#*   (c) 2016 Ledger
#*
#*  Licensed under the Apache License, Version 2.0 (the "License");
#*  you may not use this file except in compliance with the License.
#*  You may obtain a copy of the License at
#*
#*      http://www.apache.org/licenses/LICENSE-2.0
#*
#*  Unless required by applicable law or agreed to in writing, software
#*  distributed under the License is distributed on an "AS IS" BASIS,
#*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#*  See the License for the specific language governing permissions and
#*  limitations under the License.
#********************************************************************************
from ledgerblue.comm import getDongle
from ledgerblue.commException import CommException
from secp256k1 import PublicKey
import time


def assert_exception(dongle, apdu, exception_code):
    try:
        dongle.exchange(apdu)
        raise Exception("Expected exception not raised")
    except CommException as e:
        if e.sw != exception_code:
            raise Exception("Unexpected exception status %04x" % e.sw)


dongle = getDongle(True)
exceptionCount = 0
start_time = time.time()

test_addr = "ADR" * 27 + "\0"
bad_tag = "TAG" * 9 + "9\0"


# ------------------------------------------
# Wrong initial byte
assert_exception(dongle, bytes("70200020FF".decode('hex') + "5\0"), 0x6E00)

dongle.exchange(bytes("8020000000".decode('hex')))

# ------------------------------------------
# Not rcv last index first (this is Cur flag)
assert_exception(dongle, bytes("80200010FF".decode('hex') + "0\0"), 0x6803)

# ------------------------------------------
# Last idx too small
assert_exception(dongle, bytes("80200020FF".decode('hex') + "1\0"), 0x6802)

# ------------------------------------------
# Last idx negative
assert_exception(dongle, bytes("80200020FF".decode('hex') + "-1\0"), 0x6802)

# ------------------------------------------
# Last idx too large
assert_exception(dongle, bytes("80200020FF".decode('hex') + "9\0"), 0x6802)

# ------------------------------------------
# Cur out of order
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
assert_exception(dongle, bytes("80200010FF".decode('hex') + "1\0"), 0x6805)

# ------------------------------------------
# Cur idx negative
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx

# TODO : this does not throw anymore due to overflow detection
assert_exception(dongle, bytes("80200010FF".decode('hex') + "-1\0"), 0x6802)

# ------------------------------------------
# Previous TX incomplete
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
assert_exception(dongle, bytes("80200010FF".decode('hex') + "1\0"), 0x6802)

# ------------------------------------------
# Addr too short
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
assert_exception(dongle, bytes(
    "8020000151".decode('hex') + test_addr[1:]), 0x6802)

# ------------------------------------------
# Addr too long
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
assert_exception(dongle, bytes(
    "8020000151".decode('hex') + "A" + test_addr), 0x6802)

# ------------------------------------------
# Addr invalid character(s)
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
assert_exception(dongle, bytes("8020000151".decode(
    'hex') + "1" + test_addr[1:]), 0x6802)

# ------------------------------------------
# First tx not output
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
assert_exception(dongle, bytes("80200002FF".decode('hex') + "-200\0"), 0x6802)

# ------------------------------------------
# Tag invalid char(s)
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200002FF".decode('hex') + "200\0"))  # set val
assert_exception(dongle, bytes("802000041B".decode('hex') + "123\0"), 0x6802)

# ------------------------------------------
# Previous TX incomplete - missing time
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200002FF".decode('hex') + "200\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
assert_exception(dongle, bytes("80200010FF".decode('hex') + "1\0"), 0x6802)

# ------------------------------------------
# Input missing seed idx
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200002FF".decode('hex') + "-5\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
assert_exception(dongle, bytes("80200108FF".decode('hex') + "99999\0"), 0x6802)

# ------------------------------------------
# Input missing input address
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("80200040FF".decode('hex') + "4\0"))  # set input idx
dongle.exchange(bytes("80200002FF".decode('hex') + "-5\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
assert_exception(dongle, bytes("80200108FF".decode('hex') + "99999\0"), 0x6802)

# ------------------------------------------
# Input no space for meta tx
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200040FF".decode('hex') + "4\0"))  # set input idx
dongle.exchange(bytes("80200002FF".decode('hex') + "-5\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
dongle.exchange(bytes("80200008FF".decode('hex') + "99999\0"))  # set time
assert_exception(dongle, bytes("80200010FF".decode('hex') + "1\0"), 0x6802)

# ------------------------------------------
# Duplicate cur idx
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200002FF".decode('hex') + "10\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
dongle.exchange(bytes("80200008FF".decode('hex') + "99999\0"))  # set time
assert_exception(dongle, bytes("80200010FF".decode('hex') + "0\0"), 0x6802)

# ------------------------------------------
# Input index on output tx
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"))  # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200040FF".decode('hex') + "4\0"))  # set input idx
dongle.exchange(bytes("80200002FF".decode('hex') + "10\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
dongle.exchange(bytes("80200008FF".decode('hex') + "99999\0"))  # set time
assert_exception(dongle, bytes("80200010FF".decode('hex') + "0\0"), 0x6802)

# ------------------------------------------
# Too many TX's
dongle.exchange(bytes("80200020FF".decode('hex') + "2\0"))  # set last idx

dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200040FF".decode('hex') + "4\0"))  # set input idx
dongle.exchange(bytes("80200002FF".decode('hex') + "-5\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
dongle.exchange(bytes("80200008FF".decode('hex') + "99999\0"))  # set time

dongle.exchange(bytes("80200010FF".decode('hex') + "2\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200002FF".decode('hex') + "10\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag
dongle.exchange(bytes("80200008FF".decode('hex') + "99999\0"))  # set time

assert_exception(dongle, bytes("80200010FF".decode('hex') + "3\0"), 0x6802)

# ------------------------------------------
# Complete transmission flag sent too early
dongle.exchange(bytes("80200020FF".decode('hex') + "2\0"))  # set last idx

dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"))  # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr))  # set addr
dongle.exchange(bytes("80200040FF".decode('hex') + "4\0"))  # set input idx
dongle.exchange(bytes("80200002FF".decode('hex') + "-5\0"))  # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0"))  # set tag

assert_exception(dongle, bytes("80200108FF".decode('hex') + "99999\0"), 0x6802)

# ------------------------------------------
# other tests/considerations:

# ------------------------------------------
# cur/last idx, val, time = int
# addr, tag = chars

# any non null-terminated int terminates as soon as a non-int
# is found. non null-terminated char is same as invalid char
# and/or addr/tag too long

# ------------------------------------------
# Tag too long - only reads in at most 27

# os_memcpy(tx_tag, msg, MIN(27, len));

# ------------------------------------------
# Integer under/overflow

# ------------------------------------------
# Negative timestamp

# ------------------------------------------
# Transmission not "complete" but bundle is

# ------------------------------------------
# Length byte or null terminator ends the msg

# ------------------------------------------
# Length byte 0


elapsed_time = time.time() - start_time
print "Time Elapsed: %d - Exceptions: %d" % (elapsed_time, exceptionCount)
