#!/usr/bin/env python
from ledgerblue.comm import getDongle
from ledgerblue.commException import CommException
from struct import Struct
import time

ADDRESS = "ADR" * 27 + "\0"
INS_SINGLE_TX = 0x40


def apdu_command(ins, data, p1=0, p2=0):
    b = bytes(data)

    command = bytearray()
    command.append(0x80)  # Instruction class (1)
    command.append(ins)  # Instruction code (1)
    command.extend([p1, p2])  # Instruction parameters (2)
    command.append(len(b))  # length of data (1)
    command.extend(b)  # Command data
    command.append(0)

    return command


def pack_tx_input(address, address_idx, value, tag, tx_idx, tx_len, tx_time):
    tx_struct = Struct("<81sqq27sqqq")
    return tx_struct.pack(address, address_idx, value, tag, tx_idx, tx_len, tx_time)


def unpack_bundle_output(data):
    bundle_struct = Struct("<q81s")
    return bundle_struct.unpack(data)


dongle = getDongle(True)
exceptionCount = 0
start_time = time.time()

response = dongle.exchange(apdu_command(INS_SINGLE_TX, pack_tx_input(
    ADDRESS, 4, -10, "", 0, 1, 99999)))

response = dongle.exchange(apdu_command(INS_SINGLE_TX, pack_tx_input(
    ADDRESS, 5, 10, "", 1, 1, 99999)))
print unpack_bundle_output(response)

elapsed_time = time.time() - start_time
print "Time Elapsed: %d" % elapsed_time
