module Header : sig

  type t

  val create : unit -> t
  val length : t -> int

  val incr : t -> by:int -> unit

end = struct

  type t = { mutable length : int }
  let create () = { length = 0 }
  let length t = t.length

  let incr t ~by = 
    t.length <- t.length + by

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

end = struct

  type 'a t =
  { value          : 'a
  ; mutable next   : 'a t option
  ; mutable prev   : 'a t option
  ; mutable header : Header.t
  }

  let create_aux value header = { value; next=None; prev=None; header}
  let create value = create_aux value (Header.create ())

  let get_value t = t.value
  let get_next t = t.next
  let get_prev t = t.prev
  let get_header t = t.header

  let set_next t t' = 
    t.next <- Some t'

  let set_prev t t' =
    t.prev <- Some t'

  let set_header t h = 
    t.header <- h

  let push ~list node = 
    set_next node list;
    set_prev list node

  let pop list = 
    match list.prev with
    | None -> ()
    | Some node -> node.next <- None
  
end

type 'a t = 'a Node.t

let length t = t |> Node.get_header |> Header.length
