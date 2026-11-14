// 失敗することが目的: switch の網羅漏れはコンパイルエラー
enum Light { case red, yellow, green }

func next(_ l: Light) -> String {
    switch l {
    case .red: return "青へ"
    case .green: return "黄へ"
    }
}
print(next(.red))
