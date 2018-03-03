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

#define INS_GET_PUBKEY 0x01
#define INS_BAD_PUBKEY 0x02
#define INS_GOOD_PUBKEY 0x04
#define INS_CHANGE_INDEX 0x08
#define INS_SIGN 0x10

dongle = getDongle(True)

exceptionCount = 0

# 80 is magic start byte, 04 is type (GETPUBLICKEY) ignore rest of the data
start_time = time.time()
#publicKey = dongle.exchange(bytes(("80010000FF"+bipp44_path).decode('hex')))


# first byte: magic first byte (always 80)
# second byte: instruction type
# third byte: more, or end transmission
# fourth byte: sub instruction type
# fifth byte: length of message

test_addr = "ADR"*27 + "\0";


# ------------------------------------------
# Should fail on wrong initial byte
try:
    dongle.exchange(bytes("70200020FF".decode('hex') + "5\0"));
except:
    exceptionCount += 1;

# ------------------------------------------
# Should fail on not rcv last index first (this is Cur flag)
try:
    dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"));
except:
    exceptionCount += 1;

# ------------------------------------------
# Last idx too small
try:
    dongle.exchange(bytes("80200020FF".decode('hex') + "1\0"));
except:
    exceptionCount += 1;

# ------------------------------------------
# Last idx too large
try:
    dongle.exchange(bytes("80200020FF".decode('hex') + "9\0"));
except:
    exceptionCount += 1;

# ------------------------------------------
# Cur out of order
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0")); # set last idx
try:
    dongle.exchange(bytes("80200010FF".decode('hex') + "1\0"));
except:
    exceptionCount += 1;

# ------------------------------------------
# Previous TX incomplete
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0")); # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0")); # set cur idx
try:
    dongle.exchange(bytes("80200010FF".decode('hex') + "1\0"));
except:
    exceptionCount += 1;

# ------------------------------------------
# Previous TX incomplete - missing time
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0")); # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0")); # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr)); # set addr
dongle.exchange(bytes("80200002FF".decode('hex') + "200\0")); # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0")); # set tag
try:
    dongle.exchange(bytes("80200010FF".decode('hex') + "1\0")); # set cur idx
except:
    exceptionCount += 1;

# ------------------------------------------
# Input missing seed idx
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0")); # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0")); # set cur idx
dongle.exchange(bytes("8020000151".decode('hex') + test_addr)); # set addr
dongle.exchange(bytes("80200002FF".decode('hex') + "-5\0")); # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0")); # set tag
dongle.exchange(bytes("80200108FF".decode('hex') + "99999\0")); # set time
try:
    dongle.exchange(bytes("80200010FF".decode('hex') + "1\0")); # set cur idx
except:
    exceptionCount += 1;

# ------------------------------------------
# Input missing input address
dongle.exchange(bytes("80200020FF".decode('hex') + "5\0")); # set last idx
dongle.exchange(bytes("80200010FF".decode('hex') + "0\0")); # set cur idx
dongle.exchange(bytes("80200040FF".decode('hex') + "4\0")); # set input idx
dongle.exchange(bytes("80200002FF".decode('hex') + "-5\0")); # set val
dongle.exchange(bytes("802000041B".decode('hex') + "TAG\0")); # set tag
dongle.exchange(bytes("80200108FF".decode('hex') + "99999\0")); # set time
try:
    dongle.exchange(bytes("80200010FF".decode('hex') + "1\0")); # set cur idx
except:
    exceptionCount += 1;



elapsed_time = time.time() - start_time
print "Time Elapsed: %d - Exceptions: %d" % (elapsed_time, exceptionCount)
