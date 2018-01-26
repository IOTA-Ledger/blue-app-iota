const IOTA = require('iota.lib.js')
var iota = new IOTA({

})
const seed = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
iota.api.getNewAddress(seed, {
  index: 0,
  security: 2,
  total: 5
}, (e, r) => {
  console.log('getNewAddress', e, r);
})
iota.api.kerlTest();
