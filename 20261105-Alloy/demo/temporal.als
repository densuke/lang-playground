// Alloy 6 の時相論理: var で時間とともに変わる状態を書く。
// 2 つのプロセスが臨界区間に入る単純なロック。
abstract sig Proc {}
one sig P1, P2 extends Proc {}
var sig Critical in Proc {}   // 臨界区間にいるプロセス
var one sig Lock in Proc {}   // ロックを持つプロセス

fact init { no Critical }

// 入るにはロックが要る。入ったら出るまで他は入れない
pred enter [p: Proc] {
  p = Lock and p not in Critical
  Critical' = Critical + p and Lock' = Lock
}
pred leave [p: Proc] {
  p in Critical and Critical' = Critical - p
  Lock' = Proc - p
}
pred stutter { Critical' = Critical and Lock' = Lock }

fact trans {
  always (some p: Proc | enter[p] or leave[p] or stutter)
}

// 安全性: 同時に 2 つ入らない
check MutualExclusion { always lone Critical } for 4 steps

// 「誰も入らない」は偽。反例は、誰かが入る実行そのもの
check NeverEnters { always no Critical } for 4 steps
