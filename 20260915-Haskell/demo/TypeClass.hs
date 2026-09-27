-- 型クラス。同じ名前の関数を型ごとに違う実装で持たせる、Haskell 流のポリモーフィズム。

class Shape a where
  area :: a -> Double

data Circle = Circle Double

data Rectangle = Rectangle Double Double

instance Shape Circle where
  area (Circle r) = pi * r * r

instance Shape Rectangle where
  area (Rectangle w h) = w * h

describe :: (Shape a, Show a) => a -> String
describe s = show s ++ " の面積は " ++ show (area s)

instance Show Circle where
  show (Circle r) = "半径 " ++ show r ++ " の円"

instance Show Rectangle where
  show (Rectangle w h) = show w ++ "x" ++ show h ++ " の長方形"

main :: IO ()
main = do
  putStrLn (describe (Circle 2))
  putStrLn (describe (Rectangle 3 4))
