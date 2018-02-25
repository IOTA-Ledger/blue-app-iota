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

bipp44_path = (
               "8000002C"
              +"80000378"
              +"80000000"
              +"00000000"
              +"00000000")

textToSign = ""
while True:
	data = raw_input("Enter text to sign, end with an empty line : ")
	if len(data) == 0:
		break
	textToSign += data + "\n"

dongle = getDongle(True)
# 80 is magic start byte, 04 is type (GETPUBLICKEY) ignore rest of the data
start_time = time.time()
#publicKey = dongle.exchange(bytes(("80010000FF"+bipp44_path).decode('hex')))
#80 20 01

#last - provide last index first
publicKey = dongle.exchange(bytes("80200020FF".decode('hex') + "5\0"));
print "Last: " + str(publicKey) + "\n";



#per tx, make sure cur comes first
#cur
publicKey = dongle.exchange(bytes("80200010FF".decode('hex') + "0\0"));
print "Cur: " + str(publicKey) + "\n";

#addr
publicKey = dongle.exchange(bytes("8020000151".decode('hex') +
    "CQYUHGQAILW9ODCXLKRHBIEODRBPTBUKSZZ99O9EGTIKITJCGTNVKPQQ9LWKLROYWTKGDLUZSXFUKSLQZ\0"));
print "Addr: " + str(publicKey) + "\n";

#value
publicKey = dongle.exchange(bytes("80200002FF".decode('hex') + "18\0"));
print "Val: " + str(publicKey) + "\n";

#tag - 1B is 27
publicKey = dongle.exchange(bytes("802000041B".decode('hex') + "TAG999999999999999999999995\0"));
print "Tag: " + str(publicKey) + "\n";

#time
publicKey = dongle.exchange(bytes("80200008FF".decode('hex') + "99999\0"));
print "Time: " + str(publicKey) + "\n";




#per tx, make sure cur comes first
#cur
publicKey = dongle.exchange(bytes("80200010FF".decode('hex') + "1\0"));
print "Cur: " + str(publicKey) + "\n";

#addr
publicKey = dongle.exchange(bytes("8020000110".decode('hex') + "0\0"));
print "Addr: " + str(publicKey) + "\n";

#value
publicKey = dongle.exchange(bytes("80200002FF".decode('hex') + "-9\0"));
print "Val: " + str(publicKey) + "\n";

#tag - 1B is 27
publicKey = dongle.exchange(bytes("802000041B".decode('hex') + "TAG999999999999999999999995\0"));
print "Tag: " + str(publicKey) + "\n";

#time
publicKey = dongle.exchange(bytes("80200008FF".decode('hex') + "99999\0"));
print "Time: " + str(publicKey) + "\n";




#per tx, make sure cur comes first
#cur
publicKey = dongle.exchange(bytes("80200010FF".decode('hex') + "3\0"));
print "Cur: " + str(publicKey) + "\n";

#addr
publicKey = dongle.exchange(bytes("8020000110".decode('hex') + "4\0"));
print "Addr: " + str(publicKey) + "\n";

#value
publicKey = dongle.exchange(bytes("80200002FF".decode('hex') + "-15\0"));
print "Val: " + str(publicKey) + "\n";

#tag - 1B is 27
publicKey = dongle.exchange(bytes("802000041B".decode('hex') + "TAG999999999999999999999995\0"));
print "Tag: " + str(publicKey) + "\n";

#time
publicKey = dongle.exchange(bytes("80200108FF".decode('hex') + "99999\0"));
print "Time: " + str(publicKey) + "\n";




##
#use_idx = True
#address
#if use_idx:
#    publicKey = dongle.exchange(bytes("8020000110".decode('hex') +
#                                      "0"));
#else:
#    publicKey = dongle.exchange(bytes("8020000151".decode('hex') +
#        "CQYUHGQAILW9ODCXLKRHBIEODRBPTBUKSZZ99O9EGTIKITJCGTNVKPQQ9LWKLROYWTKGDLUZSXFUKSLQZ"));
#print "Addr: " + str(publicKey);





elapsed_time = time.time() - start_time

# third byte specifies FINAL TRANSMISSION - 00 is more, 01 is end
# fourth byte specifies TX PART
#80 20 01

print "Response: %s took: %d seconds" % (str(publicKey), elapsed_time)
