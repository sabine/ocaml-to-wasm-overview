(module 
  (type $t (func))
  (type $load (func (result i32)))
  (type $store (func (param i32)))
  (import "imports" "sayHello" (func $imports.sayHello (type $t)))
  (import "imports" "loadArray" (func $imports.loadArray (type $load)))
  (import "imports" "storeArray" (func $imports.storeArray (type $store)))

  (global $g (mut i32) (i32.const 0))

  (func $noop (param $i i32)
        (get_local $i)
        (return)
  )

  (func $loop (param $i i32)
    (block
    (loop
      (get_local $i)
      (i32.const 1)
      (i32.sub)
      (set_local $i)

      (get_local $i)
      (i32.const 1)
      (i32.lt_s)
      (br_if 1)
      (br 0)
    ))
  )

  (func $callJS (param $i i32)
    (block
    (loop
      (block
        (get_local $i)
        (i32.const 1)
        (i32.sub)
        (set_local $i)
      )

      (call $imports.sayHello)

      (get_local $i)
      (i32.const 1)
      (i32.lt_s)
      (br_if 1)
      (br 0)
    ))
  )

  (func $storeAndLoadMem (param $i i32)
    (local $val i32)

    (block
    (loop
      (block
        (i32.const 22)
        (get_local $val)
        (i32.store)

        (get_local $i)
        (i32.const 1)
        (i32.sub)
        (set_local $i)
      )

;;      (call $imports.sayHello)

      (block
        (i32.const 22)
        (i32.load)
        (i32.const 1)
        (i32.add)
        (set_local $val)
      )

      (get_local $i)
      (i32.const 1)
      (i32.lt_s)
      (br_if 1)
      (br 0)
    ))
  )

  (func $storeAndLoadLocal (param $i i32)
    (local $val i32)
    (local $x i32)

    (block
    (loop
      (block
        (get_local $val)
        (set_local $x)

        (get_local $i)
        (i32.const 1)
        (i32.sub)
        (set_local $i)
      )

;;      (call $imports.sayHello)

      (block
        (get_local $x)
        (i32.const 1)
        (i32.add)
        (set_local $val)
      )

      (get_local $i)
      (i32.const 1)
      (i32.lt_s)
      (br_if 1)
      (br 0)
    ))
  )

  (func $storeAndLoadGlobal (param $i i32)
    (local $val i32)

    (block
    (loop
      (block
        (get_local $val)
        (set_global $g)

        (get_local $i)
        (i32.const 1)
        (i32.sub)
        (set_local $i)
      )

;;      (call $imports.sayHello)

      (block
        (get_global $g)
        (i32.const 1)
        (i32.add)
        (set_local $val)
      )

      (get_local $i)
      (i32.const 1)
      (i32.lt_s)
      (br_if 1)
      (br 0)
    ))
  )

  (func $storeAndLoadJS (param $i i32)
    (local $val i32)

    (block
    (loop
      (block
        (get_local $val)
        (call $imports.storeArray)

        (get_local $i)
        (i32.const 1)
        (i32.sub)
        (set_local $i)
      )

;;      (call $imports.sayHello)

      (block
        (call $imports.loadArray)
        (i32.const 1)
        (i32.add)
        (set_local $val)
      )

      (get_local $i)
      (i32.const 1)
      (i32.lt_s)
      (br_if 1)
      (br 0)
    ))
  )

  (export "noop" (func $noop))
  (export "loop" (func $loop))
  (export "callJS" (func $callJS))
  (export "storeAndLoadMem" (func $storeAndLoadMem))
  (export "storeAndLoadLocal" (func $storeAndLoadLocal))
  (export "storeAndLoadGlobal" (func $storeAndLoadLocal))
  (export "storeAndLoadJS" (func $storeAndLoadJS))

  (memory $mem 20)
  (export "mem" (memory $mem))

)


