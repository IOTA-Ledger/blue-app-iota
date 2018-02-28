/*******************************************************************************
 *   Ledger Blue
 *   (c) 2016 Ledger
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 ********************************************************************************/

#include "main.h"
#include "ui.h"
#include "aux.h"


// iota-related stuff
#include "iota/kerl.h"
#include "iota/conversion.h"
#include "iota/addresses.h"
#include "iota/transaction.h"
#include "iota/bundle.h"

cx_sha256_t hash;
unsigned char hashTainted; // notification to restart the hash

// use internalStorage_t to temp hold the storage
typedef struct internalStorage_t {
    uint8_t initialized;
    char pub_addr[81];
    uint32_t seed_key;

} internalStorage_t;

uint32_t global_idx;

// N_storage_real will hold the actual address for NVRAM
WIDE internalStorage_t N_storage_real;
#define N_storage (*(WIDE internalStorage_t *)PIC(&N_storage_real))

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];
ux_state_t ux;


static void IOTA_main(void)
{
    volatile unsigned int rx = 0;
    volatile unsigned int tx = 0;
    volatile unsigned int flags = 0;

    // initialize the UI
    ui_init();

    char response[90];
    unsigned char tx_mask = 0;

    BUNDLE_CTX bundle_ctx;
    bool initialized = false;

    // actual seed index for address
    uint32_t idx_inputs[MAX_BUNDLE_NUM_INPUTS];
    // bundle index
    uint8_t bundle_idx_inputs[MAX_BUNDLE_NUM_INPUTS];
    uint8_t input_counter = 0;

    // TODO: convert to 64 bit values
    int tx_val = 0;
    char tx_tag[27];
    uint32_t tx_timestamp = 0;

    uint32_t total_bal = 0;
    uint32_t send_amt = 0;

    bool broadcast_complete = false;
    bool last_addr_used = false;

    // DESIGN NOTE: the bootloader ignores the way APDU are fetched. The only
    // goal is to retrieve APDU.
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY
        {
            TRY
            {
                rx = tx;
                tx = 0; // ensure no race in catch_other if io_exchange throws
                // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);

                // flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                uint8_t len = G_io_apdu_buffer[APDU_BODY_LENGTH_OFFSET];
                char *msg = (char *)G_io_apdu_buffer + APDU_HEADER_LENGTH;

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
                // upon return G_io_apdu_buffer is null terminated (though
                // python  will still display garbage characters after the null
                // termination)
                case INS_GET_MULTI_SEND: {
                    tx_mask = tx_mask | G_io_apdu_buffer[APDU_TX_TYPE];

                    // check third byte for which part of tx we are receiving
                    switch (G_io_apdu_buffer[APDU_TX_TYPE]) {
                    /* -------------------- TX LAST ------------------- */
                    case TX_LAST: {
                        // only rcv last index once
                        if (initialized) {
                            THROW(LAST_IDX_ERROR);
                        }

                        uint32_t last_index = str_to_int(msg, len);
                        // 2 is minimum (idx0=output, idx1=input,
                        // idx2=input_meta)
                        if (last_index < 2 ||
                            last_index > MAX_BUNDLE_NUM_INPUTS) {
                            last_index = 0;
                            THROW(LAST_IDX_ERROR);
                        }
                        bundle_initialize(&bundle_ctx, last_index);

                        memset(response, '-', 90);
                        uint_to_str(last_index, response, 10);
                    } break;
                    /* -------------------- TX CUR ------------------- */
                    case TX_CUR: {
                        if (!initialized) {
                            THROW(LAST_IDX_ERROR);
                        }

                        uint32_t tx_idx = bundle_get_current_index(&bundle_ctx);
                        uint32_t input_idx = str_to_int(msg, len);

                        // ensure current index is first thing we receive
                        // and verify the indexes stay in order
                        if (tx_mask != TX_CUR_LAST)
                            THROW(IDX_OUT_OF_ORDER);
                        if (input_idx != tx_idx)
                            THROW(TEST_ERROR);

                        memset(response, '-', 90);
                        uint_to_str(tx_idx - 1, response, 10);
                    } break;
                    /* --------------- TX SEED IDX ------------------ */
                    case TX_SEED_IDX: {
                        if (!initialized) {
                            THROW(LAST_IDX_ERROR);
                        }

                        // just record the index, but let the host provide addr
                        // to save time - this will be double checked in bundle
                        // generation
                        uint32_t tmp_idx = str_to_int(msg, len);

                        // copy this index for re-use with signature gen
                        // and copy it's position in the bundle
                        idx_inputs[input_counter] = tmp_idx;
                        bundle_idx_inputs[input_counter++] =
                            bundle_get_current_index(&bundle_ctx);

                        // if we are using our last address, gen new one
                        if (tmp_idx == global_idx)
                            last_addr_used = true;
                    } break;
                    /* --------------- TX ADDR ------------------ */
                    case TX_ADDR: {
                        if (!initialized) {
                            THROW(LAST_IDX_ERROR);
                        }

                        // if length is 81, we are provided an outgoing address
                        if (len >= 81) {
                            // add the address to the current transaction
                            bundle_set_address_chars(&bundle_ctx, msg);

                            os_memset(response, '-', 90);
                            os_memcpy(response, msg, 81);
                        }
                        else
                            THROW(BAD_ADDR);
                    } break;
                    /* ------------------ TX VALUE ------------------ */
                    case TX_VAL: {
                        if (!initialized) {
                            THROW(LAST_IDX_ERROR);
                        }

                        // if it's a negative amount coming in, add it as our
                        // balance
                        if (msg[0] == '-') {
                            tx_val = -1 * str_to_int(msg + 1, len);
                            total_bal -= tx_val;

                            // once the tx is fully formed we will generate a
                            // meta tx for the input as well
                        }
                        // if positive it is outgoing amount
                        else {
                            tx_val = str_to_int(msg, len);
                            send_amt += tx_val;
                        }

                        memset(response, '-', 90);
                        int_to_str(tx_val, response, 10);
                    } break;
                    /* -------------------- TX TAG ------------------- */
                    case TX_TAG: {
                        if (!initialized) {
                            THROW(LAST_IDX_ERROR);
                        }

                        os_memset(tx_tag, '9', 27);
                        os_memcpy(tx_tag, msg, MIN(27, len));

                        memset(response, '-', 90);
                        memcpy(response, tx_tag, 27);
                    } break;
                    /* -------------------- TX TIME ------------------- */
                    case TX_TIME: {
                        if (!initialized) {
                            THROW(LAST_IDX_ERROR);
                        }

                        tx_timestamp = str_to_int(msg, len);
                        memset(response, '-', 90);
                        uint_to_str(tx_timestamp, response, 10);
                    } break;

                    // Unknown TX type
                    default:
                        THROW(UNKNOWN_TX_TYPE);
                        break;
                    }

                    // tx is complete
                    if (tx_mask & TX_FULL) {
                        uint32_t tx_idx = bundle_add_tx(&bundle_ctx, tx_val,
                                                        tx_tag, tx_timestamp);

                        // if tx val is negative, it's input, create meta tx
                        if (tx_val < 0) {
                            // since input, make sure we received the index
                            if ((tx_mask & TX_SEED_IDX) == 0) {
                                THROW(NO_SEED_IDX);
                            }

                            // copy address into meta tx bundle bytes
                            const unsigned char *address_bytes =
                                bundle_get_address_bytes(&bundle_ctx, tx_idx);
                            bundle_set_address_bytes(&bundle_ctx,
                                                     address_bytes);

                            bundle_add_tx(&bundle_ctx, 0, tx_tag, tx_timestamp);
                        }

                        // reset tx_mask
                        tx_mask = TX_LAST;
                    }

                    // entire bundle is complete
                    if (G_io_apdu_buffer[APDU_MORE] == TX_END) {
                        // verify the last transaction is fully created
                        if (tx_mask != TX_LAST)
                            THROW(INCOMPLETE_TX);

                        // TODO: do we want to support unbalanced transactions?
                        if (total_bal != send_amt) {
                            THROW(UNBALANCED_TX);
                        }

                        unsigned char bundle_hash[48];
                        bundle_finalize(&bundle_ctx, bundle_hash);

                        memset(response, '-', 90);
                        bytes_to_chars(bundle_hash, response, 48);

                        broadcast_complete = true;
                    }

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, response, 90);

                    tx = 90;
                    // Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
                    G_io_apdu_buffer[tx++] = 0x00;

                    // send back response
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                    flags |= IO_ASYNCH_REPLY;

                    char dest_addr[82];
                    // very first tx should be dest_addr
                    bytes_to_chars(bundle_get_address_bytes(&bundle_ctx, 0),
                                   dest_addr, 48);

                    if (broadcast_complete) {
                        ui_sign_tx(total_bal, send_amt, dest_addr, 82);
                    }
                    else {
                        char top[21], bot[21];
                        memcpy(top, "Balance: ", 10);
                        memcpy(bot, "Spend: ", 8);

                        uint_to_str(total_bal, top + 9, 21);
                        uint_to_str(send_amt, bot + 7, 21);

                        ui_display_message(top, 20, TYPE_STR, NULL, 0, 0, bot,
                                           20, TYPE_STR);
                    }
                } break;

                    /* ---------------------------------------------
                     -----------------------------------------------
                     ---------------- GET PUBLIC KEY ---------------
                     -----------------------------------------------
                     ----------------------------------------------- */
                case INS_GET_PUBKEY: {
                    // we only care about privateKeyData, we will be discarding
                    // everything else, and using this to generate our iota seed
                    unsigned char privateKeyData[32];
                    { // Localize public key (since we discard it anyways)
                        // private key and bip44path

                        if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                            hashTainted = 1;
                            THROW(0x6D09);
                        }

                        /** BIP44 path, used to derive the private key from the
                         * mnemonic by calling os_perso_derive_node_bip32. */
                        unsigned char *bip44_in =
                            G_io_apdu_buffer + APDU_HEADER_LENGTH;

                        unsigned int bip44_path[BIP44_PATH_LEN];
                        uint32_t i;
                        for (i = 0; i < BIP44_PATH_LEN; i++) {
                            bip44_path[i] = (bip44_in[0] << 24) |
                                            (bip44_in[1] << 16) |
                                            (bip44_in[2] << 8) | (bip44_in[3]);
                            bip44_in += 4;
                        }

                        os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path,
                                                   BIP44_PATH_LEN,
                                                   privateKeyData, NULL);
                    }

                    // the seed in 48 bytes representation
                    unsigned char seed_bytes[48];
                    get_seed(privateKeyData, sizeof(privateKeyData),
                             seed_bytes);

                    unsigned char addr_bytes[48];
                    {
                        // set the security of our seed
                        const uint8_t security = 2;
                        const uint32_t idx = 0;

                        get_public_addr(seed_bytes, idx, security, addr_bytes);
                    }
                    // convert the bigint address into character address
                    char address[82];
                    bytes_to_chars(addr_bytes, address, 48);

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, address, 82);

                    tx = 82;
                    // Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
                    G_io_apdu_buffer[tx++] = 0x00;

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                    flags |= IO_ASYNCH_REPLY;


                    char addr_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4
                    // characters)
                    memcpy(&addr_abbrv[0], &address[0],
                           4);                        // first 4 chars of seed
                    memcpy(&addr_abbrv[4], "...", 3); // copy ...
                    memcpy(&addr_abbrv[7], &address[77],
                           5); // copy last 4 chars + null

                    ui_display_message(NULL, 0, 0, &addr_abbrv[0], 12, TYPE_STR,
                                       NULL, 0, 0);
                } break;


                    /* ---------------------------------------------
                     -----------------------------------------------
                     ---------------- BAD PUBLIC KEY ---------------
                     -----------------------------------------------
                     ----------------------------------------------- */
                case INS_BAD_PUBKEY: {
                    global_idx++;

                    char msg[11];
                    // 10 characters is largest uint32 num, might need to go
                    // higher  once larger indices are allowed
                    uint_to_str(global_idx, msg, 11);
                    tx = 11;


                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, msg, tx);

                    // Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
                    G_io_apdu_buffer[tx++] = 0x00;

                    // send back response
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                    flags |= IO_ASYNCH_REPLY;

                    ui_display_message(NULL, 0, 0, msg, 11, TYPE_STR, NULL, 0,
                                       0);
                } break;

                    /* ---------------------------------------------
                     -----------------------------------------------
                     --------------- GOOD PUBLIC KEY ---------------
                     -----------------------------------------------
                     ----------------------------------------------- */
                case INS_GOOD_PUBKEY: {
                    // Just use this to write to NVRAM the new seed key
                    internalStorage_t storage;
                    storage.initialized = 0x01;
                    // get the global seed key and write it as the new key
                    storage.seed_key = global_idx;

                    nvm_write(&N_storage, (void *)&storage,
                              sizeof(internalStorage_t));

                    char msg[11];
                    // 10 characters is largest uint32 num, might need to go
                    // higher  once larger indices are allowed
                    uint_to_str(global_idx, msg, 11);
                    tx = 11;

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, msg, tx);

                    // Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
                    G_io_apdu_buffer[tx++] = 0x00;

                    // send back response
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                    flags |= IO_ASYNCH_REPLY;
                    // Nothing to display, this is purely behind the scenes
                    ui_display_message(NULL, 0, 0, msg, 11, TYPE_STR, NULL, 0,
                                       0);
                } break;

                    /* ---------------------------------------------
                     -----------------------------------------------
                     -------------- CHANGE SEED INDEX --------------
                     -----------------------------------------------
                     ----------------------------------------------- */

                    // Note - Change Index does not write to NVRAM
                    // Notify good_pub_key to write (after verifying its good)
                case INS_CHANGE_INDEX: {
                    uint32_t new_index = str_to_int(msg, len);

                    tx = 11;

                    // only update global_idx if we increment
                    // don't allow reducing seed_key (vulnerability)
                    if (new_index > global_idx) {
                        global_idx = new_index;

                        // push the response onto the response buffer.
                        os_memmove(G_io_apdu_buffer, msg, tx);
                        // Manually send back success 0x9000 at end
                        G_io_apdu_buffer[tx++] = 0x90;
                        G_io_apdu_buffer[tx++] = 0x00;
                    }
                    else {
                        // don't update seed_key (exposed address)


                        // push the response onto the response buffer.
                        os_memmove(G_io_apdu_buffer, msg, tx);
                        // Manually send back failure
                        // TODO MODIFY FAILURE RETURN CODE
                        G_io_apdu_buffer[tx++] = 0x90;
                        G_io_apdu_buffer[tx++] = 0x00;
                    }


                    // send back response
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                    flags |= IO_ASYNCH_REPLY;
                    // Nothing to display, this is purely behind the scenes
                    ui_display_message(NULL, 0, 0, msg, 11, TYPE_STR, NULL, 0,
                                       0);
                } break;

                    /* ---------------------------------------------
                     -----------------------------------------------
                     ------------------- SIGN TX -------------------
                     -----------------------------------------------
                     ----------------------------------------------- */
                case INS_SIGN: {
                    // check third byte for instruction type
                    /*if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }*/

                    // if first part reset hash and all other tmp var's
                    if (hashTainted) {
                        cx_sha256_init(&hash);
                        hashTainted = 0;
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';

                    flags |= IO_ASYNCH_REPLY;
                } break;

                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                    // unknown command ??
                default:
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e)
            {
                // reset important values upon failure
                tx_mask = 0;

                input_counter = 0;

                tx_val = 0;
                tx_timestamp = 0;

                total_bal = 0;
                send_amt = 0;

                broadcast_complete = false;
                last_addr_used = false;

                ui_reset();


                switch (e & 0xF000) {
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY
            {
            }
        }
        END_TRY;
    }

return_to_dashboard:
    return;
}

bool nvram_is_init()
{
    if (N_storage.initialized != 0x01)
        return false;
    else
        return true;
}


/* ------------------------------------------------
 ---------------------------------------------------
 ---------------------------------------------------
 ------------------- Not Modified ------------------
 --------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len)
{
    switch (channel & ~(IO_FLAGS)) {
    case CHANNEL_KEYBOARD:
        break;

        // multiplexed io exchange over a SPI channel and TLV encapsulated
        // protocol
    case CHANNEL_SPI:
        if (tx_len) {
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);

            if (channel & IO_RESET_AFTER_REPLIED) {
                reset();
            }
            return 0; // nothing received from the master so far (it's a tx
            // transaction)
        }
        else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element)
{
    io_seproxyhal_display_default((bagl_element_t *)element);
}

unsigned char io_event(unsigned char channel)
{
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        }
        else {
            UX_DISPLAYED_EVENT();
        }
        break;

        // unknown events are acknowledged
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_general_status();
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

__attribute__((section(".boot"))) int main(void)
{
    // exit critical section
    __asm volatile("cpsie i");

    hashTainted = 1;

    UX_INIT();

    // ensure exception will work as planned
    os_boot();

    BEGIN_TRY
    {
        TRY
        {
            io_seproxyhal_init();

            if (N_storage.initialized != 0x01) {
                internalStorage_t storage;
                storage.initialized = 0x01;
                storage.seed_key = 0;

                nvm_write(&N_storage, (void *)&storage,
                          sizeof(internalStorage_t));
            }

            global_idx = N_storage.seed_key;

#ifdef LISTEN_BLE
            if (os_seph_features() &
                SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_BLE) {
                BLE_power(0, NULL);
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
            USB_power(1);

            IOTA_main();
        }
        CATCH_OTHER(e)
        {
        }
        FINALLY
        {
        }
    }
    END_TRY;
}
