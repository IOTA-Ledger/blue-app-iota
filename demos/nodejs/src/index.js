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

const DEST_ADDRESS = 'ADLJXS9SKYQKMVQFXR9JDUUJHJWGDNWHQZMDGJFGZOX9BZEKDSXBSPZTTWEYPTNM9OZMYDQWZXFHRTXRCOITXAGCJZ';
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

    const config = await ledger.getAppConfiguration();
    console.log('Running on version: ' + config.version);

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

    await ledger.getAddress(KEY_INDEX + 3, { display: true })
})().catch(e => {
    console.error(e);
});
