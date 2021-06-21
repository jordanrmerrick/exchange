module Sign = struct
  type t = Neg | Pos
end

type t = 
{ value : int }

let real t = float_of_int t.value /. 10000.0
let get_sign t = 
  if t.value >= 0 then Sign.Pos else Sign.Neg