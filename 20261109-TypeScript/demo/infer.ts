// 型推論: 注釈を書かなくても、型は決まっている
export const answer = 42;
export const names = ["Ada", "Alan", "Grace"];
export const lengths = names.map((n) => n.length);
export const first = names.find((n) => n.startsWith("G"));
export const pair = { id: 1, tags: ["a", "b"] };

export function double(n: number) {
  return n * 2;
}
export const fetchAge = async () => 36;

// 絞り込み: typeof で分岐すると、その枝の中で型が狭まる
export function show(x: string | number) {
  if (typeof x === "string") return x.toUpperCase();
  return x.toFixed(1);
}
