let f (a : int) (b: int -> int -> int) (c:int) = b (a + 13)

let g = f 42 (+)