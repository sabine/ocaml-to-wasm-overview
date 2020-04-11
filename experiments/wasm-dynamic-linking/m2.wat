(module
  (type $t (func (result i32)))
  (import "m1" "helloWorld" (func $m1.helloWorld (type $t)))

  (func $add_one (result i32)
       (call $m1.helloWorld)
       (i32.const 1)
       (i32.add)
  )

  (export "add_one" (func $add_one))
)
