import "babel-polyfill";

import Transport from "@ledgerhq/hw-transport-u2f";
import AppIota from "hw-app-iota";

// use testnet path
const BIP44_PATH = "44'/1'/0'/0/0";
const SECURITY_LEVEL = 2;

const getIotaAddress = async () => {
    const transport = await Transport.create();
    const hwapp = new AppIota(transport);
    await hwapp.setActiveSeed(BIP44_PATH, SECURITY_LEVEL);
    return await hwapp.getAddress(0, {
        checksum: true
    });
};

const errorEl = document.createElement("code");
errorEl.style.color = "#a33";
const pre = document.createElement("pre");
pre.appendChild(errorEl);
document.body.appendChild(pre);

getIotaAddress().then(
    a => {
        console.log(a);
        document.write(a);
    },
    e => {
        console.log(e);
        errorEl.textContent = e.message;
    }
);
