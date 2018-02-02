#include "addresses.h"
#include "common.h"
#include "bigint.h"
#include "conversion.h"
#include "kerl.h"

static void key_digests(const uint32_t *key, uint8_t security,
                        uint32_t *digests)
{
    for (uint8_t l = 0; l < security; l++) {
        uint32_t digests_fragment[12 * 27];
        const uint32_t *p = key + (l * 12 * 27);

        for (uint8_t i = 0; i < 27; i++) {
            uint32_t buffer[12];
            os_memcpy(buffer, p, 12 * 4);
            p += 12;

            for (int k = 0; k < 26; k++) {
                kerl_initialize();
                kerl_absorb_bigints(buffer, 12);
                kerl_squeeze_bigints(buffer, 12);
            }

            os_memcpy(digests_fragment + 12 * i, buffer, 12 * 4);
        }

        kerl_initialize();
        kerl_absorb_bigints(digests_fragment, 12 * 27);
        kerl_squeeze_bigints(digests, 12);
        digests += 12;
    }
}

static void digests_address(const uint32_t *digests, uint8_t security,
                            uint32_t *address)
{
    kerl_initialize();
    kerl_absorb_bigints(digests, 12 * security);
    kerl_squeeze_bigints(address, 12);
}

void generate_private_key(const uint32_t *seed_bigint, uint32_t idx,
                          uint8_t security, uint32_t *key)
{
    // work on temporary bigint, so that seed_bigint is not destroyed
    uint32_t bigint[12];
    bigint_add_int_u(seed_bigint, idx, bigint, 12);

    kerl_initialize();

    kerl_absorb_bigints(bigint, 12);
    kerl_squeeze_bigints(bigint, 12);

    kerl_initialize();
    kerl_absorb_bigints(bigint, 12);

    uint32_t *p = key;
    for (uint8_t l = 1; l <= security; l++) {
        for (uint8_t i = 0; i < 27; i++) {
            kerl_squeeze_bigints(p, 12);
            p += 12;
        }
    }
}

void generate_public_address(const uint32_t *private_key, uint8_t security,
                             uint32_t *address)
{
    uint32_t digests[12 * security];

    key_digests(private_key, security, digests);
    digests_address(digests, security, address);
}
