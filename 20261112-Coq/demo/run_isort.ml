(* extract.v が書き出した isort.ml を呼ぶ。リストは OCaml 本来の list になっている。 *)
#use "isort.ml";;
let show xs = "[" ^ String.concat "; " (List.map string_of_int xs) ^ "]"
let () =
  let xs = [5; 2; 9; 1; 5; 6] in
  Printf.printf "入力: %s\n" (show xs);
  Printf.printf "出力: %s\n" (show (isort xs))
