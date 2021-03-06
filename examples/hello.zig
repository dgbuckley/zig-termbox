const std = @import("std");

const termbox = @import("termbox");
const Termbox = termbox.Termbox;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;

    var t = try Termbox.init(allocator);
    defer t.shutdown() catch {};

    var anchor = t.back_buffer.anchor(1, 1);
    try anchor.writer().print("Hello {}!", .{"World"});

    anchor.move(1, 2);
    try anchor.writer().print("Press any key to quit", .{});

    try t.present();

    _ = try t.pollEvent();
}
