import Transport from "@ledgerhq/hw-transport-node-hid";
import IOTALedger from "hw-app-iota";
import IOTA from "iota.lib.js";

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
const TAG = "TEST";
const TIMESTAMP = Math.floor(Date.now() / 1000);


(async () => {
    const iota = new IOTA({
        provider: 'https://nodes.testnet.iota.org:443/'
    });

    const transport = await Transport.create();
    const ledger = new IOTALedger(transport);

    // initialize
    await ledger.setSeedInput(BIP44_PATH);
    // get input address
    const address = await ledger.getPubKey(SRC_INDEX);

    console.log("create bundle; dest=%s, value=%i, src=%s", DEST_ADDRESS, VALUE, address);

    var bundle = new iotaLib.utils.Bundle();

    bundle.addEntry(1, DEST_ADDRESS, VALUE, TAG, TIMESTAMP, 0);
    bundle.addEntry(2, address, -VALUE, TAG, TIMESTAMP, SRC_INDEX);
    bundle.addTrytes([]);
    bundle.finalize();

    var inputMapping = {
        address: SRC_INDEX
    };
    // sign the bundle on the ledger
    bundle = await ledger.signBundle({
        inputMapping,
        bundle,
        security: SECURITY_LEVEL
    });

    // dump signed bundle
    console.log(bundle);
})().catch(e => {
    console.error(e);
});
