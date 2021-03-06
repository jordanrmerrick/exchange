(* 
Limit: tree, each node is a price
Order: doubly-linked list, each item is an order
  - FIFO (fill orders in the order that they are submitted)
    - Given this, we need to be able to remove the tail and add to the front of the list, both in O(1)
    - 2 functions:
      - Dll.push : dll:Dll.t -> node:Dll.Node.t -> unit
      - Dll.pop  : dll:Dll.t -> unit
      
*)

open! Dll
open! Tree
open! Price
open! Oid
open! Core_kernel

module Time_to_fill = struct
  type t = Time_ns.t
  let left t = Time_ns.diff t (Time_ns.now ())
  let can_cancel t = 
    left t
    |> Time_ns.Span.to_int_ms
    |> (fun s -> if s <= 0 then true else false)
end

module type BuySell = sig
  type side = Buy | Sell
  val side : side
end

module Book (X : BuySell) = struct

  type order = 
  { uuid : Oid.t
  ; parent_node : limit Tree.t
  ; size : int
  ; ttf : Time_to_fill.t
  } 

  and limit = 
  { price : Price.t
  ; mutable first_order : order Node.t
  ; mutable last_order  : order Node.t
  ; mutable num_orders  : int
  }

  let change_first_order limit new_order = 
    limit.first_order <- new_order

  let change_last_order limit last_order = 
    limit.last_order <- last_order

  let remove_order orders = 
    Dll.Node.pop orders
    (* TODO: change last_order in limit type *)

  let add_order ~new_order (orders : order Node.t) = 
    Dll.Node.push ~list:orders new_order;
    (* TODO: change first_order in limit type *)
    (* Using Tree.get_value_exn because there's no condition in which *)
    (* the parent node is a leaf *)
    Node.get_value orders 
    |> (fun x -> 
        change_first_order 
        (Tree.get_value_exn x.parent_node)
        new_order
       )

end