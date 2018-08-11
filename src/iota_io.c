#include "iota_io.h"
#include "common.h"
#include "api.h"

extern unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];

void io_initialize()
{
    os_memset(G_io_apdu_buffer, 0, IO_APDU_BUFFER_SIZE);
    api_initialize();
}

void io_send(const void *ptr, unsigned int length, unsigned short sw)
{
    if (length + 2 > IO_APDU_BUFFER_SIZE) {
        THROW(INVALID_PARAMETER);
    }

    os_memcpy(G_io_apdu_buffer, ptr, length);

    G_io_apdu_buffer[length++] = sw >> 8;
    G_io_apdu_buffer[length++] = sw >> 0;

    // just send, the response is handled in the main loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, length);
}

unsigned int iota_dispatch()
{
    // if it does not start with the magic byte, return error
    if (G_io_apdu_buffer[OFFSET_CLA] != CLA) {
        THROW(SW_CLA_NOT_SUPPORTED);
        return 0;
    }

    const uint8_t p1 = G_io_apdu_buffer[OFFSET_P1];
    const uint8_t len = G_io_apdu_buffer[OFFSET_P3];
    unsigned char *input_data = G_io_apdu_buffer + OFFSET_CDATA;

    // check second byte for instruction
    switch (G_io_apdu_buffer[OFFSET_INS]) {

    case INS_SET_SEED:
        return api_set_seed(input_data, len);

    case INS_PUBKEY:
        return api_pubkey(p1, input_data, len);

    case INS_TX:
        return api_tx(input_data, len);

    case INS_SIGN:
        return api_sign(input_data, len);

    case INS_GET_APP_CONFIG:
        return api_get_app_config(input_data, len);

    // unknown command ??
    default:
        THROW(SW_INS_NOT_SUPPORTED);
        return 0;
    }
}
