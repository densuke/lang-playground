// 型は実行前に消える。残るのは普通の JavaScript
interface Greeter {
  greet(name: string): string;
}

const english: Greeter = {
  greet(name: string): string {
    return `Hello, ${name}!`;
  },
};

type Id = number | string;
const show = (id: Id): string => `id=${id}`;

console.log(english.greet("TypeScript"), show(7));
