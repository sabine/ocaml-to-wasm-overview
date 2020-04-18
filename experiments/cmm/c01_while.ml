let b = ref 10

let _ = while !b > 0 do
  b := !b - 1
done

let a = while !b > 0 do
  b := !b - 1
done

