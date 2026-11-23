// 同じ関数を実行時にもコンパイル時にも呼べる
const expectEqual = @import("std").testing.expectEqual;

fn fibonacci(index: u32) u32 {
    if (index < 2) return index;
    return fibonacci(index - 1) + fibonacci(index - 2);
}

test "fibonacci" {
    // 実行時に確かめる
    try expectEqual(13, fibonacci(7));

    // コンパイル時に確かめる
    try comptime expectEqual(13, fibonacci(7));
}
