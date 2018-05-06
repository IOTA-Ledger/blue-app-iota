import 'babel-polyfill';

import Transport from '@ledgerhq/hw-transport-node-hid';
import IOTALedger from 'hw-app-iota';
import {
    isBundle,
    transactionObject
} from 'iota.lib.js/lib/utils/utils';

// use testnet path
const BIP44_PATH = [
    0x8000002C,
    0x80000001,
    0x80000000,
    0x00000000,
    0x00000000
];
const SECURITY_LEVEL = 2;

const DEST_ADDRESS = 'J9KPGBTWIKTRBIWXNDCZUWWWVVESYVISFJIY9GCMGVLQXFJBDAKLLN9PNAZOOUZFZDGDSFPWCTJYILDF9';
const SRC_INDEX = 1;
const VALUE = 10;
const TAG = '';

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
    await ledger.setSeedInput(BIP44_PATH, SECURITY_LEVEL);
    // get input address
    const address = await ledger.getAddress(SRC_INDEX, {
        checksum: true
    });

    console.log('create bundle; dest=%s, value=%i, src=%s', DEST_ADDRESS, VALUE, address);

    const transfers = [{
        address: DEST_ADDRESS,
        value: VALUE,
        tag: TAG
    }];
    const inputs = [{
        address: address,
        balance: VALUE,
        keyIndex: SRC_INDEX
    }];
    var trytes = await ledger.getSignedTransactions(transfers, inputs);

    validateBundleTrytes(trytes);
})().catch(e => {
    console.error(e);
});
