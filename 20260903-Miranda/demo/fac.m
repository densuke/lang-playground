|| 階乗。掛け算のループを書かずに product ひとつで済ませる
fac n = product [1..n]

main = show (map fac [1..10]) ++ "\n" ++ show (fac 30) ++ "\n"
