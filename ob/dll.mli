module Header : sig

    type t
  
    val create : unit -> t
    val length : t -> int
  
    val incr : t -> by:int -> unit
end

module Node : sig

    type 'a t

    val create : 'a -> 'a t
  
    val set_next : 'a t -> 'a t -> unit
    val set_prev : 'a t -> 'a t -> unit
    val set_header : 'a t -> Header.t -> unit
  
    val get_next : 'a t -> 'a t option
    val get_prev : 'a t -> 'a t option
    val get_value : 'a t -> 'a
    val get_header : 'a t -> Header.t
  
    val push : list:'a t -> 'a t -> unit
    val pop : 'a t -> unit
  
end

type 'a t
val length : 'a t -> int
