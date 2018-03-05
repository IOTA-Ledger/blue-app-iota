#ifndef MAIN_TX
#define MAIN_TX

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "iota/bundle.h"
#include "aux.h"
#include "main.h"
#include "iota/addresses.h"
#include "iota/conversion.h"

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
                      int64_t *send_amt, BUNDLE_CTX *bundle_ctx);
void main_tx_tag(unsigned char* msg, uint8_t len,
                 char *tx_tag, char *response);
uint32_t main_tx_time(unsigned char* msg, uint8_t len,
                      uint8_t *err, char *response);
void main_tx_complete(BUNDLE_CTX *bundle_ctx, int64_t tx_val,
                      char *tx_tag, uint32_t tx_timestamp,
                      unsigned char tx_mask);
void main_bundle_complete(int64_t total_bal, int64_t send_amt,
                          bool last_addr_used, uint32_t *global_idx,
                          BUNDLE_CTX *bundle_ctx, uint32_t tx_timestamp,
                          char *response);

#endif // MAIN_TX
