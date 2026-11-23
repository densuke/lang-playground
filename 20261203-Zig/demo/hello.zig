// Hello World (Zig 0.17.1 の書き方)。出力に使う io は main の引数から受け取る
const std = @import("std");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");
}
