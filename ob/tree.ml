type 'a t = 
  | Leaf
  | Node of { left : 'a t; value : 'a; right : 'a t }

let rec insert v ~equals = function
  | Leaf -> Node {left = Leaf; value = v; right = Leaf }
  | Node {left; value; right} -> 
      if equals v value then Node
      { left = insert value ~equals left
      ; value
      ; right
      }
      else Node
      { left
      ; value
      ; right = insert v ~equals right
      }

let of_array arr ~equals = 
  let rec aux acc arr i = 
    if i < 0 then acc 
    else aux (insert arr.(i) ~equals acc) arr (i-1) in
  aux Leaf arr (Array.length arr - 1)

let of_list ls ~equals = 
  let rec aux acc = function
    | [] -> acc
    | x::xs -> aux (insert x ~equals acc) xs
  in
  aux Leaf ls

let rec invert = function
  | Leaf -> Leaf
  | Node {left; value; right} -> 
    Node {left = invert right; value; right = invert left}

let rec iter ~f = function
  | Leaf -> ()
  | Node {left; value; right} -> f value; iter ~f left; iter ~f right

let rec map ~f = function
  | Leaf -> Leaf
  | Node {left; value; right} -> 
    Node 
    { left = map ~f left
    ; value = f value
    ; right = map ~f right
    }

let rec exists t ~f = 
  match t with
  | Leaf -> false
  | Node {left; value; right} -> f value || exists left ~f || exists right ~f

let get_value t = 
  match t with
  | Leaf -> None
  | Node { value; _ } -> Some value

let get_value_exn t = 
  match t with
  | Leaf -> failwith "No value found"
  | Node { value; _ } -> value