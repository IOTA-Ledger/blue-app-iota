# U2F Browser Demo

## WARNING

This demo will expose signatures for addresses derived from the BIP44 testnet path `m / 44' / 1' / 0' / 0 / 0`.
This path must therefore never be used to derive addresses storing actual mainnet funds.

### Install dependencies

```bash
yarn
```

### Build

```bash
yarn run build
```

### Run demo on the real device

Start server

```bash
yarn start
```

Use recent Google Chrome version to connect to the provided address.
