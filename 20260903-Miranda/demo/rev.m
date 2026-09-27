|| パターンマッチでリストを反転する
rev [] = []
rev (a:x) = rev x ++ [a]

main = show (rev [1..5]) ++ "\n" ++ rev "Miranda" ++ "\n"
