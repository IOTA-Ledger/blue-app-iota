#ifndef IOTA_IO_H
#define IOTA_IO_H

#include <stdbool.h>
#include <stdint.h>

#define BIP32_PATH_MIN_LEN 2
#define BIP32_PATH_MAX_LEN 5

void io_initialize(void);
void io_send(const void *ptr, unsigned int length, unsigned short sw);

unsigned int iota_dispatch(uint8_t ins, uint8_t p1, uint8_t p2, uint8_t len,
                           const unsigned char *input_data);

/// Sets the IO timeout to the given ms.
void io_timeout_set(unsigned int ms);
/// Resets and stops the IO timeout.
void io_timeout_reset(void);
// Callback to be called on timeout.
void io_timeout_callback(bool ux_allowed);

/* ---  CLA  --- */

#define CLA 0x7A

/* ---  INS  --- */

#define INS_NONE 0x00
#define INS_SET_SEED 0x01 // *LEGACY
#define INS_PUBKEY 0x02
#define INS_TX 0x03
#define INS_SIGN 0x04

#define INS_GET_APP_CONFIG 0x10

#define INS_RESET 0xFF

/* ---  P1  --- */

#define P1_PUBKEY_NO_DISPLAY 0x00
#define P1_PUBKEY_DISPLAY 0x01

#define P1_FIRST 0x00
#define P1_MORE 0x80

/* ---  SW return codes  --- */

#define SW_OK 0x9000 ///< success

// invalid data

#define SW_INCORRECT_LENGTH 0x6700     ///< received length invalid for command
#define SW_COMMAND_INVALID_DATA 0x6a80 ///< invalid command data
#define SW_INCORRECT_P1P2 0x6b00       ///< invalid parameter
#define SW_INCORRECT_LENGTH_P3 0x6c00  ///< received length does not match P3
#define SW_INS_NOT_SUPPORTED 0x6d00    ///< invalid INS code
#define SW_CLA_NOT_SUPPORTED 0x6e00    ///< invalid CLA code

// command not allowed or invalid

#define SW_COMMAND_NOT_ALLOWED 0x6900             ///< invalid state for command
#define SW_SECURITY_STATUS_NOT_SATISFIED 0x6982   ///< dongle locked
#define SW_CONDITIONS_OF_USE_NOT_SATISFIED 0x6985 ///< denied by user
#define SW_INVALID_BUNDLE 0x69a0 /* +retcode */   ///< invalid bundle received

// command aborted

#define SW_COMMAND_TIMEOUT 0x6401 ///< next command or user input timeout
#define SW_UNKNOWN 0x6f00         ///< command aborted

// aliases

#define SW_DENIED_BY_USER SW_CONDITIONS_OF_USE_NOT_SATISFIED
#define SW_DEVICE_IS_LOCKED SW_SECURITY_STATUS_NOT_SATISFIED

/* ---  Legacy errorcodes  --- */

// SW_COMMAND_INVALID_DATA 0x6984
// SW_APP_NOT_INITIALIZED 0x6986
// SW_TX_INVALID_INDEX 0x6991
// SW_TX_INVALID_ORDER 0x6992
// SW_TX_INVALID_META 0x6993
// SW_TX_INVALID_OUTPUT 0x6994

#endif // IOTA_IO_H
