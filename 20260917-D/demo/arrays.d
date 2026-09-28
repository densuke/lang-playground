import std.stdio;
import core.exception : RangeError;

void main() {
    // 配列は長さを持っている
    int[] arr = [1, 2, 3];
    writeln("length: ", arr.length);

    // 範囲外の添字は実行時に止まる (C のように隣のメモリを読まない)
    try {
        size_t i = 3;
        writeln(arr[i]);
    } catch (RangeError e) {
        writeln("RangeError: ", e.msg);
    }
}
