const IOTA = require('iota.lib.js')
var iota = new IOTA({
  provider: 'http://iota.love:16000'
})
const seed = "UTVXGSTTZVZFROBJSGHDUZIPQEGXRNAEQPQHAKB9BTSLOJVFBVNWAMSNBXCZLJTHSCOVMPARZEXQJFEXQ";

iota.api.kerlTest();

//-Just adding so it's easier to find what I changed during my testing
/*
iota.api.getNewAddress(seed, {
  index: 0,
  security: 2
}, (e, r) => {
  console.log(e, r);
})
*/