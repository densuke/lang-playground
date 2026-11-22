// 階乗を u8 で計算する。comptime で呼ぶと、あふれはコンパイル時に見つかる
const std = @import("std");

fn factorial(n: u8) u8 {
    var result: u8 = 1;
    var i: u8 = 2;
    while (i <= n) : (i += 1) result *= i;
    return result;
}

pub fn main() void {
    const big = comptime factorial(6); // 720 は u8 に収まらない
    std.debug.print("{}\n", .{big});
}
