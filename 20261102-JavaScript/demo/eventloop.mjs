// イベントループと async/await の実行順
console.log("1: 同期 (開始)");

setTimeout(() => console.log("5: setTimeout 0 (マクロタスク)"), 0);

Promise.resolve().then(() => console.log("3: Promise.then (マイクロタスク)"));
queueMicrotask(() => console.log("4: queueMicrotask"));

(async () => {
  console.log("2: async 関数の await までは同期で走る");
  await null;
  console.log("4.5: await の続きはマイクロタスク");
})();

console.log("2.9: 同期 (終了)");
