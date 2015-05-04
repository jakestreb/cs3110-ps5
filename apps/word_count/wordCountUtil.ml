open Async.Std

type filename = string
type word     = string
type line     = string

let read filename =
  Reader.file_lines filename

let show word_counts =
  let word_counts = List.sort (fun (w1, _) (w2, _) -> compare w1 w2) word_counts in
  List.iter (fun (w, c) -> printf "%s %d" w c) word_counts


