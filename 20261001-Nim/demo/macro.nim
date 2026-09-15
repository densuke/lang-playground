# マクロは構文木を組み立てる。Lisp と同じことを中置構文でやる。
import std/macros

macro twice(body: untyped): untyped =
  # 渡された文を 2 回並べた木を返す
  result = newStmtList(body, body)

twice: echo "2 回出る"

macro showTree(x: untyped): untyped =
  echo "構文木: ", x.treeRepr    # コンパイル中に木を覗く
  result = x

showTree: echo 1 + 2
