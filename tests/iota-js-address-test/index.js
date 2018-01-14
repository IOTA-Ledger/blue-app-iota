const IOTA = require('iota.lib.js')
var iota = new IOTA({
  provider: 'http://iota.love:16000'
})
const seed = "UTVXGSTTZVZFROBJSGHDUZIPQEGXRNAEQPQHAKB9BTSLOJVFBVNWAMSNBXCZLJTHSCOVMPARZEXQJFEXQ";

iota.api.getNewAddress(seed, {
  index: 0,
  security: 1
}, (e, r) => {
  console.log(e, r);
})
