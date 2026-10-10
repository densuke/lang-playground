module Main

import Data.Vect

-- n = 0 の場合を書き忘れた。total を付けたので、コンパイラが見逃さない
total
firstOf : Vect n a -> a
firstOf (x :: _) = x
