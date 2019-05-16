const fs = require("fs");
const { createPrepareTransfers, generateAddress } = require('@iota/core');
const { asTransactionObject } = require("@iota/transaction-converter");

const NUM_BUNDLES = 100;
const MAX_BUNDLE_SIZE = 10;

// prepare transfers offline
const prepareTransfers = createPrepareTransfers(undefined, Date.now());

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

function getAddress(seed, index, security) {
  return generateAddress(seed, index, security, false)
}

async function addAddresses(inputs, seed, security) {
  const addresses = inputs.map(input => getAddress(seed, input.keyIndex, security));
  return inputs.map((input, i) => {
    return {
      address: addresses[i],
      keyIndex: input.keyIndex,
      security,
      balance: input.balance
    };
  });
}

async function getTxInputs(
  seed,
  security,
  output_address,
  output_value,
  output_tag,
  inputs,
  change_idx
) {
  inputs = await addAddresses(inputs, seed, security);
  const change_address = await getAddress(seed, change_idx, security);

  const transfers = [
    {
      address: output_address,
      value: output_value,
      tag: output_tag,
      message: ""
    }
  ];

  const txs = (await prepareTransfers(seed, transfers, {
    inputs: inputs,
    remainderAddress: change_address,
    security
  })).map(t => asTransactionObject(t));
  txs.reverse();

  const signatures = [];
  for (let i = 1; i < txs.length - 1;) {
    let signature = "";
    for (let j = 0; j < security; j++) {
      signature += txs[i++].signatureMessageFragment;
    }
    signatures.push(signature);
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
    inputs.forEach(
      (input, j) => (tx_inputs[1 + j * security + i].index = input.keyIndex)
    );
  }
  tx_inputs[1 + inputs.length * security].index = change_idx;

  return [seed, security, txs[0].lastIndex]
    .concat(
      tx_inputs.reduce(
        (acc, tx) =>
          acc.concat([tx.address, tx.index, tx.value, tx.tag, tx.timestamp]),
        []
      )
    )
    .concat([txs[0].bundle])
    .concat(signatures);
}

(async () => {
  const stream = fs.createWriteStream("test.csv");

  for (let security = 1; security <= 3; security++) {
    for (
      let num_inputs = 1;
      num_inputs <= (MAX_BUNDLE_SIZE - 2) / security;
      num_inputs++
    ) {
      for (let i = 0; i < NUM_BUNDLES; i++) {
        const seed = randomTrytes(81);
        const output_address = randomTrytes(81);
        const tag = randomTrytes(27);

        // total funds up to 1Ti
        const total = Math.floor(Math.random() * 1e12) + 1;
        const output_value = Math.floor(total * Math.random());

        let rem = total;
        const inputs = [];
        for (let j = num_inputs - 1; j >= 0; j--) {
          const keyIndex = randomInt(
            0,
            254,
            inputs.map(input => input.keyIndex)
          );
          const balance =
            j == 0 ? rem : Math.floor(Math.random() * (rem - num_inputs)) + 1;
          rem -= balance;

          inputs.push({ keyIndex, balance });
        }

        // change index must be greater than the inputs
        const indices = inputs.map(input => input.keyIndex);
        const change_idx = randomInt(
          Math.max.apply(Math, indices),
          255,
          indices
        );

        const tx_inputs = await getTxInputs(
          seed,
          security,
          output_address,
          output_value,
          tag,
          inputs,
          change_idx
        );

        stream.write(tx_inputs.join(",") + "\n");
      }
    }
  }

  stream.end();
})();
