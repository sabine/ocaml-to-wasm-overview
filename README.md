# ocaml-to-wasm-overview

This is a collection of links and ideas on how to implement an OCaml -> WASM compiler.

## Possible Paths to WASM

Direct:
* 1a) translate Cmm -> WASM
* 1b) translate OCaml bytecode -> WASM
* 1c) run the bytecode interpreter for OCaml in WASM
* 1d) translate Lambda -> WASM

Indirect:
* 2a) Cmm -> LLVM -> WASM
* 2b) OCaml bytecode -> LLVM -> WASM
* 2c) Ocaml -> optimized machine code -> WASM

Garbage collector
* "Manual" garbage collection on the WASM `mem`, by maintaining a shadow stack

  This is apparently what the [WASM backend of the Go language](https://docs.google.com/document/d/131vjr4DH6JFnb-blm_uRdaC0_Nv3OUwjEY5qVCxCup4/preview#heading=h.nrkaoiab5j18) does.

* Using the WASM garbage collector, if/when it becomes available

  The WASM garbage collector specification is still at a very early stage, and it is not clear how exactly it will work.

* Using `anyref` to allocate heap objects when [Reference Types](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md) become available.
  
  This means using the JavaScript garbage collector, and may or may not be different to the "WASM garbage collector".

# Related Projects and Discussions

## Direct Roads to WASM

### 1a) Cmm -> WASM


#### Advantages

* **Execution speed**

  From all approaches, this one is likely to have the best runtime performance, with executable file size similar to that of native machine code.
  This is due to translating a version of the program that has already been optimized.

#### Related

* **[incomplete, probably abandoned]** https://github.com/rolph-recto/ocaml-wasm/tree/wasm/wasmcomp

  "first working version: compiles arith exprs only", latest commit Jul 27, 2018

* **[WIP]** https://github.com/SanderSpies/ocaml/tree/manual_gc/asmcomp/wasm32
  solo effort by Sander Spies, so far

  Translates from Cmm to WASM.

  https://medium.com/@sanderspies/a-webassembly-backend-for-ocaml-b78e7eeea9d5

  https://medium.com/@sanderspies/the-road-to-webassembly-gc-for-ocaml-bd44dc7f9a9d

### 1b) OCaml bytecode -> WASM

I am not aware of any projects that attempt translating from OCaml bytecode to WASM. Please let me know if you are.

#### Advantages

* **Maintainability**

  The bytecode interpreter hardly ever changes at all, and it is fairly well-documented (it is said to still largely correspond to what is laid out in [the original report on ZINC](https://caml.inria.fr/pub/papers/xleroy-zinc.pdf)).
  There is no dependency on compiler internals, as we can work on the bytecode output of `ocamlc`.

#### Related

In the past, translating bytecode has proven to be a successful and maintainable strategy for compiling OCaml to different languages:

* **[production-ready]** OCaml bytecode -> JavaScript: https://github.com/ocsigen/js_of_ocaml

  https://www.irif.fr/~balat/publications/vouillon_balat-js_of_ocaml.pdf presents performance results from 2011: The code generated by `js_of_ocaml` running on the V8 JavaScript engine was faster than running the bytecode interpreter on the bytecode generated by `ocamlc`, and slower than the machine code generated by `ocamlopt`.
  Exceptions turned out to be very expensive.
  
  `js_of_ocaml` is being used in production systems, as far as I know, it is currently the best tool to compile OCaml to JavaScript.
  
  *Note:* It is unlikely, that exceptions will be an issue when compiling to WASM, since the exception mechanism in WASM is different from the one in JavaScript.

* **[inactive]** Ocaml bytecode -> C: https://github.com/bvaugon/ocamlcc

  According to http://michel.mauny.net/data/papers/mauny-vaugon-ocamlcc-oud2012.pdf, performance in 2012 was better than running the bytecode interpreter, and worse than running the machine code generated by `ocamlopt`, which essentially was to be expected. However, this comes at the cost of having large executables, roughly up to twice the size of machine code in the considered examples.
  

### 1c) bytecode interpreter in WASM

* **[inactive]** https://github.com/sebmarkbage/ocamlrun-wasm

  sebmarkbage compiled the OCaml bytecode interpreter, as well as the GC to WASM using emscripten. [Latest commit Mar 6, 2017](https://github.com/sebmarkbage/ocamlrun-wasm/commit/473580d7d2955ce254c2d0263383f7e251f6e497)

  I tried to compile this, but am stuck at the problem described in [Issue 1](https://github.com/sebmarkbage/ocamlrun-wasm/issues/1)

### 1d) Lambda -> WASM

I'm not aware of any existing approaches.

#### Related

* **[production-ready]** rawlambda -> JavaScript: https://github.com/BuckleScript/bucklescript

This may or may not be helpful, I do not know. 

  From https://github.com/BuckleScript/bucklescript/blob/master/site/docsource/Differences-from-js_of_ocaml.adoc:

  "Js_of_ocaml focuses more on existing OCaml ecosystem(opam) while BuckleScript’s major goal is to target npm"

  "s_of_ocaml and BuckleScript have slightly different runtime encoding in several places, for example, BuckleScript encodes OCaml Array as JS Array while js_of_ocaml requires its index 0 to be of value 0."

  Overview of the bucklescript compiler: https://github.com/BuckleScript/bucklescript/blob/master/site/docsource/Compiler-overview.adoc

* **[probably abandoned]** the Grain Language -> WASM https://github.com/grain-lang/grain

  Even though the source language used here is not OCaml, there might be some interesting observations in here about compiling a functional language to WASM.

  "Low-level IR, suitable for direct translation into WASM": https://github.com/grain-lang/grain/blob/master/src/codegen/mashtree.ml

## Indirect Roads to WASM

If there was a compiler from OCaml to LLVM, it would immediately enable compilation to WASM.

For compiling machine code to WASM, there apparently do not currently exist any solutions, even though I would have expected that this is an idea that at least some people would consider.
It may be that it is commonly thought (and, possibly, actually true) that machine code is already too highly specialized to the specific architecture it runs on, so that "reverse-compiling" to WASM is unlikely to give good results.
I do not know if this is the case for all architectures.
If there was an architecture whose machine code can be translated to WASM in a reasonably efficient fashion, and it turns out that OCaml already compiles to this architecture, this could be an interesting project.
If successful, this would not only enable compiling OCaml to WASM, but could be helpful for getting many other languages to compile to WASM as well.

### 2a) Cmm -> LLVM

#### Related

* **[abandoned]** https://github.com/whitequark/ocaml-llvm-ng/blob/master/lib/llvmcomp.ml


* **[discussion]** http://caml.inria.fr/pub/ml-archives/caml-list/2009/03/3a77bfcca0f90b763d127d1581d6a2f1.en.html


* **[discussion]** https://discuss.ocaml.org/t/llvm-backend-for-ocaml/1132/5

### 2b) OCaml bytecode -> LLVM

I haven't found anything.

### 2c) optimized machine code -> WASM

I haven't found anything.
