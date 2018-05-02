# Ledger Nano S Documentation

***If you are already familiar with IOTA and want Ledger Nano specific information, jump to [How Ledger Nano S Works](#How-Ledger-Nano-S-Works) for generic information, or jump to [IOTA Specific Considerations on the Ledger Nano S](#IOTA-Specific-Considerations-on-the-Ledger-Nano-S) for IOTA specific information on the Ledger Nano S.***

***It is strongly recommended to take a few minutes to read this document to make sure you fully understand how IOTA and the Ledger Nano S work, and how they interact together.***

If you have lost your Ledger Nano S and need to recover the seed, a recovery tool can be found here: https://github.com/IOTA-Ledger/recover-iota-seed-from-ledger-mnemonics.

**Only use this tool in emergencies**, as exposing your seed defeats the primary purpose of the Ledger Nano S.

---

IOTA is a unique cryptocurrency in that it has specific design considerations that must be taken into account. This document will attempt to go over how the Ledger Nano S functions, and how to stay safe when using the Ledger Nano S for IOTA.

### Terminology

*Seed:* An IOTA seed is equivalent to the password for your "IOTA account". It can store a *near infinite* number of addresses.

*Private Key:* The private key is used to generate a public key. It is also used to prove you own said public key by means of creating a signature for a specific transaction.

*Public Key:* Also known as public address or just address. The public key is the key you would give to somebody else to transfer you funds.

*Change Tx:* After sending funds to a 3rd party, all remaining funds on the account must be transferred to a new address - this is called the change tx (or the change address).

*Account:* The IOTA app stores indexes for 5 seeds, these can be used as unique accounts. For example one could be a primary or general purpose account, and another could be a donations account.

### Address Reuse

IOTA uses a type of quantum resistance called the Winternitz One-Time Signature Scheme. This means that addresses **must not** be reused. This is because you reveal part of the private key with each transaction. As such, **reusing a spent address** can allow attackers to forge fake transactions and steal your balance.

Keep in mind you can **receive** an infinite number of transactions, but as soon as you **send** from the address, you must **NEVER** use that address again.

This is handled in IOTA by utilizing what is called a seed index. Each index in the seed generates a unique address. When creating an IOTA transaction, it uses what's called an *atomic bundle*. This is just a fancy term that means either the entire bundle is accepted, or none of it is.

### IOTA Bundle

A bundle is just a group of transactions and IOTA uses both input and output transactions. So if Bob has 10 iota, and wants to send Alice 3 iota, the bundle could look like this:

**tx1:** Bob -10 iota
**tx2:** Alice +3 iota
**tx3:** Bob +7 iota (change tx)

This example highlights how IOTA handles one time signatures. First it takes an input of 10 iota from Bob's address. It sends 3 of it to Alice, and it puts the remaining 7 iota on a new address belonging to Bob's seed.

All input transactions require the private key to generate a signature which proves that you are the owner of the funds.

Because bundles are *atomic units*, the network will never accept Bob's input tx of -10 iota without also accepting sending 3 to Alice, and 7 to a new address owned by Bob (in this example).

### Parts of an IOTA Transaction

An IOTA transaction is broken up into 2 halves. The first half is generating a transaction bundle, and creating signatures for it.

The second half is selecting 2 other transactions to confirm, and performing the proof of work.

The Ledger Nano S is **only** responsible for generating signatures for a specific transaction. After that the host machine (or anybody else for that matter), can take the signatures and broadcast it to the network (however the signatures are only valid for the specific transaction bundle).

**Promoting an unconfirmed transaction does not require re-signing on the Ledger.**

## How Ledger Nano S Works

The Ledger Nano S is a hardware wallet which deterministically generates an IOTA seed based on your 24 word mnemonic (created when setting up the Ledger Nano S).

Instead of storing the seed on your computer (which could be stolen by an attacker), the seed is stored on the Ledger Nano S, and is never broadcast to the host machine it is connected to.

Instead, the host machine must ask the Ledger to provide the information (such as public keys or signatures). When creating transactions the host will generate the necessary information for the transaction bundle, and then will send it to the Ledger Nano S to be signed. The Ledger will then use the private keys associated with the input transactions to generate unique signatures, and will then transfer **only the signatures** back to the host machine.

The host can then use these signatures (which are only valid for that specific transaction bundle) to broadcast the transaction to the network. However as you can see, neither the IOTA seed, nor any of the private keys ever leave the device. 

*However keep in mind that in IOTA the signature contains **some** information about the private key for one specific address.*

## IOTA Specific Considerations on the  Ledger Nano S

### IOTA User-Facing App Functions

#### Functions

- *Display Address:* The wallet can ask the Ledger to display the address for a specific index on the seed. It **only** accepts the index, and subsequently generates the address itself and thus verifies that the address belongs to the Ledger.

*Note: this does not pertain to displaying addresses in transactions. Transactions will be denoted as "output", "input", or "change" transactions. Input and Change are verified to belong to the Ledger. Output are not.*

- *Initialize Ledger Indexes:* The wallet will provide new indexes to write to the Ledger Nano S. **THIS IS A CRITICAL OPERATION.** If you approve inaccurate/bad indexes from the wallet you could generate bad transactions and lose funds.

If this happens you should use the wallet to reinitialize the seed from scratch. This could potentially take a long time as the Ledger hardware is slow at generating addresses (compared to a computer).

- *Sign Transaction:* The wallet will generate a transaction for the user to approve before the Ledger signs it. Ensure all amounts and addresses are correct before signing. These signatures are then sent back to the host machine.

#### Display

- The sides of the display will have an up or down arrow indicating that you can scroll to a new screen.

- Two bars along the top (just below the buttons) indicates that there is a double press function available (generally confirm/toggle). We will be working to ensure this function is always intuitive.


### IOTA Security Concerns on Ledger Nano S

All warnings on the Ledger are there for a reason, **MAKE SURE TO READ THEM** and refer to this document if there is any confusion.

- **Do not use multiple Ledgers with the IOTA app.**

Because the IOTA app is stateful (stores the seed-indexes), using multiple Ledgers with the IOTA app will make it impossible for the Ledger to properly keep track of indexes.

In the future it may be possible to use multiple Ledgers if the wallet is made solely responsible for the statefulness, however for now it is strongly recommended to use just one Ledger for IOTA.

**This also means that if you must remove an existing app to make room for a new one, you should NOT remove IOTA without first backing up it's indexes to the wallet.**

- **Ensure the change index is always increasing.**

The Ledger generates 5 unique IOTA seeds based on the 24 word mnemonic, and tracks the index for each seed. Because the index is stored on the device, you can quickly transfer to a new wallet and initialize your seed faster than scanning every index to find the one that holds your funds.

Whenever you sign a transaction with the Ledger it will write whatever the seed-index of the change transaction is into memory on the Ledger.

As such it is *strongly recommended* to never use a change index that is lower than an address that has already been used, as this can inadvertently cause address reuse.

If a Ledger has a seed-index of 10 in memory, and a new transaction uses the change index of any value lower than 10, it will warn the user and ask "Are you sure?".

- **Don't rush through signing a transaction.**

When generating a transaction for the Ledger to sign, you will scroll through each transaction before signing off on the bundle. The transaction information will come up in order (while scrolling from left to right). The first screen will display the tx type (output, input, or change), as well as the amount. The next screen will display the corresponding address for said transaction. This will repeat until all transactions have been displayed, then you can select "Approve" or "Deny".

- All output transactions to 3rd party addresses will say "Output:" and below that "1.56 Mi" (for example). "Output" being the key word here.

All input transactions will say "Input:", and the final output transaction (the change transaction) will say "Change: [4]" ([4] being the seed-index of the change tx). This means the Ledger has verified the address used for the change tx belongs to the Ledger.

**If you are not sending all of your funds off of the seed, MAKE SURE one of the tx says "Change".**

*Note: When transferring between IOTA Ledger accounts (from one account seed to another) the ledger will not display it as a "Change tx". The wallet should first display the address that it intends to send it to on the Ledger (thus verifying it still belongs to the Ledger), and then create the transaction. The user would then verify in the transaction that the "Output:" tx is in fact going to the address previously displayed on the Ledger.*

- **Verify ALL information in a transaction and NEVER re-sign a transaction.**

For other coins you only need to verify the destination address and amount, but for IOTA you must also verify all input transactions. If you sign a transaction on the Ledger but the transaction is not using all of the funds on a specific address, leftover funds on the address are then vulnerable.

As such make sure the input amount(s) are what you expect them to be, make sure the output destination and amount is what you intend to send, and make sure there is a change tx if applicable with all of your remaining funds.

*Note: After signing a transaction, you should verify the transaction was successfully broadcast to the network. You should **NEVER** re-sign the same transaction on the Ledger. If the transaction does not get confirmed, you should promote the transaction **on the host machine**. This avoids generating a new signature and weakening the security of the addresses.*

- If the transaction was not broadcast to the network, and you can't find it in the wallet you should be **EXTREMELY CAUTIOUS** before proceeding to sign a new transaction. If an infected machine is silently storing the signatures without broadcasting them, it could steal your funds after re-signing.

If this situation should arise you should consider going to a more trusted machine before re-signing a transaction.
