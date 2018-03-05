#ifndef MAIN_TX
#define MAIN_TX

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "iota/bundle.h"
#include "aux.h"

#include "os.h"
#include "cx.h"

void main_tx_last(unsigned char* msg, uint8_t len, uint8_t *err,
                  BUNDLE_CTX *bundle_ctx, char *response);
void main_tx_cur(unsigned char* msg, uint8_t len, uint8_t *err,
                 BUNDLE_CTX *bundle_ctx, char *response);
bool main_tx_seed_idx(unsigned char* msg, uint8_t len, uint8_t *err,
                      BUNDLE_CTX *bundle_ctx, char *response,
                      uint32_t *idx_inputs, uint8_t *bundle_idx_inputs,
                      uint8_t input_counter, uint32_t global_idx);
void main_tx_addr(unsigned char* msg, uint8_t len,
                  BUNDLE_CTX *bundle_ctx, char *response);
int64_t main_tx_value(unsigned char* msg, uint8_t len, uint8_t *err,
                      char *response, int64_t *total_bal,
                      int64_t *send_amt);
void main_tx_tag(unsigned char* msg, uint8_t len,
                 char *tx_tag, char *response);
uint32_t main_tx_time(unsigned char* msg, uint8_t len,
                      uint8_t *err, char *response);

#endif // MAIN_TX
