open Async.Std

type filename = string
type node     = string
type friends  = node list

let read filename =
  Reader.file_lines filename >>| fun lines ->
  List.map AppUtil.split lines
  |> List.map (fun line ->
      match line with
      | node::friends -> (node, friends)
      | _ -> failwith ("Error: cannot read invalid graph file " ^ filename))

let show common_friends =
  let string_of_friends friends =
    Core.Std.String.concat ~sep:" " (List.sort compare friends)
  in

  List.sort (fun (uv, _) (uv', _) -> compare uv uv') common_friends
  |> List.iter (fun ((u, v), friends) -> printf "%s %s %s" u v (string_of_friends friends))

