-- 遅延評価と無限リスト。
-- Haskell の値は使われるまで計算されないので、無限に長いリストがふつうに定義できる。

primes :: [Integer]
primes = sieve [2 ..]
  where
    sieve (p : xs) = p : sieve [x | x <- xs, x `mod` p /= 0]

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

main :: IO ()
main = do
  print (take 10 primes)
  print (take 10 fibs)
