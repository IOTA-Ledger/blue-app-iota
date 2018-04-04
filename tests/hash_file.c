#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "test_common.h"

#define BUFFER_LEN 1024

static void extract_hashes(char *string, char *hashes[], size_t num_hashes)
{

    char *pch = strtok(string, ",");
    for (size_t i = 0; i < num_hashes; i++) {

        if (pch == NULL) {
            hashes[i] = NULL;
            continue;
        }

        hashes[i] = pch;

        pch = strtok(NULL, ",");
    }
}

void test_for_each_line(const char *file_name, void (*test)(char **))
{
    char path_name[BUFFER_LEN];
    snprintf(path_name, sizeof(path_name), "%s/%s", KERL_TEST_FOLDER, file_name);

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

        // remove trailing new line
        char *pos;
        if ((pos = strchr(line, '\n')) != NULL) {
            *pos = '\0';
        }
        else {
            fail_msg("Line longer than buffer.");
        }

        char *hashes[MAX_NUM_HASHES];

        extract_hashes(line, hashes, MAX_NUM_HASHES);

        test(hashes);
    }

    fclose(file);
}
