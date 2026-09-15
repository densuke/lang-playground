# Nim の基本。見た目は Python、動くのはネイティブ。
import std/strutils

echo "Hello, world!"

proc fib(n: int): int =
  if n < 2: n
  else: fib(n-1) + fib(n-2)

var xs: seq[int] = @[]
for i in 0..9: xs.add fib(i)
echo xs

# 型は書かなくても推論される。書くと守られる。
let name = "Nim"
echo name.len, " ", name.toUpperAscii
