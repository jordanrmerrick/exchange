(* 
Limit: tree, each node is a price
Order: doubly-linked list, each item is an order
  - FIFO (fill orders in the order that they are submitted)
    - Given this, we need to be able to remove the tail and add to the front of the list, both in O(1)
    - 2 functions:
      - Dll.push : dll:Dll.t -> node:Dll.Node.t -> unit
      - Dll.pop  : dll:Dll.t -> unit
*)

open Dll

module Book = struct

  type t = Dll.t

  let remove_order orders = 
    Dll.Node.pop orders

  let add_order ~new_order orders = 
    Dll.Node.push ~list:orders new_order

end