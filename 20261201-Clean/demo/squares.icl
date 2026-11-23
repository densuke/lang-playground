module squares

import StdEnv

square :: Int -> Int
square x = x * x

// 内包表記と遅延評価。[1..] は終わりのないリストで、先頭の 10 個だけが計算される
Start :: ([Int], [Int])
Start = (map square [1..10], take 10 [x * x \\ x <- [1..] | isEven x])
