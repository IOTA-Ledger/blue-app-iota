import 'babel-polyfill';

import Transport from "@ledgerhq/hw-transport-node-hid";
import IOTALedger from "hw-app-iota";
import IOTA from "iota.lib.js";
const assert = require('assert').strict;

// use testnet
const iota = new IOTA({
    provider: 'https://nodes.testnet.iota.org:443/'
});

// use testnet path
const BIP44_PATH = [
    0x8000002C,
    0x80000001,
    0x80000000,
    0x00000000,
    0x00000000
];
const SECURITY_LEVEL = 2;

const DEST_ADDRESS = "J9KPGBTWIKTRBIWXNDCZUWWWVVESYVISFJIY9GCMGVLQXFJBDAKLLN9PNAZOOUZFZDGDSFPWCTJYILDF9";
const SRC_INDEX = 1;
const VALUE = 10;
const TAG = "999999999999999999999999999";
const TIMESTAMP = Math.floor(Date.now() / 1000);

function validateBundle(bundle) {

    // convert to trytes and back, to add transactions hashes to bundle
    var bundleTrytes = [];
    bundle.bundle.forEach(tx => {
        bundleTrytes.push(iota.utils.transactionTrytes(tx));
    });
    var transactionObjects = [];
    bundleTrytes.forEach(tx => {
        transactionObjects.push(iota.utils.transactionObject(tx));
    });

    // validates signatures and overall structure.
    assert(iota.utils.isBundle(transactionObjects));
}

(async () => {
    const transport = await Transport.create();
    const ledger = new IOTALedger(transport);

    // initialize
    await ledger.setSeedInput(BIP44_PATH, SECURITY_LEVEL);
    // get input address
    const address = await ledger.getPubKey(SRC_INDEX);
    const address2 = await ledger.getPubKey(SRC_INDEX + 1);

    console.log("create bundle; dest=%s, value=%i, src=%s", DEST_ADDRESS, VALUE, address);

    var bundle = new iota.utils.Bundle();

    bundle.addEntry(1, DEST_ADDRESS, VALUE, TAG, TIMESTAMP, 0);
    bundle.addEntry(SECURITY_LEVEL, address, -VALUE, TAG, TIMESTAMP, SRC_INDEX);
    bundle.addTrytes([]);
    bundle.finalize();

    // map input addresses to their index
    var inputMapping = {};
    inputMapping[address] = SRC_INDEX;
    // inputMapping[address2] = SRC_INDEX2;

    // sign the bundle on the ledger
    bundle = await ledger.signBundle({
        inputMapping,
        bundle,
        security: SECURITY_LEVEL
    });

    // dump signed bundle
    console.log(bundle);
    validateBundle(bundle);
})().catch(e => {
    console.error(e);
});
