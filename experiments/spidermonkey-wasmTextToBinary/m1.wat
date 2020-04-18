(gc_feature_opt_in 3)
(module
  (import "shared" "mem" (memory $mem 100))
  (func (result i32)
    (i32.const 0)
    (i32.const 42)
    (i32.store)

    (i32.const 42)
  )
  (export "helloWorld" (func 0))
)
