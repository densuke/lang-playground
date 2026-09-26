// 自前のエフェクトと、それを処理するハンドラ
effect ask
  ctl ask() : int

// ask を使う関数。型に ask が現れる
fun add-twice() : ask int
  ask() + ask()

// ハンドラ 1: いつも 10 を返す
fun always-ten(action)
  with ctl ask() resume(10)
  action()

// ハンドラ 2: 呼ばれるたびに 1, 2, 3 ... を返す
fun counter(action)
  var n := 0
  with ctl ask()
    n := n + 1
    resume(n)
  action()

fun main()
  println("always 10: " ++ always-ten(add-twice).show)
  println("counter  : " ++ counter(add-twice).show)
