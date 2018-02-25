#include "conversion.h"
#include "kerl.h"
#include "bundle.h"

static inline void absorb_trits(cx_sha3_t *sha, const trit_t *trits)
{
    unsigned char bytes[48];
    trits_to_bytes(trits, bytes);
    kerl_absorb_chunk(sha, bytes);
}

void create_bundle_bytes(int64_t value, const unsigned char *tag,
                         uint32_t timestamp, uint32_t current_index,
                         uint32_t last_index, unsigned char *bytes)
{
    trit_t bundle_essence_trits[243] = {0};

    int64_to_trits(value, bundle_essence_trits, 81);
    chars_to_trits(tag, bundle_essence_trits + 81, 27);
    int64_to_trits(timestamp, bundle_essence_trits + 162, 27);
    int64_to_trits(current_index, bundle_essence_trits + 189, 27);
    int64_to_trits(last_index, bundle_essence_trits + 216, 27);

    trits_to_bytes(bundle_essence_trits, bytes);
}

void addEntry(cx_sha3_t *bundle_sha, unsigned char *address_bytes,
              int64_t value, const char *tag, uint32_t timestamp,
              uint32_t current_index, uint32_t last_index)
{
    // an address is axactly one 48-byte chunk
    kerl_absorb_chunk(bundle_sha, address_bytes);

    trit_t bundle_essence_trits[243] = {0};

    int64_to_trits(value, bundle_essence_trits, 81);
    chars_to_trits(tag, bundle_essence_trits + 81, 27);
    int64_to_trits(timestamp, bundle_essence_trits + 162, 27);
    int64_to_trits(current_index, bundle_essence_trits + 189, 27);
    int64_to_trits(last_index, bundle_essence_trits + 216, 27);

    // now we have exactly one chunk of 243 trits
    absorb_trits(bundle_sha, bundle_essence_trits);
}

static void normalize_hash(const unsigned char *hash_bytes,
                           unsigned char *normalize_hash)
{
    // TODO
    os_memcpy(hash_bytes, normalize_hash, 48);
}

void finalize(cx_sha3_t *bundle_sha)
{
    unsigned char normalized_hash_bytes[48];
    {
        unsigned char hash_bytes[48];
        kerl_squeeze_final_chunk(bundle_sha, hash_bytes);
        normalize_hash(hash_bytes, normalized_hash_bytes);
    }
}
