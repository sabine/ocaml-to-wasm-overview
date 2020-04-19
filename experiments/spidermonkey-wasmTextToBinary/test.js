function loadWat(fileName) {
  var t = read(fileName);
  console.log(t);
  var b = wasmTextToBinary(t);
  var module = new WebAssembly.Module(b);
  return new WebAssembly.Instance(module, {});
};

var instance = loadWat('m1.wat');
console.log(instance.exports.helloWorld());
