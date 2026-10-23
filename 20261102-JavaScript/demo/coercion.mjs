// 型変換の癖
console.log(typeof null, typeof NaN, typeof [], typeof function () {});
console.log(1 + "2", "3" - 1, [] + [], [] + {});
console.log(0.1 + 0.2, 0.1 + 0.2 === 0.3);
console.log(NaN === NaN, Object.is(NaN, NaN));
console.log(null == undefined, null == 0, "" == 0, "0" == false, [] == false);
console.log(["10", "9", "1"].sort(), [10, 9, 1].sort(), [10, 9, 1].sort((x, y) => x - y));
console.log(["1", "2", "3"].map(parseInt)); // 第2引数が基数になる
console.log(9007199254740993, 2 ** 53 + 1, 9007199254740993n + 1n);
