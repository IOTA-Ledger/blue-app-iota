#include "test_ternary.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "../src/vendor/iota/bigint.h"
#include "../src/vendor/iota/conversion.h"

trit_t randomTrit() {
  return (trit_t) ((rand() % 3) - 1);
}

void testTrits(int amount) {

}

void testAddressBug() {
  tryte_t seed_trytes[81] = {0};
  {
    char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
    chars_to_trytes(test_kerl, seed_trytes, 81);
  }
  {
    trit_t seed_trits[81 * 3] = {0};
    trytes_to_trits(seed_trytes, seed_trits, 81);
    specific_243trits_to_49trints(seed_trits, seed_trints);
  }
  // {
  //   kerl_initialize();
  //   kerl_absorb_trints(seed_trints, 49);
  //   kerl_squeeze_trints(seed_trints, 49);
  // }
  {
    // Print result of trints_to_words
    int32_t words[12];
    trints_to_words(seed_trints, words);
    uint16_t total = 0;
    for(int i = 0; i < 12; i++) {
      int numSize = (int)((ceil(log10(words[i]))+1)*sizeof(char));
      char numStr[numSize];
      sprintf(numStr, "%ld", words[i]);
      for(int j = 0; j < numSize; j++) {
        msg[total++] = numStr[j];
      }
    }
  }
}

int main() {
  testAddressBug();
  int seed = 2;
  srand(seed);

  //testTrits(2);
  testTrits(10000);
  return 0;
}
