// 型エラーを、実行する前に (コンパイル時に) 捕まえる
function area(width: number, height: number): number {
  return width * height;
}

area(3, "4");          // 文字列は number ではない
area(3);               // 引数が足りない

const user = { name: "Ada", age: 36 };
console.log(user.nmae); // タイプミスも見つかる

let id: number = 1;
id = "one";            // 後から別の型は入らない
