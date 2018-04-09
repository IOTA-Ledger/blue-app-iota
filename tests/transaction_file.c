#include "transaction_file.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include "test_common.h"
#include "api.h"

#define BUFFER_LEN 10000
#define LAST_TX_INDEX 5
#define NUM_INPUTS 2

#define SCNs27 "[NOPQRSTUVWXYZ9ABCDEFGHIJKLM]"

void test_for_each_bundle(const char *file_name,
                          void (*test)(char *, TX_INPUT *, char *,
                                       char[][SIGNATURE_LENGTH]))
{
    char path_name[BUFFER_LEN];
    snprintf(path_name, sizeof(path_name), "%s/%s", TEST_FOLDER, file_name);

    FILE *file;
    if ((file = fopen(path_name, "r")) == NULL) {
        fail_msg("Could not open file.");
    }

    char line[BUFFER_LEN];
    unsigned int line_num = 0;
    while (fgets(line, sizeof(line), file) != NULL) {

        if (++line_num == 1) {
            continue;
        }

        char seed[NUM_HASH_TRYTES];
        TX_INPUT tx[LAST_TX_INDEX + 1];

        int offset = 0;

        int scanned;
        sscanf(line, "%81" SCNs27 ",%n", seed, &scanned);
        offset += scanned;

        for (int i = 0; i <= LAST_TX_INDEX; i++) {
            sscanf(line + offset,
                   "%81" SCNs27 ",%" SCNd64 ",%" SCNd64 ",%27" SCNs27
                   ",%" SCNd64 ",%n",
                   tx[i].address, &tx[i].address_idx, &tx[i].value, tx[i].tag,
                   &tx[i].timestamp, &scanned);

            tx[i].current_index = i;
            tx[i].last_index = LAST_TX_INDEX;

            offset += scanned;
        }

        char bundle_hash[NUM_HASH_TRYTES];
        sscanf(line + offset, "%81" SCNs27 ",%n", bundle_hash, &scanned);
        offset += scanned;

        char signatures[NUM_INPUTS][SIGNATURE_LENGTH];
        for (int i = 0; i < NUM_INPUTS; i++) {
            sscanf(line + offset, "%4374" SCNs27 ",%n", signatures[i],
                   &scanned);
            offset += scanned;
        }

        test(seed, tx, bundle_hash, signatures);
    }
}
