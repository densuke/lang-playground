// クラスではなくプロトタイプ
const animal = { speak() { return `${this.name} は鳴く`; } };
const dog = Object.create(animal);
dog.name = "ポチ";
console.log(dog.speak());
console.log(Object.getPrototypeOf(dog) === animal, Object.hasOwn(dog, "speak"));

// 後から足すと既存のオブジェクトにも効く
animal.sleep = function () { return `${this.name} は寝る`; };
console.log(dog.sleep());

// class 構文 (ES2015) は prototype の上の書き方
class Cat { constructor(name) { this.name = name; } speak() { return `${this.name}: にゃあ`; } }
const tama = new Cat("タマ");
console.log(tama.speak(), typeof Cat, Object.getPrototypeOf(tama) === Cat.prototype);
console.log(Object.getOwnPropertyNames(Cat.prototype));

// 組み込みも開ける (やりすぎ注意)
Array.prototype.last = function () { return this[this.length - 1]; };
console.log([1, 2, 3].last());
