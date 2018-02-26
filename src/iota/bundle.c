#include "conversion.h"
#include "kerl.h"
#include "bundle.h"

static inline void absorb_trits(cx_sha3_t *sha, const trit_t *trits)
{
    unsigned char bytes[48];
    trits_to_bytes(trits, bytes);
    kerl_absorb_chunk(sha, bytes);
}

void create_bundle_bytes(int64_t value, const char *tag, uint32_t timestamp,
                         uint32_t current_index, uint32_t last_index,
                         unsigned char *bytes)
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

static inline int decrement_tryte(int max, tryte_t *tryte)
{
    const int slack = *tryte - MIN_TRYTE_VALUE;
    if (slack <= 0) {
        return 0;
    }

    const int dec = MIN(max, slack);
    *tryte -= dec;

    return dec;
}

static inline int increment_tryte(int max, tryte_t *tryte)
{
    const int slack = MAX_TRYTE_VALUE - *tryte;
    if (slack <= 0) {
        return 0;
    }

    const int inc = MIN(max, slack);
    *tryte += inc;

    return inc;
}

static void normalize_hash_fragment(tryte_t *fragment_trytes)
{
    int sum = 0;
    for (unsigned int j = 0; j < 27; j++) {
        sum += fragment_trytes[j];
    }

    for (unsigned int j = 0; j < 27; j++) {
        if (sum > 0) {
            sum -= decrement_tryte(sum, &fragment_trytes[j]);
        }
        else if (sum < 0) {
            sum += increment_tryte(-sum, &fragment_trytes[j]);
        }
        if (sum == 0) {
            break;
        }
    }
}

static void normalize_hash(tryte_t *hash_trytes)
{
    for (unsigned int i = 0; i < 3; i++) {
        normalize_hash_fragment(hash_trytes + i * 27);
    }
}

void finalize(cx_sha3_t *bundle_sha)
{
    unsigned char hash_bytes[48];
    kerl_squeeze_final_chunk(bundle_sha, hash_bytes);

    tryte_t hash_trytes[81];
    bytes_to_trytes(hash_bytes, hash_trytes);

    normalize_hash(hash_trytes);
}
