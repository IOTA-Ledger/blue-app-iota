# APDU Ledger API

* Everything is encoded in Little-Endian without any padding or alignment.
* Strings have a fixed length but can be null-terminated if they are shorter.
* All integer numbers are always encoded in 8 bytes using two's complement representation.
* Boolean values are encoded in one byte, with `0x00` meaning `false` and any other value meaning `true`.
* IOTA addresses are always transferred in their 81 character base-27 encoding without checksum information.

## Set the active IOTA seed

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x01` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | Number of bytes to follow | $[0,255]$
| path[0] | signed int64 (8) | Level 0 of path |
| path[1] | signed int64 (8) | Level 1 of path |
| path[2] | signed int64 (8) | Level 2 of path |
| path[3] | signed int64 (8) | Level 3 of path |
| path[4] | signed int64 (8) | Level 4 of path |
| security| signed int64 (8) | set the used security level | $[1,3]$

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Get Public Key of active Seed

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x02` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | Number of bytes to follow | $[0,255]$
| idx | signed int64 (8) | Index of the address | $[0, 2^{32}-1]$

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| address | 81 char string (81) | Base-27 encoding of public address |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Add single transaction

The transactions must form a valid bundle:
1. The bundle contains at least 2 transactions and at least 1 input transaction. Currently, the maximum number of transactions is limited to 8.
3. Meta transactions have to be included (similar to a finalized bundle in iota.lib.js)
4. The last index is identical for all transactions and corresponds to the index of the last transaction.
5. The total values of all transactions sum up to $0$.
6. The normalized bundle hash does not contain a `M`.

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x03` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | Number of bytes to follow | $[0,255]$
| address | 81 char string (81) | Base-27 encoding of transaction address |
| address_idx | signed int64 (8) | Corresponding index of the address; ignored for non-input transactions  | $[0, 2^{32}-1]$
| value | signed int64 (8) | Transaction value | $<0$ for input transactions<br> $\geq 0$ otherwise
| obsolete_tag | 27 char string (27) | Base-27 encoding of transaction tag |
| index | signed int64 (8) | Index of that transaction in the bundle | $[0, 9]$
| last_index | signed int64 (8) | Last transaction index in the bundle | $[2, 9]$
| timestamp | signed int64 (8) | Timestamp |  $[0, 2^{32}-1]$

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| finalized | bool (1) | Whether the bundle was finalized, i.e. the last transaction has been transmitted |
| hash | 81 char string (81) | Base-27 encoding of the bundle hash; undefined if bundle was not finalized |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Sign a single transaction input

Called multiple times for the same index, to query all signature fragments.

### Input

| Field | Type | Content | Range |
| ----- | ---- | ------- | ----- |
| CLA | byte (1) | Always `0x7A` |
| INS | byte (1) | `0x04` |
| P1-P2| byte (2)| ignored |
| L | byte (1) | Number of bytes to follow | $[0,255]$
| transaction_idx | signed int64 (8) | Index of the input transaction in the bundle; **must be an input transaction** | $[0, 9]$

### Output

| Field | Type | Content |
| ----- | ----- | ------- |
| signature_fragment | 243 char string (243) | Base-27 encoding of the signature fragment |
| fragments_remaining | bool (1) | `true` if more fragments need to be queried |
| SW1-SW2 | byte (2) | `0x9000` for success |

## Response codes

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
| `0x6F` | `XX` | *Unspecified Internal Error* |
| `0x90` | `0x00` | *Success* |
