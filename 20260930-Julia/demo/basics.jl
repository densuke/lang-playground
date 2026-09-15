# Julia の基本。書き方は Python 寄り、実行は型ごとに機械語へ。
println("Hello, world!")

fib(n) = n < 2 ? n : fib(n-1) + fib(n-2)
println([fib(i) for i in 0:9])

# 配列と行列が言語の一部。. を付けると要素ごとに効く。
A = [1 2; 3 4]
println(A * A)
println(sqrt.([1, 4, 9]))
