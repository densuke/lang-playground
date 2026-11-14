// Hello World
let name = "Swift"
print("Hello, world!")
print("\(name) の名前は \(name.count) 文字")
#if os(Linux)
print("ここは Linux (Apple のフレームワークは使えない)")
#endif
