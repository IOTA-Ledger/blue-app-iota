#include "transaction_file.h"
#include <inttypes.h>
#include <stdio.h>
#include <string.h>
#include "test_common.h"
#include "api.h"
#include "iota/iota_types.h"

#define BUFFER_LEN 20000

#define SCNs27 "[NOPQRSTUVWXYZ9ABCDEFGHIJKLM]"

void test_for_each_bundle(const char *file_name,
                          void (*test)(char *, int, TX_INPUT *, int, char *,
                                       char[][SIGNATURE_LENGTH]))
{
    char path_name[BUFFER_LEN];
    snprintf(path_name, sizeof(path_name), "%s/%s", TEST_FOLDER, file_name);

    FILE *file;
    if ((file = fopen(path_name, "r")) == NULL) {
        fail_msg("Could not open file.");
    }

    char line[BUFFER_LEN];
    while (fgets(line, sizeof(line), file) != NULL) {
        char seed[NUM_HASH_TRYTES] = {};
        unsigned int security;
        unsigned int last_index;
        TX_INPUT tx[MAX_BUNDLE_SIZE] = {};

        int offset = 0;

        int scanned;
        sscanf(line, "%81c,%u,%u,%n", seed, &security, &last_index, &scanned);
        offset += scanned;

        if (last_index >= MAX_BUNDLE_SIZE) {
            fail_msg("Max bundle index violated.");
        }

        for (unsigned int i = 0; i <= last_index; i++) {
            sscanf(line + offset,
                   "%81c,%" SCNu32 ",%" SCNd64 ",%27c,%" SCNu32 ",%n",
                   tx[i].address, &tx[i].address_idx, &tx[i].value, tx[i].tag,
                   &tx[i].timestamp, &scanned);

            tx[i].current_index = i;
            tx[i].last_index = last_index;

            offset += scanned;
        }

        char bundle_hash[NUM_HASH_TRYTES];
        sscanf(line + offset, "%81c,%n", bundle_hash, &scanned);
        offset += scanned;

        const int num_inputs = (last_index - 1) / security;
        char signatures[num_inputs][SIGNATURE_LENGTH];
        for (int i = 0; i < num_inputs; i++) {
            char buffer[SIGNATURE_LENGTH + 1] = {};
            sscanf(line + offset, "%6561" SCNs27 ",%n", buffer, &scanned);
            strncpy(signatures[i], buffer, SIGNATURE_LENGTH);
            offset += scanned;
        }

        test(seed, security, tx, last_index, bundle_hash, signatures);
    }
}
