// 手本の Jackson 本の例を縮めたもの: 追加して削除すれば元に戻る、は本当か?
sig Name, Addr {}
sig Book { addr: Name -> lone Addr }

pred add [b, b2: Book, n: Name, a: Addr] { b2.addr = b.addr + n -> a }
pred del [b, b2: Book, n: Name]          { b2.addr = b.addr - n -> Addr }

// 追加してから削除すると元に戻る? (n が既に登録済みなら戻らない)
check AddThenDel {
  all b, b2, b3: Book, n: Name, a: Addr |
    add[b, b2, n, a] and del[b2, b3, n] implies b.addr = b3.addr
} for 3
