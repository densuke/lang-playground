module nfib

import StdEnv

nfib :: Int -> Int
nfib 0 = 1
nfib 1 = 1
nfib n = 1 + nfib (n - 1) + nfib (n - 2)

Start :: Int
Start = nfib 38
