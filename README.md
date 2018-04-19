# IOTA App for Ledger Blue & Ledger Nano S

[![Build Status](https://travis-ci.org/IOTA-Ledger/blue-app-iota.svg?branch=master)](https://travis-ci.org/IOTA-Ledger/blue-app-iota)

Here we try to use natively available crypto logic to create IOTA Seeds and sign transactions on the fly. It's currently heavily in alpha so don't trust this yet!

See [Ledger's documentation](http://ledger.readthedocs.io) to get more info about the inner workings.

## How to get started

### Requirements

- Make sure that your Ledger Nano S is running firmware 1.4.2.
For update instructions see: [How to update my Ledger Nano S with the firmware 1.4](https://support.ledgerwallet.com/hc/en-us/articles/360001340473-How-to-update-my-Ledger-Nano-S-with-the-firmware-1-4)

### Preparing development environment under Ubuntu 17.10

- Clone this repo
- Execute the following commands to setup your development environment:
```
cd blue-app-iota
chmod +x install_dev_env.sh
chmod +x activate_virt_env.sh
./install_dev_env.sh
```
- If you execute it for the first time, maybe you have to log out and log in again to get correct group rights

### Preparing development environment in other distributions

- Clone this repo, and set up your development environment according to this: [LedgerHQ Getting Started](https://github.com/LedgerHQ/ledger-dev-doc/blob/master/source/userspace/getting_started.rst)
- ATTENTION: Ledger Python 2 library seems to be broken, so you have to use Python 3 and the latest version of the ledger Python lib from their [GitHub](https://github.com/LedgerHQ/blue-loader-python). Have a look here:

> I was unable to install the recent update of the Ledger SDK with their direct instructions. Instead, follow everything from the link above, except for the Python SDK.
> Instead of running Python 2 like explicitly being told, use Python 3 instead (I wasn't able to make it work with Python 2 and the commits of their latest updates over the past week suggest they created Python 3 support).
> In the part where they tell you to run `pip install ledgerblue`, run `pip install git+https://github.com/LedgerHQ/blue-loader-python.git` to install the bleeding-edge version.

### Compile and load the IOTA Ledger app

- Connect your Ledger to the PC and unlock it
- To load the app, be sure that the dashboard is opened in the Ledger
- Run the following commands to compile the app from source and load it
```
cd blue-app-iota

# If you have installed using the automated script:
./activate_virt_env.sh

make load
```
- Accept all the messages on the Ledger
- You can now make your first IOTA Ledger address by running the following command (while Ledger is plugged in and the IOTA App is opened):
```
python demos/python/demo.py
```

## Documentation

See: [Ledger Nano S Web Wallet and APDU API Documentation](https://github.com/IOTA-Ledger/blue-app-iota/blob/master/Ledger%20Nano%20S%20Web%20Wallet%20and%20APDU%20API%20Documentation%20and%20implementation.md)

## Todos

See: [TODO](https://github.com/IOTA-Ledger/blue-app-iota/blob/master/TODO.md)

## Contributing

### Donations
Would you like to donate to help the development team? Send some IOTA to the following address:
```
J9KPGBTWIKTRBIWXNDCZUWWWVVESYVISFJIY9GCMGVLQXFJBDAKLLN9PNAZOOUZFZDGDSFPWCTJYILDF9WOEVDQVMY
```
Please know that the donations made to this address will be shared with everyone who contributes (the contributions has to be worth something, of course)

### As a developer
Would you like to contribute as a dev? Please check out our [Discord channel](https://discord.gg/U3qRjZj) to contact us!
