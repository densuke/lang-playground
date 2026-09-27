|| 終わりのない平方数の列。必要な分しか計算しないので、無限でも困らない
squares = [ n * n | n <- [1..] ]

main = show (take 10 squares) ++ "\n"
