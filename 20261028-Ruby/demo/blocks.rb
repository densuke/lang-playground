# ブロックとイテレータ。ループは each / map / times / select で書く
squares = (1..5).map { |n| n * n }
p squares
p squares.select(&:even?)
p squares.sum

%w[ruby perl python].each_with_index do |name, i|
  puts "#{i + 1}: #{name.capitalize}"
end

# 自分でブロックを受け取るメソッド
def twice
  yield
  yield
end
twice { puts "はい" }

# 数値も文字列もオブジェクトなので、メソッドをつなげられる
puts (1..10).step(3).map { |n| n.to_s.rjust(3, "0") }.join(",")
