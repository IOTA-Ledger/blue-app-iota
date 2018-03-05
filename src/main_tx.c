#include "main_tx.h"
#include "iota/iota_types.h"
#include "iota/common.h"

#define T_64 -64
#define T_32_U 32
#define T_32 -32
#define T_16_U 16
#define T_16 -16
#define T_8_U 8
#define T_8 -8

void main_tx_last(unsigned char *msg, uint8_t len, uint8_t *err,
                  BUNDLE_CTX *bundle_ctx, char *response)
{
    uint32_t last_index = str_to_int((char *)msg, len, err, T_32_U);
    // 2 is minimum (idx0=output, idx1=input,
    // idx2=input_meta)
    if (last_index < 2 || last_index > MAX_BUNDLE_INDEX_SZ) {
        THROW(0x0002);
    }
    bundle_initialize(bundle_ctx, last_index);

    memset(response, '-', 90);
    int_to_str(last_index, response, 90);
}


void main_tx_cur(unsigned char *msg, uint8_t len, uint8_t *err,
                 BUNDLE_CTX *bundle_ctx, char *response)
{
    uint32_t tx_idx = bundle_get_current_index(bundle_ctx);
    uint32_t input_idx = str_to_int((char *)msg, len, err, T_32_U);

    if (input_idx != tx_idx)
        THROW(0x0005);

    memset(response, '-', 90);
    int_to_str(tx_idx, response, 90);
}


bool main_tx_seed_idx(unsigned char *msg, uint8_t len, uint8_t *err,
                      BUNDLE_CTX *bundle_ctx, char *response,
                      uint32_t *idx_inputs, uint8_t *bundle_idx_inputs,
                      uint8_t input_counter, uint32_t global_idx)
{
    // just record the index, but let the host provide addr
    // to save time - this will be double checked in bundle
    // generation
    uint32_t tmp_idx = str_to_int((char *)msg, len, err, T_32_U);

    // copy this index for re-use with signature gen
    // and copy it's position in the bundle
    idx_inputs[input_counter] = tmp_idx;
    bundle_idx_inputs[input_counter] = bundle_get_current_index(bundle_ctx);

    memset(response, '-', 90);
    int_to_str(tmp_idx, response, 90);

    // if we are using our last address, gen new one at end
    if (tmp_idx == global_idx)
        return true;
    else
        return false;
}

void main_tx_addr(unsigned char *msg, uint8_t len, BUNDLE_CTX *bundle_ctx,
                  char *response)
{
    // ensure length is at least 81 characters
    if (len < 81)
        THROW(0x0008);

    // add the address to the current transaction
    bundle_set_address_chars(bundle_ctx, (char *)msg);

    os_memset(response, '-', 90);
    os_memcpy(response, msg, 81);
}

int64_t main_tx_value(unsigned char *msg, uint8_t len, uint8_t *err,
                      char *response, int64_t *total_bal, int64_t *send_amt)
{
    int64_t tx_val = str_to_int((char *)msg, len, err, T_64);

    // negative means our balance
    if (tx_val < 0)
        *total_bal -= tx_val;
    // positive means spending amount
    else
        *send_amt += tx_val;

    memset(response, '-', 90);
    int_to_str(tx_val, response, 90);

    return tx_val;
}

void main_tx_tag(unsigned char *msg, uint8_t len, char *tx_tag, char *response)
{
    os_memset(tx_tag, '9', 27);
    os_memcpy(tx_tag, msg, MIN(27, len));

    memset(response, '-', 90);
    memcpy(response, tx_tag, 27);
}

uint32_t main_tx_time(unsigned char *msg, uint8_t len, uint8_t *err,
                      char *response)
{
    uint32_t tx_timestamp = str_to_int((char *)msg, len, err, T_32_U);
    memset(response, '-', 90);
    int_to_str(tx_timestamp, response, 90);

    return tx_timestamp;
}
