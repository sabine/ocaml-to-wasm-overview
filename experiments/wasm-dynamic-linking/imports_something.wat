(module
  (type $t (func (result i32)))
  (import "imports" "helloWorld" (func $imports.helloWorld (type $t)))

  (func $add_one (result i32)
       (call $imports.helloWorld)
       (i32.const 1)
       (i32.add)
  )

  (export "add_one" (func $add_one))
)
