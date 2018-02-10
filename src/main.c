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
#include "vendor/iota/kerl.h"
#include "vendor/iota/conversion.h"
#include "vendor/iota/addresses.h"
#include "vendor/iota/transaction.h"

/*MEMORY IMPROVEMENTS: GLOBAL VARIABLES TO RE-USE EVERYWHERE

 #DEFINE bip44path instead of hold in variable (?)
 possibly discard public key (from bip44)

 */


cx_sha256_t hash;
unsigned char hashTainted;     // notification to restart the hash

//use internalStorage_t to temp hold the storage
typedef struct internalStorage_t {
    uint8_t initialized;
    char pub_addr[81];
    uint32_t seed_key;

} internalStorage_t;

uint32_t global_seed_key;

//N_storage_real will hold the actual address for NVRAM
WIDE internalStorage_t N_storage_real;
#define N_storage (*(WIDE internalStorage_t *)PIC(&N_storage_real))

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];
ux_state_t ux;




static void IOTA_main(void) {
    volatile unsigned int rx = 0;
    volatile unsigned int tx = 0;
    volatile unsigned int flags = 0;

    //initialize the UI
    initUImsg();



    // DESIGN NOTE: the bootloader ignores the way APDU are fetched. The only
    // goal is to retrieve APDU.
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
                tx = 0; // ensure no race in catch_other if io_exchange throws
                // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);

                //flags sets the IO to blocking, make sure to re-enable asynch
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

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {

                        //upon return G_io_apdu_buffer is null terminated (though python
                        //will still display garbage characters after the null termination)


                        /* ---------------------------------------------
                         -----------------------------------------------
                         ---------------- GET PUBLIC KEY ---------------
                         -----------------------------------------------
                         ----------------------------------------------- */
                    case INS_GET_PUBKEY: {
                        unsigned char privateKeyData[32];
                        { // Localize public key (since we discard it anyways)
                            //private key and bip44path

                            //sizeof = 76 publicKey, 40 privateKey
                            //------ TODO REMOVE -- NOT NEEDED IF ONLY DATA IS USED
                            //cx_ecfp_public_key_t publicKey;
                            //cx_ecfp_private_key_t privateKey;

                            if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                                hashTainted = 1;
                                THROW(0x6D09);
                            }

                            /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                            unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                            unsigned int bip44_path[BIP44_PATH_LEN];
                            uint32_t i;
                            for (i = 0; i < BIP44_PATH_LEN; i++) {
                                bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                                bip44_in += 4;
                            }

                            os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);

                            /* REMOVE THIS PORTION
                            cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);

                            // generate the public key. (stored in publicKey.W)
                            cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
                            cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
                        */}
                        // the seed in 48 bytes bigint representation
                        uint32_t seed_bigint[12];
                        get_seed(privateKeyData, sizeof(privateKeyData), seed_bigint);

                        uint32_t address[12] = {0};
                        {
                            // security level 1 for now, to save memory and runtime
                            const uint8_t security = 2;
                            //uint32_t private_key[12 * 27 * security];

                            //generate_private_key(seed_bigint, 24981, security, private_key);
                            get_public_addr(seed_bigint, 0, security, address);
                            //generate_public_address(private_key, security, address);
                        }
                        char key[82];
                        //change privatekey with seed_bigint
                        bigints_to_chars(address, key, 12);

                        // push the response onto the response buffer.
                        os_memmove(G_io_apdu_buffer, key, 82);

                        tx = 82;
                        //Manually send back success 0x9000 at end
                        G_io_apdu_buffer[tx++] = 0x90;
                        G_io_apdu_buffer[tx++] = 0x00;

                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                        flags |= IO_ASYNCH_REPLY;


                        char key_abbrv[12];

                        // - Convert into abbreviated seeed (first 4 and last 4 characters)
                        memcpy(&key_abbrv[0], &key[0], 4); // first 4 chars of seed
                        memcpy(&key_abbrv[4], "...", 3); // copy ...
                        memcpy(&key_abbrv[7], &key[77], 5); //copy last 4 chars + null

                        cx_sha3_t sha3;

                        unsigned int jj = sizeof(sha3);

                        ui_display_debug(&key_abbrv[0], 12, TYPE_STR, &jj, 6, TYPE_UINT);
                    } break;


                        /* ---------------------------------------------
                         -----------------------------------------------
                         ---------------- BAD PUBLIC KEY ---------------
                         -----------------------------------------------
                         ----------------------------------------------- */
                    case INS_BAD_PUBKEY: {
                        global_seed_key++;

                        char msg[11];
                        //10 characters is largest uint32 num, might need to go higher
                        //once larger indices are allowed
                        uint_to_str(global_seed_key, &msg[0], 11);
                        tx = 11;


                        // push the response onto the response buffer.
                        os_memmove(G_io_apdu_buffer, msg, tx);

                        //Manually send back success 0x9000 at end
                        G_io_apdu_buffer[tx++] = 0x90;
                        G_io_apdu_buffer[tx++] = 0x00;

                        //send back response
                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                        flags |= IO_ASYNCH_REPLY;

                        ui_display_debug(&msg[0], 11, TYPE_STR, NULL, 0, 0);
                    } break;

                        /* ---------------------------------------------
                         -----------------------------------------------
                         --------------- GOOD PUBLIC KEY ---------------
                         -----------------------------------------------
                         ----------------------------------------------- */
                    case INS_GOOD_PUBKEY: {
                        //Just use this to write to NVRAM the new seed key
                        internalStorage_t storage;
                        storage.initialized = 0x01;
                        //get the global seed key and write it as the new key
                        storage.seed_key = global_seed_key;

                        nvm_write(&N_storage, (void *)&storage,
                                  sizeof(internalStorage_t));

                        char msg[11];
                        //10 characters is largest uint32 num, might need to go higher
                        //once larger indices are allowed
                        uint_to_str(global_seed_key, &msg[0], 11);
                        tx = 11;

                        // push the response onto the response buffer.
                        os_memmove(G_io_apdu_buffer, msg, tx);

                        //Manually send back success 0x9000 at end
                        G_io_apdu_buffer[tx++] = 0x90;
                        G_io_apdu_buffer[tx++] = 0x00;

                        //send back response
                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                        flags |= IO_ASYNCH_REPLY;
                        //Nothing to display, this is purely behind the scenes
                        ui_display_debug(&msg[0], 11, TYPE_STR, NULL, 0, 0);
                    } break;

                        /* ---------------------------------------------
                         -----------------------------------------------
                         -------------- CHANGE SEED INDEX --------------
                         -----------------------------------------------
                         ----------------------------------------------- */

                        // Note - Change Index does not write to NVRAM
                        // Notify good_pub_key to write (after verifying its good)
                    case INS_CHANGE_INDEX: {
                        //largest uint32 is 10 characters long
                        //might need more if if we support larger than uint32
                        char msg[11];
                        memcpy(&msg[0], &G_io_apdu_buffer[5], 10);

                        uint32_t new_index = str_to_int(&msg[0], 10);

                        tx = 11;

                        //only update global_seed_key if we increment
                        //don't allow reducing seed_key (vulnerability)
                        if(new_index > global_seed_key) {
                            global_seed_key = new_index;

                            // push the response onto the response buffer.
                            os_memmove(G_io_apdu_buffer, msg, tx);
                            //Manually send back success 0x9000 at end
                            G_io_apdu_buffer[tx++] = 0x90;
                            G_io_apdu_buffer[tx++] = 0x00;
                        }
                        else {
                            //don't update seed_key (exposed address)


                            // push the response onto the response buffer.
                            os_memmove(G_io_apdu_buffer, msg, tx);
                            //Manually send back failure
                            //TODO MODIFY FAILURE RETURN CODE
                            G_io_apdu_buffer[tx++] = 0x90;
                            G_io_apdu_buffer[tx++] = 0x00;
                        }


                        //send back response
                        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);

                        flags |= IO_ASYNCH_REPLY;
                        //Nothing to display, this is purely behind the scenes
                        ui_display_debug(&new_index, 11, TYPE_INT, NULL, 0, 0);
                    } break;

                        /* ---------------------------------------------
                         -----------------------------------------------
                         ------------------- SIGN TX -------------------
                         -----------------------------------------------
                         ----------------------------------------------- */
                    case INS_SIGN: {
                        //check third byte for instruction type
                        if ((G_io_apdu_buffer[2] != P1_MORE) &&
                            (G_io_apdu_buffer[2] != P1_LAST)) {
                            THROW(0x6A86);
                        }

                        //if first part reset hash and all other tmp var's
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

                        //unknown command ??
                    default:
                        hashTainted = 1;
                        THROW(0x6D00);
                        break;
                }
            }
            CATCH_OTHER(e) {
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
            FINALLY {
            }
        }
        END_TRY;
    }

return_to_dashboard:
    return;
}

bool nvram_is_init() {
    if(N_storage.initialized != 0x01) return false;
    else return true;
}


/* ------------------------------------------------
 ---------------------------------------------------
 ---------------------------------------------------
 ------------------- Not Modified ------------------
 --------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
    switch (channel & ~(IO_FLAGS)) {
        case CHANNEL_KEYBOARD:
            break;

            // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
        case CHANNEL_SPI:
            if (tx_len) {
                io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);

                if (channel & IO_RESET_AFTER_REPLIED) {
                    reset();
                }
                return 0; // nothing received from the master so far (it's a tx
                // transaction)
            } else {
                return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                              sizeof(G_io_apdu_buffer), 0);
            }

        default:
            THROW(INVALID_PARAMETER);
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
}

unsigned char io_event(unsigned char channel) {
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
            } else {
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

__attribute__((section(".boot"))) int main(void) {
    // exit critical section
    __asm volatile("cpsie i");

    hashTainted = 1;

    UX_INIT();

    // ensure exception will work as planned
    os_boot();

    BEGIN_TRY {
        TRY {
            io_seproxyhal_init();

            if (N_storage.initialized != 0x01) {
                internalStorage_t storage;
                storage.initialized = 0x01;
                storage.seed_key = 0;

                nvm_write(&N_storage, (void *)&storage,
                          sizeof(internalStorage_t));
            }

            global_seed_key = N_storage.seed_key;

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

            ui_idle();

            IOTA_main();
        }
        CATCH_OTHER(e) {
        }
        FINALLY {
        }
    }
    END_TRY;
}
