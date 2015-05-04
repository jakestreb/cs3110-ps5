open Async.Std
open AppUtil
open Hashtbl

module Job = struct

  type input = string
  type key = string
  type intermediate = int
  type output = int

  let name (string) = "word_count"
  
  let map (ws : input) : (key * intermediate) list Deferred.t =
    let words = split ws in
    let rec update_output (word : key) out_prec (out:(key * intermediate) list) : (key * intermediate) list =
      match out with
      | []                      -> out_prec@[(word,1)]
      | (k,v)::tl when k = word -> out_prec@[(k,v+1)]@tl
      | hd::tl                  -> update_output word (out_prec@[hd]) tl in
    let rec map_helper (words : key list) (out:(key * intermediate) list) : (key * intermediate) list =
      match words with
      | []     -> []
      | hd::tl -> (update_output hd [] out) @ (map_helper tl out) in
    return (map_helper words [])

  let reduce (item:(key * intermediate list)) : output Deferred.t =
    match item with
    | (k,l) -> return (List.fold_left (fun a b -> a + b) 0 l)

end

