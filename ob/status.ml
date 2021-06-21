type t = 
  | Open
  | Filled
  | Cancl
  | Cancl_repl
  | Rejected

let to_string = function
  | Open       -> "open"
  | Filled     -> "filled"
  | Cancl      -> "cancl"
  | Cancl_repl -> "cancl_repl"
  | Rejected   -> "rejected"

