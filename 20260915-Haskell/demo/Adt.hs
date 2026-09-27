-- パターンマッチと代数的データ型 (ADT)。
-- Maybe 相当の型を自作し、値を分解するときは case で場合分けする。

data Tree a = Leaf | Node (Tree a) a (Tree a)

insert :: Ord a => a -> Tree a -> Tree a
insert x Leaf = Node Leaf x Leaf
insert x t@(Node l y r)
  | x < y = Node (insert x l) y r
  | x > y = Node l y (insert x r)
  | otherwise = t

toList :: Tree a -> [a]
toList Leaf = []
toList (Node l x r) = toList l ++ [x] ++ toList r

data Result a = Ok a | Err String

safeDiv :: Int -> Int -> Result Int
safeDiv _ 0 = Err "0 で割れません"
safeDiv a b = Ok (a `div` b)

showResult :: Show a => Result a -> String
showResult (Ok v) = "Ok: " ++ show v
showResult (Err e) = "Err: " ++ e

main :: IO ()
main = do
  let t = foldr insert Leaf [5, 3, 8, 1, 4 :: Int]
  print (toList t)
  putStrLn (showResult (safeDiv 10 2))
  putStrLn (showResult (safeDiv 10 0))
