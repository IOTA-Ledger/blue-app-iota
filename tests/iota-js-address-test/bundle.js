const IOTA = require('iota.lib.js')
var iota = new IOTA({})

const SECURITY_LEVEL = 2;

function getAddress(seed, idx) {
    return iota.api.getNewAddress(seed, {
        index: idx,
        security: SECURITY_LEVEL,
        total: 1
    }, (e, r) => {
        return r;
    })[0];
}

function getSignatureFragment(seed, bundleHash, keyIndex) {

    const Signing = iota.utils.Signing;
    const Converter = iota.utils.Converter;

    // Get corresponding private key of address
    var key = Signing.key(Converter.trits(seed), keyIndex, SECURITY_LEVEL);

    //  Get the normalized bundle hash
    var normalizedBundleHash = bundle.normalizedBundle(bundleHash);

    var signatureTrytes = "";

    for (var j = 0; j < SECURITY_LEVEL; j++) {

        var bundleFragment = normalizedBundleHash.slice(j * 27, (j + 1) * 27);
        var keyFragment = key.slice(6561 * j, (j + 1) * 6561);

        var signatureFragment = Signing.signatureFragment(bundleFragment, keyFragment);
        signatureTrytes += Converter.trytes(signatureFragment);
    }

    return signatureTrytes;
}

const seed = "BUGKFTLV9CMUCWGUQTEOBZMMQATACRBQOCFJHKFUFBFHQZFUFAXYDONXBEXXHLVKEDDJNPTUFMXDZITXE";
const timestamp = 0;
const tag = "MMMMMMMMMMMMMMMMMMMMMMMMMMM";
const output_address = "J9KPGBTWIKTRBIWXNDCZUWWWVVESYVISFJIY9GCMGVLQXFJBDAKLLN9PNAZOOUZFZDGDSFPWCTJYILDF9";
const output_value = 2047869166338947;

const input_index_0 = 14872;
const input_value_0 = -432952657161137;
const input_index_1 = 58356;
const input_value_1 = -1623029764244186;

const change_index = 58357;
const change_value = 8113255066376;

const input_address_0 = getAddress(seed, input_index_0);
const input_address_1 = getAddress(seed, input_index_1);
const change_address = getAddress(seed, change_index);

var bundle = new iota.utils.Bundle();

bundle.addEntry(1, output_address, output_value, tag, timestamp, 0);
bundle.addEntry(SECURITY_LEVEL, input_address_0, input_value_0, tag, timestamp, 0);
bundle.addEntry(SECURITY_LEVEL, input_address_1, input_value_1, tag, timestamp, 0);
bundle.addEntry(1, change_address, change_value, tag, timestamp, 0);
bundle.finalize();

var bundleHash = bundle.bundle[5].bundle;

getSignatureFragment(seed, bundleHash, input_index_0);

console.log(seed,
    bundle.bundle[0].address, 0, bundle.bundle[0].value, bundle.bundle[0].obsoleteTag, bundle.bundle[0].timestamp,
    bundle.bundle[1].address, input_index_0, bundle.bundle[1].value, bundle.bundle[1].obsoleteTag, bundle.bundle[1].timestamp,
    bundle.bundle[2].address, input_index_0, bundle.bundle[2].value, bundle.bundle[2].obsoleteTag, bundle.bundle[2].timestamp,
    bundle.bundle[3].address, input_index_1, bundle.bundle[3].value, bundle.bundle[3].obsoleteTag, bundle.bundle[3].timestamp,
    bundle.bundle[4].address, input_index_1, bundle.bundle[4].value, bundle.bundle[4].obsoleteTag, bundle.bundle[4].timestamp,
    bundle.bundle[5].address, change_index, bundle.bundle[5].value, bundle.bundle[5].obsoleteTag, bundle.bundle[5].timestamp,
    bundleHash, getSignatureFragment(seed, bundleHash, input_index_0), getSignatureFragment(seed, bundleHash, input_index_1));
