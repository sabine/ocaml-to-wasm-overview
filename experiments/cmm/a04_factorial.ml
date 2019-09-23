
let rec fac n =
  if n > 1 then n * fac (n-1) else 1

let rec fac_tr n acc =
  if n > 1 then fac_tr (n-1) (acc*n) else 1

