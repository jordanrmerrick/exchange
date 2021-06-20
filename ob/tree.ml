type 'a t = 
  | Leaf
  | Node of 'a t * 'a * 'a t

let rec insert v ~compare = function
  | Leaf -> Node (Leaf, v, Leaf)
  | Node (l,x,r) -> 
      if compare v x then Node (insert v ~compare l, x, r)
      else Node (l, x, insert v ~compare r)

let of_array arr ~compare = 
  let rec aux acc arr i = 
    if i < 0 then acc 
    else aux (insert arr.(i) ~compare acc) arr (i-1) in
  aux Leaf arr (Array.length arr - 1)

let of_list ls ~compare = 
  let rec aux acc = function
    | [] -> acc
    | x::xs -> aux (insert x ~compare acc) xs
  in
  aux Leaf ls

let rec invert = function
  | Leaf -> Leaf
  | Node (l,x,r) -> Node (invert r, x, invert l)

let rec iter ~f = function
  | Leaf -> ()
  | Node (l,x,r) -> f x; iter ~f l; iter ~f r

let rec map ~f = function
  | Leaf -> Leaf
  | Node (l, x, r) -> Node (map ~f l, f x, map ~f r)

let rec exists t ~f = 
  match t with
  | Leaf -> false
  | Node (l,x,r) -> f x || exists l ~f || exists r ~f