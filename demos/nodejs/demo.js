const Transport = require("@ledgerhq/hw-transport-node-hid")

async function Main() {
  const transport = await Transport.create()
}
