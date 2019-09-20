type fruit =
        | Apple
        | Orange
        | Kiwi


let f (a : int) (b: int -> string) (c:int) = b (a + 13)

let g = f 42

let e x = match x with
        | Apple -> f 100
        | Orange -> f 200
        | Kiwi -> f 300

