(module 
  (type $sayHelloT (func))
  (import "imports" "sayHello" (func $imports.sayHello (type $sayHelloT)))

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


  (func $storeSomething (param $addr i32) (param $x i32)
    (i32.store (get_local $addr) (get_local $x))
  )

  (func $loadSomething (param $addr i32) (result i32)
    (i32.load (get_local $addr))
    (return)
  )

  (func $storeAndLoadMem (param $i i32)
    (local $val i32)

    (block
    (loop
      (block
        (i32.const 22)
        (get_local $val)
        (call $storeSomething)

        (get_local $i)
        (i32.const 1)
        (i32.sub)
        (set_local $i)
      )

      (call $imports.sayHello)

      (block
        (i32.const 22)
        (call $loadSomething)
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

      (call $imports.sayHello)

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

  (export "loop" (func $loop))
  (export "callJS" (func $callJS))
  (export "storeAndLoadMem" (func $storeAndLoadMem))
  (export "storeAndLoadLocal" (func $storeAndLoadLocal))

  (memory $mem 20)
  (export "mem" (memory $mem))

)


