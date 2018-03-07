# IOTA C Light Wallet

A big thanks to the people of the IOTA implementation of the Ledger Nano S.
They create an amazing low foodprint C light wallet implementation for the Nano S.
We use this as base for the generic embedded C light wallet implementation.

Usage:
The usage is quit simple.

```
 unsigned char address[81];
 char seedChars[] = "INSERT_SEED_HERE";
 unsigned char seedBytes[48];
 chars_to_bytes(seedChars, seedBytes, 81);
 get_public_addr(seedBytes, 0, 2, address);

 char charAddress[81];
 bytes_to_chars(address, charAddress, 48);
```




