import std.stdio;

// 普通の関数だが、コンパイル時にも実行できる
ulong fib(ulong n) {
    return n < 2 ? n : fib(n - 1) + fib(n - 2);
}

// pragma(msg) はコンパイル中にメッセージを出す。ここで fib(30) が走っている証拠になる
pragma(msg, "compile time: fib(30) = ", fib(30));

void main() {
    // enum に入れるとコンパイル時に計算される
    enum precomputed = fib(30);
    writeln(precomputed);

    // 実行時にも同じ関数を使える
    writeln(fib(10));
}
