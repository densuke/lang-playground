// enum と switch (String(format:) のため Foundation を読み込む)。case を網羅しないとコンパイルが通らない (missing_case.swift 参照)
import Foundation

enum Shape {
    case circle(r: Double)
    case rect(w: Double, h: Double)
    case triangle(Double, Double, Double)
}

func area(_ s: Shape) -> Double {
    switch s {
    case .circle(let r): return Double.pi * r * r
    case .rect(let w, let h): return w * h
    case .triangle(let a, let b, let c):
        let p = (a + b + c) / 2
        return (p * (p - a) * (p - b) * (p - c)).squareRoot()
    }
}

func classify(_ x: Int) -> String {
    switch x {
    case ..<0: return "負"
    case 0: return "ゼロ"
    case let n where n % 2 == 0: return "正の偶数"
    default: return "正の奇数"
    }
}

for s in [Shape.circle(r: 1), .rect(w: 3, h: 4), .triangle(3, 4, 5)] {
    print("面積 \(String(format: "%.3f", area(s)))")
}
for x in [-5, 0, 8, 9] { print("\(x) は \(classify(x))") }
