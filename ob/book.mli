open! Core_kernel
open! Tree
open! Dll

module Time_to_fill : sig
  type t

  val left : t -> Time_ns.Span.t
  val can_cancel : t -> bool
end

module type BuySell = sig
  type side = Buy | Sell
  val side : side
end

module Book (X : BuySell) : sig
  type order and limit

  val remove_order : order Node.t -> unit
  val add_order    : new_order:order Node.t -> order Node.t -> unit
end