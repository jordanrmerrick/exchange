type 'a t

val insert : 'a -> compare:('a -> 'a -> bool) -> 'a t -> 'a t

val of_array : 'a array -> compare:('a -> 'a -> bool) -> 'a t
val of_list  : 'a list -> compare:('a -> 'a -> bool) -> 'a t

val invert : 'a t -> 'a t

val iter : f:('a -> unit) -> 'a t -> unit
val map : f:('a -> 'b) -> 'b t

val exists : 'a t -> f:('a -> bool) -> bool