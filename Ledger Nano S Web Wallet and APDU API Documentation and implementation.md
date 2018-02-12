**Note!** This is an alpha document and is still being heavily changed as discussions go on.

# Ledger Nano S Web Wallet and APDU API Documentation and implementation

## Intro

The Web Wallet will be the first part of our implementation where we will communicate with the Ledger Nano S IOTA implementation. The wallet will consist of 2 projects handled separatedly:

- IOTA JS Library Fork (same as the original but allows to "talk" to the ledger)
- Web Wallet
    - This will be an incredibly simple web-app that does:
        - Create transactions
        - Show current address (index)
        - Show the user's funds
        - (possibly) help with transitions (we can't predict this, so we just keep this open)

We will also implement named accounts in Ledger. It means that you can have different seeds for different purposes, i.e 'donation', will generate a complete different seed than 'banking'.

The reason for doing this, is that if we do a lot of transactions from a single seed, searching your current index later-on will prove difficult and slow. We also will only allow 1 address per account to have funds on them, to ease the process of recovery.

### Why a fork?

This is more of a mentality to work in. If we work assuming that we don't need to do PR's to get the final version working, we can conduct research faster and do prototyping more quickly.

The goal is to keep the implementation in iota.lib.js as small as possible, and as separated as possible, so that it's easy to merge back into the official version, as well as possible official IOTA Wallet(s).

This way, merging of the Ledger implementation is done naturally.

### Why start with iota.lib.js? Why not use the IOTA wallet directly?

A lot of applications have already been written with iota.lib.js. It's a ecosystem on it's own. If this works, then every application can be used with the Ledger, including MAM and Flash, which is awesome.

I don't know how this will work in practice, it could be unusable, in that case, we can just move the implementation out of the js library, should the situation call for that.

### Isn't a web wallet dangerous?

No, myetherwallet is dangerous, because you can get attacked by phising very easily. But, even if someone tampers with the webwallet for IOTA on the Ledger, it'll need physical consent from the operator of the Ledger, so it'll be incredibly difficult to trick someone to steal money.



# APDU API Ledger

The Ledger should contain X functions, we will go over them 1 by 1.

Definitions:

When an API call is denoted by *Internally*, it means explicitly done inside the ledger, without sending it out to the PC

## Increase address index
REMOVED: under discussion.
Reason: it's tricky.

## Remove account

**Parameters**

 - accountID [int]

## Add account

**Parameters**

 - accountName [string]

## List accounts

*Returns:* a list of accounts (by string and / or ID)

## Get current address

**Parameters**

 - accountID [int]

*Returns:* The current address at the current index

## Sign transaction

**Parameters**

 - accountID [int]

 - tx [object]: a transaction request, without signature
    
    The transaction request contains the following:
    
    - Input transaction

    - Output transaction(s) (this is where the funds go to)
        - This is just a list of traditional output transaction(s), containing the output address and the amount to send to that address.

**Procedure**

For a detailed look at how bundles are signed, see: https://github.com/iotaledger/iota.lib.js/blob/e60c728c836cb37f3d6fb8b0eff522d08b745caa/lib/api/api.js#L1344

- [*Internally*] if there are still funds left on the source address at this point, add another transaction to the bundle, which is the remainder to the next address (increase index by 1).
    - If no funds are left, just increase the index by 1.

**Notes**

This poses an minor / low danger attack vector: a malicious wallet could trick the Ledger in reusing the same signature by sending funds to an address the wallet doesn't have. While this transaction obviously fails, the victim is now forced to get a trusted wallet to connect the Ledger to, and redo the process.

This is not such a big problem, but if we find a better solution, it should be preferred over this.

## Recover current index

**Parameters**

 - accountID [int]
 - lastAddress [string]

**Procedure**

- [*Internally*] The ledger will keep generating addresses for `accountID` until it get's an address the same as `lastAddress`. 

**Notes**

This poses an minor / low danger attack vector: a malicious wallet could trick the Ledger in reusing the same signature by setting lastAddress into something that has been used before, and then let it make a transaction.