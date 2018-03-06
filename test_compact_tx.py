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


def create_tx_data(address, address_idx, value, tag, tx_idx, tx_len, tx_time):
    tx_struct = Struct("<81sqq27sqqq")
    return tx_struct.pack(address, address_idx, value, tag, tx_idx, tx_len, tx_time)


dongle = getDongle(True)
exceptionCount = 0
start_time = time.time()

dongle.exchange(apdu_command(INS_SINGLE_TX, create_tx_data(
    ADDRESS, 4, -10, "", 0, 1, 99999)))
dongle.exchange(apdu_command(INS_SINGLE_TX, create_tx_data(
    ADDRESS, 5, 10, "", 1, 1, 99999)))

elapsed_time = time.time() - start_time
print "Time Elapsed: %d" % elapsed_time
