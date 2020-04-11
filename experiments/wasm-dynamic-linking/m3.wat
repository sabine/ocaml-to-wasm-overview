(module
  (type $t (func (result i32)))
  (import "m2" "add_one" (func $m2.add_one (type $t)))


  (func $go (result i32)
       (call $m2.add_one)
  )

  (export "go" (func $go))
)
