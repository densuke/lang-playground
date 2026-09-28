import std.stdio;

ulong fib(ulong n) {
    return n < 2 ? n : fib(n - 1) + fib(n - 2);
}

// 書き換えられる変数。値が決まるのは実行時
ulong n = 10;

void main() {
    // 実行時の値を使うので、コンパイル時には計算できない
    enum precomputed = fib(n);
    writeln(precomputed);
}
