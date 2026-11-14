// 失敗することが目的: Swift 6 言語モードのデータ競合検査。
// 複数のタスクから同じ var を書き換えるコードはコンパイルが通らない
var counter = 0

func run() async {
    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<100 {
            group.addTask { counter += 1 }
        }
    }
    print(counter)
}

await run()
