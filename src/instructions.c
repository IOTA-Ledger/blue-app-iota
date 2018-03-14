#include "instructions.h"
#include "common.h"

// iota-related stuff
#include "iota/kerl.h"
#include "iota/conversion.h"
#include "iota/addresses.h"
#include "iota/bundle.h"
#include "iota/signing.h"

extern unsigned char seed_bytes[48];

unsigned int ins_set_seed(unsigned char *io_data, unsigned int len)
{
    if (len < sizeof(SET_SEED_INPUT)) {
        THROW(0x6D09);
    }
    SET_SEED_INPUT *input = (SET_SEED_INPUT *)(io_data);

    unsigned int path[BIP44_PATH_LEN];
    for (unsigned int i = 0; i < BIP44_PATH_LEN; i++) {
        if (!ASSIGN(path[i], input->bip44_path[i]))
            THROW(INVALID_PARAMETER);
    }

    // we only care about privateKeyData and using this to
    // generate our iota seed
    unsigned char entropy[64];
    os_perso_derive_node_bip32(CX_CURVE_256K1, path, BIP44_PATH_LEN, entropy,
                               entropy + 32);
    get_seed(entropy, sizeof(entropy), seed_bytes);

    return 0;
}

unsigned int ins_pubkey(unsigned char *io_data, unsigned int len)
{
    if (len < sizeof(PUBKEY_INPUT)) {
        THROW(0x6D09);
    }
    PUBKEY_INPUT *input = (PUBKEY_INPUT *)(io_data);

    uint32_t address_idx;
    if (!ASSIGN(address_idx, input->address_idx)) {
        THROW(INVALID_PARAMETER);
    }

    unsigned char addr_bytes[48];
    get_public_addr(seed_bytes, address_idx, SECURITY_LEVEL, addr_bytes);

    PUBKEY_OUTPUT *output = (PUBKEY_OUTPUT *)(io_data);
    os_memset(output, 0, sizeof(PUBKEY_OUTPUT));

    // convert the 48 byte address into base-27 address
    bytes_to_chars(addr_bytes, output->address, 48);

    return sizeof(PUBKEY_OUTPUT);
}
