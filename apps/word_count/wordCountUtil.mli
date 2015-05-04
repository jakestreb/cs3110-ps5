open Async.Std

type filename = string
type word     = string
type line     = string

(* [read filename] reads the contents of [filename] into a list of lines. *)
val read:  filename -> line list Deferred.t

(* [show word_counts] pretty prints [word_counts] to standard out. The output is
 * printed with words in increasing lexicographic order. The word and its count
 * are separated by a single space. *)
val show: (word * int) list -> unit
