const IOTA = require('iota.lib.js')
var iota = new IOTA({

})

function addressTest() {
  const seed = "SSEWOZSDXOVIURQRBTBDLQXWIXOLEUXHYBGAVASVPZ9HBTYJJEWBR9PDTGMXZGKPTGSUDW9QLFPJHTIEQ";
  iota.api.getNewAddress(seed, {
    index: 0,
    security: 2,
    total: 5
  }, (e, r) => {
    console.log('getNewAddress', e, r);
  })
}

function prepareTransfersTest() {
  iota.api.prepareTransfers('SSEWOZSDXOVIURQRBTBDLQXWIXOLEUXHYBGAVASVPZ9HBTYJJEWBR9PDTGMXZGKPTGSUDW9QLFPJHTIEQ', [{
      'address': 'YADBKU9RYDMITS9JYO9AWTMCCVDXPBHXUDCBISLWFVWUMBV9GURNRGATEIJPCJDKDHLALGABKBBOGPIGW',
      'value': 10000
    }], {
      'inputs': [{
        address: 'WRZVVTBRAFZJOANBVGPTDSURL9ATRDAXOEVDQRNLEOFDYK9FLQZIJZYAEVUHCQCMAXWSZJPTUMQBPOLBY',
        balance: 1500,
        keyIndex: 0,
        security: 2
      }, {
        address: 'VBFKTULDJHSGXIHIGKJYGUZFZMU9IZRMCCKBCITGSRFHYCNTBQK9PNMUZKDUG9VXFMEXWNSOVVYWO9BPW',
        balance: 8500,
        keyIndex: 1,
        security: 2
      }]
    },
    function(e, s) {
      console.log(e, s);
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
prepareTransfersTest();
bundleTest(1);
bundleTest(2);
