#include "test_ternary.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

trit_t randomTrit() {
  return (trit_t) ((rand() % 3) - 1);
}

void testTrits(int amount) {

}

int main() {
  int seed = 2;
  srand(seed);

  //testTrits(2);
  testTrits(10000);
  return 0;
}
