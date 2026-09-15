# コンパイル時に走らせる。同じ関数を実行時にも使える。
import std/math

proc fact(n: int): int =
  result = 1
  for i in 2..n: result *= i

const table = block:            # ここは全部コンパイル時
  var t: array[10, int]
  for i in 0..9: t[i] = fact(i)
  t

echo table                      # 実行時には表を引くだけ
static: echo "これはコンパイル中に出る: ", fact(20)
