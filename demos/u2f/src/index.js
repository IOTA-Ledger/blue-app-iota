import "babel-polyfill";

import Transport from "@ledgerhq/hw-transport-u2f";
import AppBtc from "@ledgerhq/hw-app-btc";
import AppIota from "hw-app-iota";

// use testnet path
const BIP44_PATH = [
    0x8000002C,
    0x80000001,
    0x80000000,
    0x00000000,
    0x00000000
];
const SECURITY_LEVEL = 2;

const getBtcAddress = async () => {
    const transport = await Transport.create();
    const btc = new AppBtc(transport);
    const result = await btc.getWalletPublicKey("44'/0'/0'/0");
    return result.bitcoinAddress;
};

const getIotaAddress = async () => {

    const transport = await Transport.create();
    transport.setDebugMode(true);
    // transport.setScrambleKey("IOTA");
    const iota = new AppIota(transport);

    await iota.setSeedInput(BIP44_PATH, SECURITY_LEVEL);
    return await ledger.getPubKey(0);
};


const errorEl = document.createElement("code");
errorEl.style.color = "#a33";
const pre = document.createElement("pre");
pre.appendChild(errorEl);
document.body.appendChild(pre);

// getBtcAddress().then(a => console.log(a));
getIotaAddress().then(
    a => {
        console.log(a);
        document.write(a);
    },
    e => {
        console.error(e);
        errorEl.textContent = e.message;
    }
);
