// Perceus: 参照カウントが 1 のセルは、作り直さずに「その場で」使い回される
fun inc-all(xs : list<int>) : list<int>
  match xs
    Cons(x, rest) -> Cons(x + 1, inc-all(rest))   // 古い Cons を新しい Cons に再利用
    Nil           -> Nil

fun main()
  val xs = list(1, 1000000)
  val ys = inc-all(xs)            // xs はここが最後の利用 -> 参照カウント 1 のまま渡る
  println(ys.take(3).show ++ " ... 要素数 " ++ ys.length.show)
