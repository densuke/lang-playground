// Hello World とフィボナッチ
fun fib(n : int) : div int   // 再帰は停止しないかもしれない (div) と型に出る
  if n < 2 then n else fib(n - 1) + fib(n - 2)

fun main()
  println("Hello, world!")
  println("fib: " ++ list(0, 9).map(fib).map(show).join(" "))
