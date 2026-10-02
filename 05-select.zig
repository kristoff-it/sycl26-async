const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    // const debug_io = std.Io.Threaded.global_single_threaded.io();

    // Select lets you unblock the moment a future (of many) completes.
    const Select = Io.Select(union(enum) {
        weatherio: u64, // fahrenheit
        weatherly: f64, // celsius
        weatherai: u64, // fahrenheit, sometimes
    });

    var buf: [3]Select.Union = undefined;
    var select: Select = .init(io, &buf);
    defer select.cancelDiscard();

    select.async(.weatherio, getWeatherio, .{ io, "Vancouver BC" });
    select.async(.weatherly, getWeatherly, .{ io, "Vancouver BC" });
    select.async(.weatherai, getWeatherai, .{ io, "Vancouver BC" });

    // How can we report the first answer that comes in and cancel the rest?
}

fn getWeatherio(io: Io, location: []const u8) u64 {
    var rand: [1]u8 = undefined;
    io.random(&rand);

    std.debug.print("get {s} temps from weatherio...\n", .{location});
    io.sleep(.fromSeconds(rand[0] % 3), .awake) catch return 0;
    std.debug.print("-> weatherio replied\n", .{});
    return 60;
}

fn getWeatherly(io: Io, location: []const u8) f64 {
    var rand: [1]u8 = undefined;
    io.random(&rand);

    std.debug.print("get {s} temps from weatherly...\n", .{location});
    io.sleep(.fromSeconds(rand[0] % 3), .awake) catch return 0;
    std.debug.print("-> weatherly replied\n", .{});
    return 15.5;
}

fn getWeatherai(io: Io, location: []const u8) u64 {
    var rand: [1]u8 = undefined;
    io.random(&rand);

    std.debug.print("get {s} temps from weatherai...\n", .{location});
    io.sleep(.fromSeconds(100), .awake) catch return 0;
    std.debug.print("-> weatherai replied\n", .{});

    return rand[0];
}

fn showTemperature(t: u64) void {
    std.debug.print("temperature is {}f\n", .{t});
}
