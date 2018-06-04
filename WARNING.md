# IOTA Security Concerns on Ledger Nano S

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

# Future deprecation notes

- **Address generation**

    In the current alpha/beta version of the IOTA application on Ledger we use an address generator that is incompatible to what Trinity is using. It could happen that when we integrate with Trinity, you end up with **different addresses than you had before**, even when logging in with the same seed as you did on the Romeo-web-wallet.

    If such event, we will be doing a transition to move everyone over from the alpha and/or beta program to the final Trinity-version.
