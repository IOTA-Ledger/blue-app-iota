const Transport = require("@ledgerhq/hw-transport-node-hid").default;
const IOTALedger = require("hw-app-iota");

/*
const IOTA = require("iota.lib.js");
const iotaLib = new IOTA({
    provider: 'https://nodes.testnet.iota.org:443/'
});
*/

const getAddress = async () => {
    try {
        const transport = await Transport.create();
        const ledger = new IOTALedger(transport);

        await ledger.setSeedInput([
            0x8000002C,
            0x8000107A,
            0x80000000,
            0x00000000,
            0x00000000
        ]);
        return await ledger.getPubKey(0);
    } catch (error) {
        console.error(error);
    }
};

getAddress().then(a => console.log(a));
