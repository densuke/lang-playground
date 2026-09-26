# if も for も、実は特別扱いされていないただのコマンド。
# 同じ土俵で「新しい制御構造」を自作できる。
#
# body を素朴に [uplevel] すると、body の中で作った変数は proc の中に閉じ込
# められる。呼び出し元のスコープで実行したいので uplevel 1 を使う。
proc repeat {n body} {
    for {set i 0} {$i < $n} {incr i} { uplevel 1 $body }
}

repeat 3 { puts "again" }

# uplevel と対になるのが upvar: 呼び出し元の変数を「同じ変数」として触る。
proc increment {varName} {
    upvar 1 $varName v
    incr v
}
set counter 0
repeat 5 { increment counter }
puts "counter = $counter"
