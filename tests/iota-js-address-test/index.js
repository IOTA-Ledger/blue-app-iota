const IOTA = require('iota.lib.js')
var iota = new IOTA({

})

function bundleTest(signatureSize) {
  var bundle = new iota.utils.Bundle();

  bundle.addEntry(signatureSize, "LHWIEGUADQXNMRKQSBDJOAFMBIFKHHZXYEFOU9WFRMBGODSNJAPGFHOUOSGDICSFVA9KOUPPCMLAHPHAW", 10, "999999999999999999999999999", 0, 0);
  bundle.addEntry(signatureSize, "WLRSPFNMBJRWS9DFXCGIROJCZCPJQG9PMOO9CUZNQXTLLQAYXGXT9LECGEQ9MQIWIBGQREFHULPOETHNZ", -5, "999999999999999999999999999", 0, 0);
  bundle.addEntry(signatureSize, "UMDTJXHIFVYVCHXKZNMQWMDHNLVQNMJMRULXUFRLNFVVUMKYZOAETVQOWSDUAKTXVNDSVAJCASTRQNV9D", -5, "999999999999999999999999999", 0, 0);
  bundle.finalize();

  console.log('bundle test', bundle);
}


bundleTest(1);
bundleTest(2);
