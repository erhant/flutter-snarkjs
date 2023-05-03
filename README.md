# SnarkJS within Flutter

An attempt to use SnarkJS within Flutter WebView.

- [WebView Tutorial](https://codelabs.developers.google.com/codelabs/flutter-webview#0)
- [SnarkJS in Browser](https://github.com/iden3/snarkjs#in-the-browser)

The example circuit used within `multiplier_3` is simply a circuit to compute the multiplication of 3 numbers.

```js
// input signals
{
  "in": [3, 7, 11]
}

// output signals
{
  "out": 231
}
```

The provided prover key & verification key is of a PLONK proof system. PTAU used is for BN128 by [Polygon Hermez](powersOfTau28_hez_final_08.ptau) (less than $2^8$ constraints in this one).

## Disclaimer

I have no idea of mobile development, this is practically my hello-world in the mobile space.
