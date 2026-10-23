// 命題: 「対称で推移的な関係は反射的である」 (正しそうに見えるが偽)
sig Node { rel: set Node }

pred symmetric   { rel = ~rel }
pred transitive  { rel.rel in rel }
pred reflexive   { iden & (Node->Node) in rel }

// 小さな範囲で反例が見つかる (自己ループのない孤立点が 1 つあればよい)
check SymTransImpliesRefl {
  (symmetric and transitive) implies reflexive
} for 3 Node

// こちらは真: 逆の逆は元に戻る。範囲 6 までに反例なし
check InverseTwice { all r: Node -> Node | ~(~r) = r } for 6 Node
