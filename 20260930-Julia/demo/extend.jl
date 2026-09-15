# 自分の型を言語側の演算子に混ぜる。既存の関数に実装を足すだけ。
struct Money
    yen::Int
end

import Base: +, *, show
+(a::Money, b::Money) = Money(a.yen + b.yen)
*(n::Int, m::Money)   = Money(n * m.yen)
show(io::IO, m::Money) = print(io, m.yen, " 円")

println(Money(300) + Money(120))
println(3 * Money(150))
println(sum([Money(100), Money(200), Money(50)]))   # sum もそのまま通る
