module Main

import Data.Vect

-- Vect n a は「a が n 個」の並び。結合すると長さは足し算になる。それが型に書ける
append : Vect n a -> Vect m a -> Vect (n + m) a
append []        ys = ys
append (x :: xs) ys = x :: append xs ys

-- 空でないことが型 (S n) でわかるので、firstOf は失敗しない
firstOf : Vect (S n) a -> a
firstOf (x :: _) = x

xs : Vect 2 Int
xs = [1, 2]

ys : Vect 3 Int
ys = [3, 4, 5]

main : IO ()
main = do
  printLn (append xs ys)
  printLn (firstOf (append xs ys))
