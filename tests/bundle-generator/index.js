const fs = require("fs");
const { composeAPI } = require("@iota/core");
const { asTransactionObject } = require("@iota/transaction-converter");

const NUM_BUNDLES = 200;

const iota = composeAPI({
  provider: "https://field.deviota.com:443"
});

function randomInt(min, max, excluding) {
  let value;
  do {
    value = Math.floor(Math.random() * (max - min + 1)) + min;
  } while (excluding.includes(value));

  return value;
}

function randomTrytes(length) {
  const possible = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";

  let text = "";
  for (let i = 0; i < length; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }

  return text;
}

async function getAddress(seed, index, security) {
  addresses = await iota.getNewAddress(seed, {
    index,
    security,
    checksum: false,
    total: 1
  });
  return addresses[0];
}

async function getTxInputs(
  seed,
  security,
  output_address,
  output_value,
  output_tag,
  input_idx_1,
  input_balance_1,
  input_idx_2,
  input_balance_2,
  change_idx
) {
  const input_address_1 = await getAddress(seed, input_idx_1, security);
  const input_address_2 = await getAddress(seed, input_idx_2, security);
  const change_address = await getAddress(seed, change_idx, security);

  const transfers = [
    {
      address: output_address,
      value: output_value,
      tag: output_tag,
      message: ""
    }
  ];

  const inputs = [
    {
      address: input_address_1,
      keyIndex: input_idx_1,
      security,
      balance: input_balance_1
    },
    {
      address: input_address_2,
      keyIndex: input_idx_2,
      security,
      balance: input_balance_2
    }
  ];

  const txs = (await iota.prepareTransfers(seed, transfers, {
    inputs,
    address: change_address,
    security
  })).map(t => asTransactionObject(t));
  txs.reverse();

  let signature_1 = "";
  let signature_2 = "";
  for (let i = 0; i < security; i++) {
    signature_1 += txs[1 + i].signatureMessageFragment;
    signature_2 += txs[1 + security + i].signatureMessageFragment;
  }

  let tx_inputs = txs.map(tx => {
    return {
      address: tx.address,
      index: 0,
      value: tx.value,
      tag: tx.obsoleteTag,
      timestamp: tx.timestamp
    };
  });

  for (let i = 0; i < security; i++) {
    tx_inputs[1 + i].index = input_idx_1;
    tx_inputs[1 + security + i].index = input_idx_2;
  }
  tx_inputs[1 + 2 * security].index = change_idx;

  tx_inputs = tx_inputs
    .map(o => Object.values(o))
    .reduce((acc, val) => acc.concat(val), []);

  return [seed, security]
    .concat(tx_inputs)
    .concat([txs[0].bundle, signature_1, signature_2]);
}

(async () => {
  const stream = fs.createWriteStream("test.csv");

  for (let security = 1; security <= 3; security++) {
    for (let i = 0; i < NUM_BUNDLES; i++) {
      const seed = randomTrytes(81);
      const output_address = randomTrytes(81);
      const tag = randomTrytes(27);

      // change index must be greater than the inputs
      const input_idx_1 = randomInt(0, 254, []);
      const input_idx_2 = randomInt(0, 254, [input_idx_1]);
      const change_idx = randomInt(Math.max(input_idx_1, input_idx_2), 255, [
        input_idx_1,
        input_idx_2
      ]);

      // total funds up to 1Ti
      const total = Math.floor(Math.random() * 1e12) + 1;

      const input_balance_1 = Math.floor(total * Math.random());
      const input_balance_2 = total - input_balance_1;

      const output_value = Math.floor(total * Math.random());

      const tx_inputs = await getTxInputs(
        seed,
        security,
        output_address,
        output_value,
        tag,
        input_idx_1,
        input_balance_1,
        input_idx_2,
        input_balance_2,
        change_idx
      );

      stream.write(tx_inputs.join(",") + "\n");
    }
  }

  stream.end();
})();
