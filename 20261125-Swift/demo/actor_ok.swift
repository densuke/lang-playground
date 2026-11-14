// data_race.swift の直し方の一例: actor に閉じ込めると、書き換えは 1 度に 1 つだけになる
actor Counter {
    private var value = 0
    func increment() { value += 1 }
    func current() -> Int { value }
}

let counter = Counter()
await withTaskGroup(of: Void.self) { group in
    for _ in 0..<100 {
        group.addTask { await counter.increment() }
    }
}
print("カウンタ = \(await counter.current())")
