// 配列の範囲外アクセス。未定義動作にならず、その場で実行が止まる
let xs = [10, 20, 30]
print("xs[2] = \(xs[2])")
let i = Int(CommandLine.arguments.count) + 4 // 実行時に決まる (5)
print("xs[\(i)] を読みます")
print(xs[i])
print("ここには来ない")
