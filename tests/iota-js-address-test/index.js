const IOTA = require('iota.lib.js')
var iota = new IOTA({
  provider: 'https://nodes.testnet.iota.org:443/'
})
const seed = "EJBNGIAVDNSE9KKQIJYBQUWLARELMIWFSRRGQCWTQDGASDHCFCBPXLJTBDOENLTEVKMVSXQDDFMPDIH9P";

function addressTest() {
  iota.api.getNewAddress(seed, {
    index: 0,
    security: 2,
    total: 5
  }, (e, r) => {
    console.log('getNewAddress', e, r);
  })
}

function prepareTransfersTest() {
  iota.api.prepareTransfers(seed, [{
      'address': 'DLMWEZOASDZXGFYAOBPIDUSLWYTQWHVPTKXXFIUWBJOTXUYPNHJUEZRTNNEPZVCBYOYDQCZGUXQJQMODC',
      'value': 1000,
      'message': ''
    }], {
      'inputs': [{
        address: 'OC9HFEZLOXLLBJ9HHTFTJPDYYFDXGCDAJTCLBARZGNJJTQSZR9WOG9TV9MEIYBRWXTSNQXAUGDTAWXCPD',
        balance: 1000,
        keyIndex: 0,
        security: 2
      }]
    },
    function(e, s) {
      console.log('prepareTransfers result', e, s);
      iota.api.sendTrytes(s, 2, 9, (e, r) => {
        console.log('sendTrytes', e, r);
      });
    })
}

function bundleTest(signatureSize) {
  var bundle = new iota.utils.Bundle();

  bundle.addEntry(signatureSize, "LHWIEGUADQXNMRKQSBDJOAFMBIFKHHZXYEFOU9WFRMBGODSNJAPGFHOUOSGDICSFVA9KOUPPCMLAHPHAW", 10, "999999999999999999999999999", 0, 0);
  bundle.addEntry(signatureSize, "WLRSPFNMBJRWS9DFXCGIROJCZCPJQG9PMOO9CUZNQXTLLQAYXGXT9LECGEQ9MQIWIBGQREFHULPOETHNZ", -5, "999999999999999999999999999", 0, 0);
  bundle.addEntry(signatureSize, "UMDTJXHIFVYVCHXKZNMQWMDHNLVQNMJMRULXUFRLNFVVUMKYZOAETVQOWSDUAKTXVNDSVAJCASTRQNV9D", -5, "999999999999999999999999999", 0, 0);
  bundle.finalize();

  console.log('bundle test', bundle);
}

addressTest();
// prepareTransfersTest();
// bundleTest(1);
// bundleTest(2);
