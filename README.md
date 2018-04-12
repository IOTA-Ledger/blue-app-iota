# IOTA C Light Wallet

A big thanks to the people of the IOTA implementation of the Ledger Nano S.
They create an amazing low footprint C light wallet implementation for the Nano S.
We use this as base for the generic embedded C light wallet implementation.

## A notice to trytes:

Due to confusion of several people, a short explanation about the conversions.
The API for the conversion is available in conversion.c and conversion.h.

In this context the following words have the following meaning:

**Chars:** Means the char representation of an Tryte. (ASCII character) A - Z and 9.  (base-27 encoded ternary number)
**Bytes:** Means a byte representation of trytes, optimized for low storage and memory usage.  
**Trits:** Means a int8_t array representation of trits.   
**Trytes:** Means a int8_t array representation of trytes.

### Conversion space ratio

One transaction = 2673 trytes = ((2673/81) * 48) Bytes = 2673*3 Trits = 2673 chars


## Usage:
### Generation of addresses


```
 unsigned char address[81];
 char seedChars[] = "INSERT_SEED_HERE";
 unsigned char seedBytes[48];
 chars_to_bytes(seedChars, seedBytes, 81);
 get_public_addr(seedBytes, 0, 2, address);

 char charAddress[81];
 bytes_to_chars(address, charAddress, 48);
```

### Generation of transactions and bundles

```
char *seed = "YOURSEEDSTRING"; // 81 ternary characters
char address_one[82] = {0};
char address_two[82] = {0};
char *tag = "ANTAG"; //27 ternary characters

//Define the output array, where the coins must go to.
TX_OUTPUT output_txs[] = 
    {{.address = "ANADDRESS", .value = 10000, .message = "", .tag = ""}}; //ANADDRESS => 81 ternary characters


//Define the input array. Where the coins come from
TX_INPUT input_txs[] = {{.key_index = 4, .balance = 10000}};

//Define the transaction chars array. The char trytes will saved in this array. (base-27 encoded)
char transaction_chars[10][2673];
//Get all raw transaction trytes. Will saved in transaction_chars
prepare_transfers(seed, 2, output_txs, 1, input_txs, 1, transaction_chars);

```




