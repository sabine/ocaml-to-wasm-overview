# ocaml-to-wasm-overview

This is a collection of links and ideas on how to implement an OCaml -> WASM compiler.

## Possible Paths to WASM

Direct:
* a) translate Cmm -> WASM
* b) translate OCaml bytecode -> WASM
* c) run the bytecode interpreter for OCaml in WASM

Indirect:
* d) Cmm -> LLVM -> WASM
* e) OCaml bytecode -> LLVM -> WASM
* f) Ocaml -> optimized machine code -> WASM

Garbage collector
* "Manual" garbage collection on the WASM `mem`, by maintaining a shadow stack
* Using the WASM garbage collector, if/when it becomes available
* Using `anyref` to allocate heap objects when [Reference Types](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md) become available.
  
  This means using the JavaScript garbage collector, and may or may not be different to the "WASM garbage collector".

# Related Projects and Discussions

## Direct Roads to WASM

### a) Cmm -> WASM

* **[probably abandoned]** https://github.com/rolph-recto/ocaml-wasm/tree/wasm/wasmcomp

  "first working version: compiles arith exprs only", latest commit Jul 27, 2018

* **[WIP]** https://github.com/SanderSpies/ocaml/tree/manual_gc/asmcomp/wasm32
  solo effort by Sander Spies, so far

  Translates from Cmm to WASM.

  https://medium.com/@sanderspies/a-webassembly-backend-for-ocaml-b78e7eeea9d5

  https://medium.com/@sanderspies/the-road-to-webassembly-gc-for-ocaml-bd44dc7f9a9d

### b) OCaml bytecode -> WASM

I have not found anything yet.

#### Related

In the past, translating bytecode has proven a successful strategy:

* OCaml bytecode -> JavaScript: https://github.com/ocsigen/js_of_ocaml
* Ocaml bytecode -> C: https://github.com/bvaugon/ocamlcc

### c) bytecode interpreter in WASM

* **[inactive]** https://github.com/sebmarkbage/ocamlrun-wasm

  sebmarkbage compiled the OCaml bytecode interpreter, as well as the GC to WASM using emscripten. [Latest commit Mar 6, 2017](https://github.com/sebmarkbage/ocamlrun-wasm/commit/473580d7d2955ce254c2d0263383f7e251f6e497)

  I tried to compile this, but am stuck at the problem described in [Issue 1](https://github.com/sebmarkbage/ocamlrun-wasm/issues/1)


## Indirect Roads to WASM

### d) Cmm -> LLVM

* **[abandoned]** https://github.com/whitequark/ocaml-llvm-ng/blob/master/lib/llvmcomp.ml


* **[discussion]** http://caml.inria.fr/pub/ml-archives/caml-list/2009/03/3a77bfcca0f90b763d127d1581d6a2f1.en.html


* **[discussion]** https://discuss.ocaml.org/t/llvm-backend-for-ocaml/1132/5

### e) OCaml bytecode -> LLVM

I haven't found anything.

### f) optimized machine code -> WASM

I haven't found anything.
