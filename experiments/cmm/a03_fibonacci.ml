let rec fibonacci n =
    if n < 3 then
      1
    else
      fibonacci (n-1) + fibonacci (n-2)

