# IOTA App for Ledger Hardware Wallets

[![Build Status](https://travis-ci.org/IOTA-Ledger/blue-app-iota.svg?branch=master)](https://travis-ci.org/IOTA-Ledger/blue-app-iota)
[![codecov](https://codecov.io/gh/IOTA-Ledger/blue-app-iota/branch/master/graph/badge.svg)](https://codecov.io/gh/IOTA-Ledger/blue-app-iota)

***It is strongly recommended to take a few minutes to read this document to make sure you fully understand how IOTA and the Ledger Hardware Wallet works, and how they interact together.***

## Table of contents

- [IOTA App for Ledger Hardware Wallets](#iota-app-for-ledger-hardware-wallets)
  * [Introduction](#introduction)
    + [Terminology](#terminology)
    + [Address Reuse](#address-reuse)
    + [IOTA Bundle](#iota-bundle)
    + [Parts of an IOTA Transaction](#parts-of-an-iota-transaction)
  * [How Ledger Hardware Wallets Work](#how-ledger-hardware-wallets-work)
  * [IOTA Specific Considerations for Ledger Hardware Wallets](#iota-specific-considerations-for-ledger-hardware-wallets)
    + [IOTA User-Facing App Functions](#iota-user-facing-app-functions)
      - [Functions](#functions)
      - [Display](#display)
    + [Recovery Phrase Entropy](#recovery-phrase-entropy)
    + [IOTA Security Concerns Relating to Ledger Hardware Wallets](#iota-security-concerns-relating-to-ledger-hardware-wallets)
    + [Limitations of Ledger Hardware Wallets](#limitations-of-ledger-hardware-wallets)
  * [FAQ](#faq)
      - [I lost my ledger, what should I do now?](#i-lost-my-ledger--what-should-i-do-now-)
  * [Development](#development)
    + [Load the IOTA Ledger app using Docker](#load-the-iota-ledger-app-using-docker)
    + [Preparing development environment](#preparing-development-environment)
    + [Compile and load the IOTA Ledger app](#compile-and-load-the-iota-ledger-app)
  * [Specification](#specification)
  * [Contributing](#contributing)
    + [Donations](#donations)
    + [As a developer](#as-a-developer)

---

## Introduction

IOTA is a unique cryptocurrency with specific design considerations that must be taken into account. This document will attempt to go over how the Ledger hardware wallet functions, and how to stay safe when using a Ledger to store IOTA.

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

The Ledger is **only** responsible for generating signatures for a specific transaction. After that the host machine (or anybody else for that matter), can take the signatures and broadcast it to the network (however the signatures are only valid for the specific transaction bundle).

**Promoting an unconfirmed transaction does not require re-signing on the Ledger.**

## How Ledger Hardware Wallets Work

The Ledger Hardware Wallet works by deterministically generating an IOTA seed based on your 24 word mnemonic (created when setting up the device).

Instead of storing the seed on your computer (which could be stolen by an attacker), the seed is stored on the Ledger device, and is never broadcast to the host machine it is connected to.

Instead, the host machine must ask the Ledger to provide the information (such as public keys or signatures). When creating transactions the host will generate the necessary information for the transaction bundle, and then will send it to the Ledger device to be signed. The Ledger will then use the private keys associated with the input transactions to generate unique signatures, and will then transfer **only the signatures** back to the host machine.

The host can then use these signatures (which are only valid for that specific transaction bundle) to broadcast the transaction to the network. However as you can see, neither the IOTA seed, nor any of the private keys ever leave the device.

*However keep in mind that in IOTA the signature contains **some** information about the private key for one specific address.*

See [Ledger's documentation](http://ledger.readthedocs.io) to get more info about the inner workings of the Ledger Hardware Wallets.

## IOTA Specific Considerations for Ledger Hardware Wallets

### IOTA User-Facing App Functions

#### Functions

- *Display Address:* The wallet can ask the Ledger to display the address for a specific index on the seed. It **only** accepts the index, and subsequently generates the address itself and thus verifies that the address belongs to the Ledger.

    *Note: this does not pertain to displaying addresses in transactions. Transactions will be denoted as "output", "input", or "change" transactions. Input and Change are verified to belong to the Ledger. Output are not.*

- *Sign Transaction:* The wallet will generate a transaction for the user to approve before the Ledger signs it. **Ensure all amounts and addresses are correct before signing**. These signatures are then sent back to the host machine.

#### Display

For the Ledger Nano S:
- The sides of the display will have an up or down arrow indicating that you can scroll to a new screen.

- Two bars along the top (just below the buttons) indicates that there is a double press function available (generally confirm/toggle or back). We will be working to ensure this function is always intuitive.

For the Ledger Nano X:
- Behavior is the same as the Nano S. Graphically there are no confirmation bars along the top (but double pressing the buttons still confirms/toggles).

For the Ledger Blue:
- The Ledger Blue uses a touchscreen, thus all you need to do is tap the buttons on the screen.

### Recovery Phrase Entropy

- The 24 word BIP39 recovery phrase (mnemonic) of the hardware wallet represents less information (256 bits of entropy) than a 27 tryte IOTA seed (384 bits of entropy).
- An additional function is used to convert this mnemonic seed and the optional passphrase (not your pin number) of your choosing into a 512 bit binary seed. This happens according to the BIP39 standard on the Ledger using system calls.
- The extended child key (512 bits) of a corresponding BIP32 path is then hashed (using Kerl) to derive the final 243 trit seed for IOTA.

While having (only) 256 bits of entropy does not pose a security problem, it does not support the full potential of the IOTA seed. Thus, to use the full entropy supported by IOTA, an additional sufficiently long passphrase is needed! On the other hand, there are other factors that might have a higher security impact, like choosing proper random mnemonics (the Ledger uses a TRNG for that matter) or selecting a higher security level.

### IOTA Security Concerns Relating to Ledger Hardware Wallets

All warnings on the Ledger are there for a reason, **MAKE SURE TO READ THEM** and refer to this document if there is any confusion.

- **Don't rush through signing a transaction.**

    When generating a transaction for the Ledger to sign, you will scroll through each transaction before signing off on the bundle. The transaction information will come up in order (while scrolling from left to right). 
    
    On the Ledger Nano S/X, the first screen will display the tx type (output, input, or change), as well as the amount. The next screen will display the corresponding address for said transaction. This will repeat until all transactions have been displayed, then you can select "Approve" or "Deny".
    
    On the Ledger Blue each transaction entry in a bundle will fit on the screen, use the next button until you've confirmed all transactions and then select approve if everything is correct.

    - All output transactions to 3rd party addresses will say "Output:" and below that "1.56 Mi" (for example). "Output" being the key word here.

        All input transactions will say "Input: [0]", and the final output transaction (the change transaction) will say "Change: [4]" ([4] being the seed-index of the change tx). This means the Ledger has verified the addresses used for inputs as well as the change tx all belong to the Ledger.

        If the input amount perfectly matches the output amount, there will be no change transaction. **If there is no change transaction, double check that you are sending the proper amount to the proper address because there is no remainder being sent back to your seed.**

        *Note: When transferring from one seed (controlled by the Ledger device) to another seed (also controlled by the Ledger device) it will not display a "Change tx". As such the wallet should first display the address on the new seed that it intends to send it to on the Ledger (thus verifying it belongs to the Ledger), and then create the transaction. The user would then verify in the transaction that the "Output:" tx is in fact going to the address previously displayed on the Ledger.*

- **Verify ALL information in a transaction and NEVER re-sign a transaction.**

    For other coins you only need to verify the destination address and amount, but for IOTA you must also verify all input transactions. If you sign a transaction on the Ledger but the transaction is not using all of the funds on a specific address, leftover funds on the address are then vulnerable.

    As such make sure the input amount(s) are what you expect them to be, make sure the output destination and amount is what you intend to send, and make sure there is a change tx if applicable with all of your remaining funds.

    *Note: After signing a transaction, you should verify the transaction was successfully broadcast to the network. You should **NEVER** re-sign the same transaction on the Ledger. If the transaction does not get confirmed, you should promote the transaction **on the host machine**. This avoids generating a new signature and weakening the security of the addresses.*

    - If the transaction was not broadcast to the network, and you can't find it in the wallet you should be **EXTREMELY CAUTIOUS** before proceeding to sign a new transaction. If an infected machine is silently storing the signatures without broadcasting them, it could steal your funds after re-signing.

        If this situation should arise you should consider going to a more trusted machine before re-signing a transaction.

### Limitations of Ledger Hardware Wallets

Due to the memory limitations of the Ledger Nano S/X and the Ledger Blue, the transaction bundles have certain restrictions. The Ledger Nano S/X can only accept a transaction with a maximum bundle size of 10 and the Ledger Blue is limited to a maximum bundle size of 20.

An output and a change transaction each only require 1 bundle entry, however every input transaction requires the same number of bundle entries as the security level being used on the seed. Thus if using a Ledger Nano S or X you could have 1 output + 4 inputs (security level 2) + 1 change transaction and this would take up all 10 bundle entries. For security level 3 you could only have 1 output + 2 inputs + 1 change transaction, or 1 output + 3 inputs without a change transaction.

*Security level 2 is the default security level.*

## FAQ

#### I lost my ledger, what should I do now?

Hopefully you wrote down your 24 recovery words and your optional passphrase in a safe place. If not, all your funds are lost.

If you did, the best solution is to buy a new Ledger and enter your 24 recovery words and your optional passphrase in the new device.<br>
After installation of the IOTA Ledger app, all your funds are restored. Take care to reinitialize your seed index correctly.

Another approach is to use our seed recovery tool which can be found here: https://github.com/IOTA-Ledger/recover-iota-seed-from-ledger-mnemonics.<br>
**WARNING: Only use this tool in emergencies**, as exposing your seed defeats the primary purpose of using a hardware wallet.

## Development

### Load the IOTA Ledger app using Docker

The easist way to load the app without needing to download and prepare a development environment uses Docker:

- Clone this repo
- Ensure that all git submodules are initialized
    ```
    git submodule update --init --recursive
    ```
- Build the Docker image based on the current version for the Nano S
    ```
    docker build --build-arg DEVICE=nanos -t iota-ledger/nanos .
    ```
    or the Blue
    ```
    docker build --build-arg DEVICE=blue -t iota-ledger/blue .
    ```
- Connect your Ledger to the PC and unlock it
- Load the app
    ```
    docker run --rm --privileged -v /dev/bus/usb:/dev/bus/usb iota-ledger/nanos
    ```
- Accept all the messages on the Ledger

### Preparing development environment

For active development it might be easier to install the development environment locally instead of using Docker:

- Clone this repo
- Ensure that all git submodules are initialized
    ```
    git submodule update --init --recursive
    ```
- Set up your development environment according to [Ledger Documentation - Getting Started](https://ledger.readthedocs.io/en/latest/userspace/getting_started.html).

### Compile and load the IOTA Ledger app

After the development environment has been installed, the app can be build and installed in the following way:

- Connect your Ledger to the PC and unlock it
- To load the app, be sure that the dashboard is opened in the Ledger
- Run the following commands to compile the app from source and load it
    ```
    make load
    ```
- Accept all the messages on the Ledger
- You can now test the IOTA Ledger app by using one of the examples in [ledger-app-iota-demos](https://github.com/IOTA-Ledger/ledger-app-iota-demos)

## Specification

See: [APDU API Specification](/docs/specification.md)

## Contributing

### Donations
This is a community project, done in our spare time for the betterment of the IOTA ecosystem and community.
Donating is not required, but is greatly appreciated. If you would like to donate please send some IOTA to the following address:
```
TLCZOGKIARUQRBSJYSUTXVQYKPTOYOMQAUWUGBOCJJFQSXELFPEDF9LKDCUVKYDVGCJTCRANLOZJJKKNBEKVDHCJ9B
```
![IOTA Ledger Donation](resources/ledger_donation.png)

Please know that the donations made to this address will be shared with everyone who meaningfully contributes to the project.

Thanks!

### As a developer
Would you like to contribute as a dev? Please check out our [Discord channel](https://discord.gg/U3qRjZj) to contact us!
