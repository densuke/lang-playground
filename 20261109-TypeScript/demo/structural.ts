// 構造的部分型: 名前ではなく、形で型が合うか決まる
interface Point {
  x: number;
  y: number;
}
function norm(p: Point): number {
  return Math.hypot(p.x, p.y);
}

class Vec {
  constructor(public x: number, public y: number) {}
}
const fromClass = new Vec(3, 4);        // Point と宣言していないが、形が合う
const fromLiteral = { x: 6, y: 8, label: "余分なプロパティ付き" };
console.log(norm(fromClass), norm(fromLiteral));

const onlyX = { x: 1 };
norm(onlyX);                            // y が無い: 形が合わない
