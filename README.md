# SnarkJS within Flutter

An attempt to use SnarkJS within Flutter WebView.

- [WebView Tutorial](https://codelabs.developers.google.com/codelabs/flutter-webview#0)
- [SnarkJS in Browser](https://github.com/iden3/snarkjs#in-the-browser)

The example circuit used within `multiplier_3` is simply a circuit to compute the multiplication of 3 numbers.

```json
{
  "inputSignals": {
    "in": [3n, 7n, 11n]
  },
  "outputSignals" {
    "out": 231
  }
}
```

The provided prover key & verification key is of a PLONK proof system. PTAU used is for BN128 by [Polygon Hermez](powersOfTau28_hez_final_08.ptau) (less than $2^8$ constraints in this one).

## Disclaimer

I have no idea of mobile development, this is practically my hello-world in the mobile space.
