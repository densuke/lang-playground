// 関係でモデルを書く。sig は集合、フィールドは関係。
sig Person {
  parent: set Person
}

// 自分自身は親にならず、祖先をたどっても自分に戻らない
fact NoCycle { no p: Person | p in p.^parent }

// 祖父母を持つ人がいる例を探す (範囲は Person 4 つまで)
pred hasGrandparent { some p: Person | some p.parent.parent }

run hasGrandparent for 4 Person
