const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var group: Io.Group = .init;

    // Spawn 5 sleepy tasks and let them complete (sleep for 2 seconds).
}

fn sleepy(io: Io, secs: i64) void {
    std.debug.print("{x} starting sleep!\n", .{@intFromPtr(&secs)});
    io.sleep(.fromSeconds(secs), .awake) catch {
        std.debug.print("{x} canceled!\n", .{@intFromPtr(&secs)});
    };
    std.debug.print("{x} done sleeping!\n", .{@intFromPtr(&secs)});
}