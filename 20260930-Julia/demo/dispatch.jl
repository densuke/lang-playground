# 多重ディスパッチ。どの実装を呼ぶかを引数の型の組で決める。
abstract type Shape end
struct Circle <: Shape; r::Float64 end
struct Square <: Shape; a::Float64 end

area(s::Circle) = pi * s.r^2
area(s::Square) = s.a^2

# 組み合わせごとに別の実装を書ける。第1引数だけで決まらない
collide(a::Circle, b::Circle) = "円と円"
collide(a::Circle, b::Square) = "円と四角"
collide(a::Shape,  b::Shape)  = "その他"

println(area(Circle(1)), " ", area(Square(2)))
println(collide(Circle(1), Square(2)))
println(collide(Square(1), Square(2)))
println(length(methods(collide)), " 個の実装")
