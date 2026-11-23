// 古い記事によくある書き方。0.17.1 では std.io が無く、コンパイルが通らない
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, World!\n", .{});
}
