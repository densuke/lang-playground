(* signature (仕様) / structure (実装) /
   functor (モジュールを取ってモジュールを返す)。
   この 3 段構えが Standard ML のモジュール機構。 *)

signature ORDERED = sig
  type t
  val compare : t * t -> order
  val toString : t -> string
end;

structure IntOrd : ORDERED = struct
  type t = int
  val compare = Int.compare
  val toString = Int.toString
end;

structure StringOrd : ORDERED = struct
  type t = string
  val compare = String.compare
  val toString = fn s => s
end;

(* 順序が付く型なら何でも受け取れる。
   中身は 1 つしか書いていない *)
functor MakeSet (O : ORDERED) = struct
  type elem = O.t
  type set = elem list

  val empty : set = []

  fun member (x, []) = false
    | member (x, y :: ys) =
        (O.compare (x, y) = EQUAL)
        orelse member (x, ys)

  fun insert (x, s) =
    if member (x, s) then s else x :: s

  fun toString s =
    "{" ^ String.concatWith ", " (List.map O.toString s) ^ "}"
end;

structure IntSet = MakeSet (IntOrd);
structure StringSet = MakeSet (StringOrd);

val a = IntSet.insert (3, IntSet.insert (1, IntSet.empty));
val b = StringSet.insert ("sml", StringSet.empty);

val () = print (IntSet.toString a ^ "\n");
val () = print (StringSet.toString b ^ "\n");
