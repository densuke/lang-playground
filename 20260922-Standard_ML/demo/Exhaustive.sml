(* 場合分けの書き忘れを、実行前に指摘してくれる。 *)

datatype color = R | G | B;

(* B を書き忘れている。コンパイル時に警告が出る *)
fun name R = "red"
  | name G = "green";
