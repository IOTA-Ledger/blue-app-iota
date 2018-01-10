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

#define INS_GET_PUBKEY 0x02
#define INS_BAD_PUBKEY 0x04
#define INS_SIGN 0x08

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
publicKey = dongle.exchange(bytes(("80020000FF"+bipp44_path).decode('hex')))
print "Response: " + str(publicKey)
try:
	offset = 0
	while offset <> len(textToSign):
		#sign in chunks of 255
		if (len(textToSign) - offset) > 255:
			chunk = textToSign[offset : offset + 255] 
		else:
			chunk = textToSign[offset:]
		# if this is the last chunk to sign
		if (offset + len(chunk)) == len(textToSign):
			p1 = 0x80 # magic char to signal LAST
		else:
			p1 = 0x00 # else signal more

		#exchange with apdu
		# 0x80 is magic first byte, INS_SIGN = 0x02 [0], [1]
		# p1 tells it if there's more or if this is last chunk [2]
		# chr(0x00) I think this is a filler byte [3]
		# chr(len(chunk)) specify length of chunk [4]
		# bytes(chunk) send data [5]
		apdu = bytes("8002".decode('hex')) + chr(p1) + chr(0x00) + chr(len(chunk)) + bytes(chunk)
		signature = dongle.exchange(apdu)
		offset += len(chunk)

	print "signature " + str(signature).encode('hex')
	# pass public key bytes to function to return pubkey
	publicKey = PublicKey(bytes(publicKey), raw=True)
	# deserialize signature bytes
	signature = publicKey.ecdsa_deserialize(bytes(signature))
	# Use this public key to verify the ledger's private key signature
	print "verified " + str(publicKey.ecdsa_verify(bytes(textToSign), signature))
# handle exception
except CommException as comm:
	if comm.sw == 0x6985:
		print "Aborted by user"
	else:
		print "Invalid status " + comm.sw 