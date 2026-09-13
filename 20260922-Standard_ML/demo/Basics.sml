(* 型を一度も書いていないのに、型が付く。 *)

fun fib 0 = 0
  | fib 1 = 1
  | fib n = fib (n - 1) + fib (n - 2);

datatype shape = Circle of real | Rect of real * real;

fun area (Circle r) = 3.14159 * r * r
  | area (Rect (w, h)) = w * h;

val () = print "Hello, world!\n";
val () = print (String.concatWith " " (List.map (Int.toString o fib) (List.tabulate (10, fn i => i))) ^ "\n");
val () = print (Real.toString (area (Circle 2.0)) ^ " " ^ Real.toString (area (Rect (3.0, 4.0))) ^ "\n");
