import 'babel-polyfill';

import Transport from '@ledgerhq/hw-transport-node-hid';
import IOTALedger from 'hw-app-iota';
import {
    isBundle,
    transactionObject
} from 'iota.lib.js/lib/utils/utils';

// use testnet path
const BIP44_PATH = "44'/1'/0'/0/0";
const SECURITY_LEVEL = 3;

const DEST_ADDRESS = 'J9KPGBTWIKTRBIWXNDCZUWWWVVESYVISFJIY9GCMGVLQXFJBDAKLLN9PNAZOOUZFZDGDSFPWCTJYILDF9WOEVDQVMY';
const KEY_INDEX = 1;
const VALUE = 10;
const BALANCE = 12;

function validateBundleTrytes(bundleTrytes) {

    // convert to transaction objects to add transactions hashes to bundle
    var transactionObjects = [];
    bundleTrytes.forEach(tx => {
        transactionObjects.unshift(transactionObject(tx));
    });

    // validates signatures and overall structure.
    console.assert(isBundle(transactionObjects), 'Invalid bundle', transactionObjects);
}

(async () => {
    const transport = await Transport.create();
    const ledger = new IOTALedger(transport);

    // initialize
    await ledger.setActiveSeed(BIP44_PATH, SECURITY_LEVEL);

    const transfers = [{
        address: DEST_ADDRESS,
        value: VALUE,
        tag: ''
    }];
    const inputs = [{
        address: await ledger.getAddress(KEY_INDEX),
        balance: BALANCE / 2,
        keyIndex: KEY_INDEX
    }, {
        address: await ledger.getAddress(KEY_INDEX + 1),
        balance: BALANCE / 2,
        keyIndex: KEY_INDEX + 1
    }];
    const remainder = {
        address: await ledger.getAddress(KEY_INDEX + 2),
        keyIndex: KEY_INDEX + 2
    };
    console.log({
        transfers: transfers,
        inputs: inputs,
        change: remainder
    });

    var trytes = await ledger.signTransaction(transfers, inputs, remainder);

    validateBundleTrytes(trytes);

    var wIndexes = [5, 9, 12, 16, 8];

    await ledger.writeIndexes(wIndexes);

    var rIndexes = await ledger.readIndexes();
    console.log("[0]: " + rIndexes[0] + "\n");
    console.log("[1]: " + rIndexes[1] + "\n");
    console.log("[2]: " + rIndexes[2] + "\n");
    console.log("[3]: " + rIndexes[3] + "\n");
    console.log("[4]: " + rIndexes[4] + "\n");


    await ledger.displayAddress(4);
})().catch(e => {
    console.error(e);
});
