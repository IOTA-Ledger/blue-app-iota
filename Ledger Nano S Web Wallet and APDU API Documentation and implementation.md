**Note!** This is an alpha document and is still being heavily changed as discussions go on.

# Ledger Nano S Web Wallet and APDU API Documentation and implementation

## Intro

The Web Wallet will be the first part of our implementation where we will communicate with the Ledger Nano S IOTA implementation. The wallet will consist of 2 projects handled separatedly:

- Ledger JS Library (a small implementation of the API's that are used to talk to the Ledger)
    - This library will connect with the Ledger using the Ledger js library: https://github.com/LedgerHQ/ledgerjs
- Web Wallet
    - This will be an incredibly simple web-app that does:
        - Create transactions
        - Show current address (index)
        - Allow the user to switch from and to different accounts.
        - Show the user's funds
        - (possibly) help with transitions (we can't predict this, so we just keep this open)

# Why a web wallet? Why not integrate into IOTA or Trinity directly?

We totally see Ledger supporting being built into IOTA or Trinity, or having a native Ledger app in their official store. But, as this application is very much different from traditional cryptocurrencies, we opted to create our own wallet first, to make sure we have all the time and community input to iron out any rough edges. It also gives us the flexibillity to move fast and not be dependent on communication with other teams while being in development.

When the the webwallet or the js implementation of the IOTA Ledger API becomes more popular, the process of moving to official wallets will go naturally.

# Ledger Nano S

We will also implement named accounts in Ledger. It means that you can have different seeds for different purposes, i.e 'donation', will generate a complete different seed than 'banking'.

If we do a lot of transactions from a single seed, searching your current index later-on will prove difficult and slow. We also will only allow 1 address per account to have funds on them.

This may seem like harsh concessions to regular users of the IOTA wallet, but the authors feel that the advantages (eases the process of recovery) of the Ledger wallet outweigh the many disadvantages.

For more information on why we did this, see: **Known attack vectors and how to avoid them**

### Isn't a web wallet dangerous?

No, a web-wallet like myetherwallet.com is dangerous (when used without a hardware wallet), because you can get attacked by phising very easily.

But, even if someone tampers with the webwallet for IOTA on the Ledger, it'll need physical consent from the operator of the Ledger, so it'll be incredibly difficult to trick someone to steal money.

# APDU API Ledger

The Ledger should contain X functions, we will go over them 1 by 1.

Definitions:

When an API call is denoted by *Internally*, it means explicitly done inside the ledger, without sending it out to the PC

## Increase address index

Note: this should show a confirmation on the Ledger display, in the sense of:

```
Increase index by 15
 N   Account: 1   Y
```

**Parameters**

 - X [number]: amount to increase

Imagine someone having 2 Ledgers, both with the same seed. In IOTA it's crucial that you use an address only once. A Ledger doesn't have internet nor a working connection to the Tangle, so it can't know what index has been used by the other Ledger without external help.

This is what increase address index does. The web wallet receives an adress from the Ledger, and then can track it hrough the Tangle and see if the address has been used before. With increase index, the web wallet basically tells the Ledger that the address has been used and that the index needs to be increased by X.

**Important**

This should only be used when the

The Ledger should NEVER decrease the index, and should not accept a command doing so. I.e X = -1 is not accepted.

> Discussion point: We can limit the max amount of indexes for each account to a very low amount, let's say 5.
> In this case, on the last index, we will just wire the remainder to a new address under a new account. If this is the case, then the information below does not apply to this function.

Also, mathematical safety guards should be applied, to guard against integer overflows, i.e an adversary shouldn't be able to increase the index by `X` = `MAX_INT` such that current `index` + `X` overflows back to zero.

If the index does increase by `X > MAX_INT`, I suggest we should just warn the user that he used up all possible addresses, and that he should create a new Ledger recovery seed. This will probably never happen in real life. For instance, if we use a `uint32` then we've got 2<sup>32</sup>-1 possible addresses (translated in decimal to *4294967295 addresses*)

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

**Important**

Note that this function says "current" address. With current we mean: "This address is **never** used to send a transaction coming from said address."

This means that you should not increase index or disclose any furture address(es). This is crucial for the architecture. I.e calling this function multiple times will keep returning the same address over and over again, until it's been used to sign a transaction.

## Sign transaction

**Parameters**

 - accountID [int]
 - input funds in IOTA [int]
 - recipient [string]

**Procedure**

For a detailed look at how bundles are signed, see: https://github.com/iotaledger/iota.lib.js/blob/e60c728c836cb37f3d6fb8b0eff522d08b745caa/lib/api/api.js#L1344

- [*Internally*] The source address is determined by the ledger, and the ledger will create the bundle with the appropiate inputs, and outputs.
    - If there are still funds left on the source address at this point, add another transaction to the bundle, which is the remainder to the next address (increase index by 1).
    - If no funds are left, just increase the index by 1.

**Notes**

This poses an minor / low danger attack vector: a malicious wallet could trick the Ledger in reusing the same signature by sending funds to an address the wallet doesn't have. While this transaction obviously fails, the victim is now forced to get a trusted wallet to connect the Ledger to, and redo the process.

This is not such a big problem (can happen to the official IOTA Wallet too), but if we find a better solution, it should be preferred over this.

Currently, we will show the funds of the Ledger on the Ledger-screen, if the owner of the ledger sees anything strange, like a unusually large amount of IOTA, or way too low, then the owner can decide to quit signing the transaction.

# Known attack vectors and how to avoid them

IOTA is great for M2M payments, a little less for humans. The Trinity wallet is improving that a lot, and so should we.

Yet, we can't babyproof everything at once. The current consensus within the IOTA-Ledger development team is that we will make it as solid as we can, yet allow some concessions to be made to make sure we can release a safe and solid product quickly. In order to achieve this, we have set up a set of warnings to make sure people will not fall in any traps while using IOTA on the Ledger (these warnings will also appear on the Ledger screen based on user action).

When the first release has been made, the community can pick this up and as a community we can figure out how to further improve this.

Below we will fully disclose all the attack vectors we've found during development, and the solutions, so that no one will be able to abuse this.

## Faking balance by a malicious wallet

This poses an minor / low danger attack vector.

A malicious wallet could trick the Ledger in reusing the same signature by sending funds to an address the wallet doesn't have. While this transaction obviously fails, the victim is now forced to get a trusted wallet to connect the Ledger to, and redo the process.

This results in a reused signature.

**Solution**

We show the full funds that are detected by the wallet and sent to the Ledger on the Ledger-display. The user needs to have some clue about what the balance on his account is in order to make this 'warning' useful.

## Using a second Ledger could make it reuse signatures

When using 2 or more Ledgers with the same recovery seed (read: the 24 words you're asked to write down when you first boot the Ledger, not IOTA seed) you risk reusing the same address when making transactions with both of them.

**Solution**

- Make different accounts on each Ledger (i.e Ledger 1 and Ledger 2)
    - This way you can transfer funds between both accounts when nessecary but keep a separate index in sync on both Ledgers.

## Recovering a Ledger with IOTA on it

While the wallet will detect that a certain address has been used (by searching the Tangle) and in turn will request the Ledger to increase the index, this will only work if there wasn't any snapshot during the time that the first transaction from the Ledger was made and the time of recovery (it'll be unlikely that there wasn't a snapshot during that period).

**Solutions**

- Allow the user to manually view & set the index of a certain account on the Ledger or Wallet (show confirmation on the Ledger).
    - This would require the user to know or remember the index from the last transaction.
