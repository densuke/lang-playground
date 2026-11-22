// メモリ確保はアロケータを引数で渡す。隠れた確保はない
const std = @import("std");

fn repeat(allocator: std.mem.Allocator, ch: u8, n: usize) ![]u8 {
    const buf = try allocator.alloc(u8, n);
    @memset(buf, ch);
    return buf;
}

pub fn main() !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const line = try repeat(allocator, '=', 20);
    defer allocator.free(line);
    std.debug.print("{s}\n", .{line});
}
