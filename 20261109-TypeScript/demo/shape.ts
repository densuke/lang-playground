// 形が合えば、渡せる (収録用の短い版。詳しくは structural.ts)
interface Point { x: number; y: number }
class Vec { x = 3; y = 4 }
function norm(p: Point): number {
  return Math.hypot(p.x, p.y);
}
console.log(norm(new Vec()));   // Vec は Point と宣言していない
console.log(norm({ x: 6, y: 8 }));
norm({ x: 1 });                 // y が無い
