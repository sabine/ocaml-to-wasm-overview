# ocaml-to-wasm-overview

This is a collection of links and ideas on how to implement an OCaml -> WASM compiler.

## Possible Paths to WASM

* a) translate Cmm -> WASM
* b) translate OCaml bytecode -> WASM
* c) implement a bytecode interpreter for OCaml in WASM
* d) translate Cmm -> LLVM
* e) translate OCaml bytecode -> LLVM
* f) translate Cmm -> binaryen -> WASM
* g) translate OCaml bytecode -> binaryen -> WASM
* h) translate optimized machine code -> WASM

## Related Projects and Discussions

### a) Cmm -> WASM

* https://github.com/rolph-recto/ocaml-wasm/tree/wasm/wasmcomp

  "first working version: compiles arith exprs only"

### b) OCaml bytecode -> WASM

I have not found anything yet.

### c) bytecode interpreter in WASM

sebmarkbage compiled the OCaml bytecode interpreter to WASM using emscripten:
https://github.com/sebmarkbage/ocamlrun-wasm

### d) Cmm -> LLVM

* https://github.com/whitequark/ocaml-llvm-ng/blob/master/lib/llvmcomp.ml

--

* http://caml.inria.fr/pub/ml-archives/caml-list/2009/03/3a77bfcca0f90b763d127d1581d6a2f1.en.html

--

* https://discuss.ocaml.org/t/llvm-backend-for-ocaml/1132/5

## In-Progress Projects

* [WIP] https://github.com/SanderSpies/ocaml/tree/manual_gc/asmcomp/wasm32
  solo effort by Sander Spies, so far

  Translates from Cmm to WASM.

  https://medium.com/@sanderspies/a-webassembly-backend-for-ocaml-b78e7eeea9d5

  https://medium.com/@sanderspies/the-road-to-webassembly-gc-for-ocaml-bd44dc7f9a9d
