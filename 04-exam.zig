const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const debug_io = Io.Threaded.global_single_threaded.io();

    // This is fine...
    std.debug.print("with init.io:\n", .{});
    doWorkWithSpinner(io);

    // This not so much ...
    std.debug.print("with single threaded io:\n", .{});
    doWorkWithSpinner(debug_io);
}

fn doWorkWithSpinner(io: Io) void {
    var work_future = io.async(doABunchOfWork, .{});
    var spinner_future = io.async(doSpinnerLoop, .{io});

    const answer = work_future.await(io);
    spinner_future.cancel(io) catch {};

    std.debug.print("answer: {}\n", .{answer});
}

fn doSpinnerLoop(io: Io) Io.Cancelable!void {
    defer std.debug.print("\r \r", .{});
    var i: u64 = 0;
    while (true) : (i += 1) {
        std.debug.print("\r{c}", .{"\\|/-"[i % 4]});
        try io.sleep(.fromNanoseconds(300_000_000), .awake);
    }
}

fn doABunchOfWork() u64 {
    var result: u64 = 0;
    for (0..100_000) |i| {
        for (0..100_000) |j| {
            if (@popCount(i) == @popCount(j)) {
                result += 1;
            }
        }
    }
    return result;
}
