IOTA Application &mdash; Common Technical Specifications
===================================================

## About

The IOTA application does not preserve any states or information on application shutdown. Deterministic seed generation assures that the same private key is generated for the same input.

The IO between host and the IOTA application is [APDU](https://en.wikipedia.org/wiki/Smart_card_application_protocol_data_unit) compatible with the following general properties:
- Everything is encoded in Little-Endian without any padding or alignment.
- Strings have a fixed length but can be null-terminated if they are shorter.
- Integer numbers are either encoded as unsigned byte (1 byte), unsigned 32-bit (4 bytes) or signed 64-bit (8 bytes) using two's complement representation.
- Boolean values are encoded in one byte, with `0x00` meaning `false` and any other value meaning `true`.
- IOTA addresses are always transferred in their 81 character base-27 encoding without checksum information.

## Set the active IOTA seed &mdash; `SET-SEED`

### Description

Sets the IOTA seed to be used for all successive address and signing commands.
This command resets all transmitted transactions and seeds.

The 24 word recovery phrase and the optional passphrase of the Ledger Nano S are used according to BIP39 to derive a 512 bits (= 64 bytes) seed. The 512 bits extended private key (k, c) of the provided BIP32 path is then hashed using Kerl. As Kerl expects multiples of 48 bytes as input, the following 98 bytes are absorbed to derive the the final 243 trit IOTA seed:
`k[0:32] + c[0:16] + k[16:32] + c[0:32]`

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x01` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | Number of bytes to follow | [0, 255]
| security| byte (1) | set the used security level | [1, 3]
| length | unsigned int32 (4) | number of levels in BIP32 path | [2, 5]
| path[1] | unsigned int32 (4) | first level of BIP32 path | [0, 2<sup>32</sup>-1]
| path[2] | unsigned int32 (4) | second level of BIP32 path | [0, 2<sup>32</sup>-1]
| ... | ... | ... | ...
| path[length] | unsigned int32 (4) | last level of BIP32 path | [0, 2<sup>32</sup>-1]

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Get Public Key of active Seed &mdash; `PUBKEY`

### Description

Generates an address from the current active seed plus the provided index and returns the address.
The address uses the security level which was set in the previous `SET_SEED` call. If this command is called before a previous `SET_SEED`, the execution will fail.
The execution time of `PUBKEY` is about 2s for security level 2.

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x02` |
| P1 | byte (1) | `0x00`: return address<br/> `0x01`: return and display address |
| P2| byte (1)| ignored |
| L | byte (1) | Number of bytes to follow | [0, 255]
| idx | unsigned int32 (4) | Index of the address | [0, 2<sup>32</sup>-1]

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| address | 81 char string (81) | Base-27 encoding of public address |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Add single transaction &mdash; `TX`

### Description

Sets the next transaction of a bundle. Each transaction must only be transferred once.
If this command is called before a previous `SET_SEED`, the execution will fail.

After the last transaction of the bundle has been transferred the Ledger Nano S performs check, to assure the validity of the bundle. A bundle is valid, if all the following conditions are fulfilled:
- The bundle contains at least 2 transactions and at least 1 input transaction.
- The transactions are in the following order: output tx (at most 1), input txs (at most 2 plus meta), change tx (at most 1)
- Meta transactions have to be included and must follow their respective input transaction (similar to a finalized bundle in iota.lib.js)
- The last index is identical for all transactions and corresponds to the index of the last transaction.
- The provided indices must match the addresses.
- The index of the change transaction (if present) must be strictly greater than all the input indices.
- The addresses of all transactions must be pairwise distinct.
- The total values of all transactions sum up to 0.
- The normalized bundle hash does not contain a `M`.

After the last transaction of a valid bundle has been transferred, the bundle information is displayed on the display and the user has to accept or deny the bundle.
After a bundle has been set, the state needs to be reset in order to set a new bundle.

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x03` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | Number of bytes to follow | [0, 255]
| address | 81 char string (81) | Base-27 encoding of transaction address |
| address_idx | unsigned int32 (4) | Corresponding index of the address;<br> ignored for non-input transactions  | [0, 2<sup>32</sup>-1]
| value | signed int64 (8) | Transaction value | < 0 for input transactions<br> &ge; 0 otherwise
| obsolete_tag | 27 char string (27) | Base-27 encoding of transaction tag |
| index | unsigned int32 (4) | Index of that transaction in the bundle | [0, 7]
| last_index | unsigned int32 (4) | Last transaction index in the bundle | [1, 7]
| timestamp | unsigned int32 (4) | Timestamp | [0, 2<sup>32</sup>-1]

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| finalized | bool (1) | Whether the bundle was finalized, i.e. the last transaction has been transmitted |
| hash | 81 char string (81) | Base-27 encoding of the bundle hash; undefined if bundle was not finalized |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Sign a single transaction input &mdash; `SIGN`

### Description

Queries a single signature fragment (= 243 trytes). In order to transfer the entire signature, the command needs to be called multiple times for the same transaction index.
This command is only executable after a complete valid bundle has been transferred using `TX` and the user has accepted this bundle.

Called multiple times for the same index, to query all signature fragments. The index must only be changed after the complete signature of an input has been transmitted.

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x04` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | Number of bytes to follow | [0, 255]
| transaction_idx | unsigned int32 (4) | Index of the input transaction in the bundle;<br>**must be an input transaction** | [0, 7]

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| signature_fragment | 243 char string (243) | Base-27 encoding of the signature fragment |
| fragments_remaining | bool (1) | `true` if more fragments need to be queried |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Get app configuration

### Description

This command returns specific application configuration and can be called in any state.
The application version uses [Semantic Versioning](https://semver.org/).

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x10` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | `0x00` |

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| app_flags | byte (1) | Bit flags for supported features |
| app_version_major | byte (1) | Major version |
| app_version_minor | byte (1) | Minor version |
| app_version_patch | byte (1) | Patch version |

## Reset state &mdash; `RESET`

### Description

Called to reset the current state, e.g. reset current bundle.
Must be called after all signatures have been queried before a new bundle can be set.

This command can be used to either
- only reset the previously transferred transaction and signature fragments and keep the active IOTA seed and security level,
- or reset everything including the seed. In this case `SET-SEED` must be called again.

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0xFF` |
| P1 | byte (1) | `0x00`: reset everything<br> `0x01`: reset bundle and signatures, keep the seed |
| P2| byte (1)| ignored |
| L | byte (1) | `0x00` |

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Response codes

The following codes are returned in the case of an error:

| SW1 | SW2 | Description |
| --- | --- | ----------- |
| `0x67` | `0x00` | *Wrong Length* - the data has invalid length for this instruction |
| `0x69` | `0x82` | *Security Status not Satisfied* - the user declined the transaction, or the bundle cannot be verified |
| `0x69` | `0x84` | *Command Invalid Data* - the data is not in the format or within the ranges specified above |
| `0x69` | `0x85` | *Command Invalid State* - this command cannot be run in the current state |
| `0x69` | `0x86` | *App not Initialized* - the Ledger App has not been correctly initialized |
| `0x6B` | `0x00` | *Wrong P1-P2* - P1,P2 are invalid for that particular instruction |
| `0x6C` | `0x00` | *Incorrect Length L* - the length specified in the header does not match |
| `0x6D` | `0x00` | *Instruction not Supported* - invalid INS-code |
| `0x6E` | `0x00` | *CLA not Supported* - invalid CLA-code |
| `0x6F` | `0xXX` | *Unspecified Internal Error* |
| `0x90` | `0x00` | *Success* |
