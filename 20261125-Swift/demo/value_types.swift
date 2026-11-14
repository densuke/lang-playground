// 値型 (struct) はコピーされる。参照型 (class) は同じものを指す
struct PointValue { var x = 0 }
final class PointRef { var x = 0 }

var a = PointValue()
var b = a          // コピー
b.x = 10
print("struct: a.x = \(a.x), b.x = \(b.x)")

let c = PointRef()
let d = c          // 同じオブジェクト
d.x = 10
print("class : c.x = \(c.x), d.x = \(d.x)")

// 配列も値型。別の変数に入れて書き換えても元は変わらない
let xs = [1, 2, 3]
var ys = xs
ys.append(4)
print("xs = \(xs), ys = \(ys)")
