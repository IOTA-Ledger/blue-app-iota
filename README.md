# IOTA App for Ledger Blue & Ledger Nano S

[![Build Status](https://travis-ci.org/IOTA-Ledger/blue-app-iota.svg?branch=master)](https://travis-ci.org/IOTA-Ledger/blue-app-iota)

Here we try to use natively available crypto logic to create IOTA Seeds and sign transactions on the fly. It's currently heavily in alpha so don't trust this yet!

See [Ledger's documentation](http://ledger.readthedocs.io) to get more info about the inner workings.

## How to get started

### Temporary workarounds installation dev environment

> I was unable to install the recent update of the Ledger SDK with their direct instructions. Instead, follow everything from the link above, except for the Python SDK.

> Instead of running Python 2 like explicitly being told, use Python 3 instead (I wasn't able to make it work with Python 2 and the commits of their latest updates over the past week suggest they created Python 3 support).

> In the part where they tell you to run `pip install ledgerblue`, run `pip install git+https://github.com/LedgerHQ/blue-loader-python.git` to install the bleeding-edge version.

- Clone this repo, and set up your dev environment according to this: <https://github.com/LedgerHQ/ledger-nano-s>

- Inside the folder of the repo you just cloned, run `make load` while your Ledger is attached, and unlocked and watch the magic happen. Be sure to connect your Ledger and open it at the dashboard to load the app.

- You can now make your first IOTA Ledger address by running: `python demo.py` and hit enter (while ledger is plugged in and the IOTA App is open).

## Todos

See: https://github.com/IOTA-Ledger/blue-app-iota/blob/master/TODO.md
