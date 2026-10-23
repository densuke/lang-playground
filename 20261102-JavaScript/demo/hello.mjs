// 第一級関数とクロージャ
console.log("Hello, world!");

const makeCounter = () => {
  let count = 0; // 外から触れない。関数が閉じ込める
  return () => ++count;
};
const a = makeCounter();
const b = makeCounter();
console.log(a(), a(), a(), b());

// 関数は値。引数にも戻り値にもなる
const compose = (...fns) => (x) => fns.reduceRight((v, f) => f(v), x);
const inc = (n) => n + 1;
const dbl = (n) => n * 2;
console.log(compose(dbl, inc)(5)); // dbl(inc(5)) = 12

// var と let のクロージャの違い (有名な罠)
const withVar = [], withLet = [];
for (var i = 0; i < 3; i++) withVar.push(() => i);
for (let j = 0; j < 3; j++) withLet.push(() => j);
console.log(withVar.map((f) => f()), withLet.map((f) => f()));
