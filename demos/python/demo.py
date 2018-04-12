from ledgerblue.comm import getDongle
from struct import Struct
import time

BIP44_PATH = [0x8000002C,
              0x8000107A,
              0x80000000,
              0x00000000,
              0x00000000]
SECURITY_LEVEL = 2
SRC_INDEX = 0

# APDU instructions
INS_SET_SEED = 0x01
INS_PUBKEY = 0x02
INS_TX = 0x03
INS_SIGN = 0x04
INS_DISP_ADDR = 0x05


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
    struct = Struct("<5qq")
    return struct.pack(bip44_path[0], bip44_path[1], bip44_path[2], bip44_path[3], bip44_path[4], SECURITY_LEVEL)


def pack_pub_key_input(address_idx):
    struct = Struct("<q")
    return struct.pack(address_idx)


def unpack_pubkey_output(data):
    struct = Struct("<81s")
    return struct.unpack(data)


dongle = getDongle(True)
exceptionCount = 0
start_time = time.time()

print("Initializing IOTA seed for security-level=%d..." % SECURITY_LEVEL)
dongle.exchange(apdu_command(INS_SET_SEED, pack_set_seed_input(BIP44_PATH)))

print("\nGenerating address for index=%d..." % SRC_INDEX)
response = dongle.exchange(apdu_command(
    INS_PUBKEY, pack_pub_key_input(SRC_INDEX)))
struct = unpack_pubkey_output(response)
print("  Address: %s" % struct[0].decode("utf-8"))

print("\nDisplaying address on the Ledger Nano...")
dongle.exchange(apdu_command(INS_DISP_ADDR, pack_pub_key_input(SRC_INDEX)))

elapsed_time = time.time() - start_time
print("\nTime Elapsed: %ds" % elapsed_time)
