// 平方数の表を、コンパイル時に作って埋め込む
const std = @import("std");

const squares = blk: {
    var table: [8]u32 = undefined;
    for (&table, 0..) |*slot, i| slot.* = @intCast(i * i);
    break :blk table;
};

pub fn main() void {
    std.debug.print("{any}\n", .{squares});
}
