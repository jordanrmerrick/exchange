type 'a t

val insert : 'a -> equals:('a -> 'a -> bool) -> 'a t -> 'a t

val of_array : 'a array -> equals:('a -> 'a -> bool) -> 'a t
val of_list  : 'a list -> equals:('a -> 'a -> bool) -> 'a t

val invert : 'a t -> 'a t

val iter : f:('a -> unit) -> 'a t -> unit
val map : f:('a -> 'b) -> 'a t -> 'b t

val exists : 'a t -> f:('a -> bool) -> bool

val get_value : 'a t -> 'a option
val get_value_exn : 'a t -> 'a