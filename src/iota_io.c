#include "iota_io.h"
#include "api.h"
#include "macros.h"
#include "os.h"
#include "os_io_seproxyhal.h"

extern unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];

void io_initialize()
{
    os_memset(G_io_apdu_buffer, 0, IO_APDU_BUFFER_SIZE);
    api_initialize();
    io_timeout_reset();
}

void io_send(const void *ptr, unsigned int length, unsigned short sw)
{
    if (length + 2 > IO_APDU_BUFFER_SIZE) {
        THROW_PARAMETER("length");
    }

    os_memcpy(G_io_apdu_buffer, ptr, length);

    G_io_apdu_buffer[length++] = sw >> 8;
    G_io_apdu_buffer[length++] = sw >> 0;

    // just send, the response is handled in the main loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, length);
}

unsigned int iota_dispatch(const uint8_t ins, const uint8_t p1,
                           const uint8_t p2, const uint8_t len,
                           const unsigned char *input_data)
{
    UNUSED(p2);

    // check second byte for instruction
    switch (ins) {
    case INS_NONE:
        return 0;
    case INS_PUBKEY:
        return api_pubkey(p1, input_data, len);
    case INS_TX:
        return api_tx(p1, input_data, len);
    case INS_SIGN:
        return api_sign(p1, input_data, len);
    case INS_GET_APP_CONFIG:
        return api_get_app_config(p1, input_data, len);
    case INS_RESET:
        return api_reset(p1, input_data, len);
    // unknown command ??
    default:
        THROW(SW_INS_NOT_SUPPORTED);
    }
}

void io_timeout_reset()
{
    UX_CALLBACK_SET_INTERVAL(0);
}

void io_timeout_set(const unsigned int ms)
{
    if (ms == 0) {
        THROW_PARAMETER("ms");
    }
    UX_CALLBACK_SET_INTERVAL(ms);
}

void io_timeout_callback(const bool ux_allowed)
{
#ifdef TARGET_NANOS
    UNUSED(ux_allowed);
#else
    if (!ux_allowed) {
        THROW(EXCEPTION_IO_RESET);
    }
#endif
    THROW(SW_COMMAND_TIMEOUT);
}
