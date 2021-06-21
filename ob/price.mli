module Sign : sig
  type t
end

type t

val real : t -> float
val get_sign : t -> Sign.t