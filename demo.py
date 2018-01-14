#!/usr/bin/env python
#*******************************************************************************
#*     Ledger Blue
#*     (c) 2016 Ledger
#*
#*    Licensed under the Apache License, Version 2.0 (the "License");
#*    you may not use this file except in compliance with the License.
#*    You may obtain a copy of the License at
#*
#*            http://www.apache.org/licenses/LICENSE-2.0
#*
#*    Unless required by applicable law or agreed to in writing, software
#*    distributed under the License is distributed on an "AS IS" BASIS,
#*    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#*    See the License for the specific language governing permissions and
#*    limitations under the License.
#********************************************************************************
from ledgerblue.comm import getDongle
from ledgerblue.commException import CommException
from secp256k1 import PublicKey

# Call GET_PUBKEY to receive current public key
# Call Bad_pubkey to increment the global index
# call good_pubkey to write current index as active
# call change_index to modify global index (DOESNT WRITE UNTIL RECV GOOD_PUBKEY)

#define INS_GET_PUBKEY 0x01
#define INS_BAD_PUBKEY 0x02
#define INS_GOOD_PUBKEY 0x04
#define INS_CHANGE_INDEX 0x08
#define INS_SIGN 0x10

bipp44_path = (
               "8000002C"
               +"80000378"
               +"80000000"
               +"00000000"
               +"00000000")

textToSign = ""
dongle = getDongle(True)


# 80 is magic start byte, second byte is INS, third byte is type

while True:
    data = raw_input("Enter text to sign, end with an empty line : ")
    if data == "1":
        publicKey = dongle.exchange(bytes(("80012900FF"+bipp44_path).decode('hex')))
        print "Response: " + str(publicKey)
    elif data == "2":
        publicKey = dongle.exchange(bytes(("8002000000").decode('hex')))
        print "Response: " + str(publicKey)
    elif data == "4":
        publicKey = dongle.exchange(bytes(("8004000000").decode('hex')))
        print "Response: " + str(publicKey)
    elif data == "8":
        publicKey = dongle.exchange(bytes(("8008000000").decode('hex')) + "456\0")
        print "Response: " + str(publicKey)

