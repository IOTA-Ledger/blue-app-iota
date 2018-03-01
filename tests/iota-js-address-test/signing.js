var Converter = require("iota.lib.js/lib/crypto/converter/converter");
var Signing = require("iota.lib.js/lib/crypto/signing/signing");

const keySecurity = 3;
const seed = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
const normalizedBundleHash = Array.apply(null, Array(81)).map(Number.prototype.valueOf, 0);

var key = Signing.key(Converter.trits(seed), 0, keySecurity);

var normalizedBundleFragments = [];
for (var l = 0; l < 3; l++) {
    normalizedBundleFragments[l] = normalizedBundleHash.slice(l * 27, (l + 1) * 27);
}

var firstFragment = key.slice(0, 6561);
var firstBundleFragment = normalizedBundleFragments[0];

//  Calculate the new signatureFragment with the first bundle fragment
var firstSignedFragment = Signing.signatureFragment(firstBundleFragment, firstFragment);
console.log(Converter.trytes(firstSignedFragment));

for (var j = 1; j < keySecurity; j++) {

    var nextFragment = key.slice(6561 * j, (j + 1) * 6561);
    var nextBundleFragment = normalizedBundleFragments[j];

    var nextSignedFragment = Signing.signatureFragment(nextBundleFragment, nextFragment);
    console.log(Converter.trytes(nextSignedFragment));
}
