from ledgerblue.comm import getDongle
from ledgerblue.commException import CommException
from struct import Struct
import time

BIP44_PATH = [0x8000002C,
              0x8000107A,
              0x80000000,
              0x00000000,
              0x00000000]
ADDRESS = b"ADR" * 27

INS_SET_SEED = 0x01
INS_PUBKEY = 0x02
INS_TX = 0x03
INS_SIGN = 0x04


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


def pack_set_seed_input(bip44_path):
    struct = Struct("<5q")
    return struct.pack(bip44_path[0], bip44_path[1], bip44_path[2], bip44_path[3], bip44_path[4])


def pack_pub_key_input(address_idx):
    struct = Struct("<q")
    return struct.pack(address_idx)


def unpack_pubkey_output(data):
    struct = Struct("<81s")
    return struct.unpack(data)


def pack_tx_input(address, address_idx, value, tag, tx_idx, tx_len, tx_time):
    tx_struct = Struct("<81sqq27sqqq")
    return tx_struct.pack(address, address_idx, value, tag, tx_idx, tx_len, tx_time)


def unpack_tx_output(data):
    struct = Struct("<?q81s")
    return struct.unpack(data)


def pack_sign_input(transaction_idx):
    struct = Struct("<q")
    return struct.pack(transaction_idx)


def unpack_sign_output(data):
    struct = Struct("<243sLL")
    return struct.unpack(data)


dongle = getDongle(True)
exceptionCount = 0
start_time = time.time()

dongle.exchange(apdu_command(INS_SET_SEED, pack_set_seed_input(BIP44_PATH)))

response = dongle.exchange(apdu_command(INS_PUBKEY, pack_pub_key_input(1)))
print(unpack_pubkey_output(response))

response = dongle.exchange(apdu_command(
    INS_TX, pack_tx_input(ADDRESS, 0, 10, b"XC", 0, 2, 99999)))
print(unpack_tx_output(response))

response = dongle.exchange(apdu_command(INS_TX, pack_tx_input(
    b"MTPYSBLSL9HENRQKP9IPYYZTHEOECLXGYMZIYYUCYAPZYFAECX9ZSFOSFMDNYQAPYHVMTVUX9HNNUKOB9", 1, -10, b"", 1, 2, 99999)))
print(unpack_tx_output(response))

while True:
    response = dongle.exchange(apdu_command(INS_SIGN, pack_sign_input(1)))
    struct = unpack_sign_output(response)
    print(struct)

    if struct[1] == struct[2]:
        break

elapsed_time = time.time() - start_time
print("Time Elapsed: %d" % elapsed_time)