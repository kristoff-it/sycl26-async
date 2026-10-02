const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const debug_io = Io.Threaded.global_single_threaded.io();

    std.debug.print("\n# with init.io\n", .{});
    try syncExample(io);
    try asyncExample(io);
    try concurrentExample(io);

    std.debug.print("\n# with single threaded blocking io\n", .{});
    try syncExample(debug_io);
    try asyncExample(debug_io);
    try concurrentExample(debug_io);
}

/// Perform an HTTP GET request that tells you the url of another resource, that you then GET.
fn syncExample(io: Io) !void {
    std.debug.print("\n## synchrony example\n", .{});
    const index_url = "https://ziglang.org/download/index.json";
    const latest_version_url = try fetchJson(io, index_url);

    try downloadFile(io, latest_version_url);
}

fn fetchJson(io: Io, url: []const u8) ![]const u8 {
    std.debug.print("fetching url: {s}...\n", .{url});
    try io.sleep(.fromMilliseconds(200), .awake);
    std.debug.print("fetching url: {s}...done!\n", .{url});

    return "https://ziglang.org/download/0.17.0/zig-bootstrap-0.17.0.tar.xz";
}

fn downloadFile(io: Io, url: []const u8) !void {
    var i: u32 = 0;
    while (i < 5) : (i += 1) {
        std.debug.print("downloading url: {s} {}%\n", .{ url, i * 20 });
        try io.sleep(.fromMilliseconds(200), .awake);
    }
    std.debug.print("downloading url: {s} 100%\n", .{url});
}

/// Download two assets in parallel.
fn asyncExample(io: Io) !void {
    std.debug.print("\n## asynchrony example\n", .{});

    const url_zig16 = "https://ziglang.org/download/0.16.0/zig-bootstrap-0.16.0.tar.xz";
    const url_zig17 = "https://ziglang.org/download/0.17.0/zig-bootstrap-0.17.0.tar.xz";

    var future_zig16 = io.async(downloadFile, .{ io, url_zig16 });
    var future_zig17 = io.async(downloadFile, .{ io, url_zig17 });

    try future_zig16.await(io);
    try future_zig17.await(io);
}

/// Socket server listens and a client connects to it.
fn concurrentExample(io: Io) !void {
    std.debug.print("\n## concurrency example\n", .{});

    const addr = Io.net.IpAddress.parse("127.0.0.1", 0) catch unreachable;
    var server = try addr.listen(io, .{});
    defer server.deinit(io);

    var run_server = try io.concurrent(echoOnceServer, .{ io, &server });
    defer run_server.cancel(io) catch {};

    // client
    {
        const server_addr = server.socket.address;
        const conn = try server_addr.connect(io, .{ .mode = .stream });
        defer conn.close(io);

        var writer_state = conn.writer(io, &.{});
        std.debug.print("client send: \"hello!\"\n", .{});
        try writer_state.interface.writeAll("hello!\n");
    }

    try run_server.await(io);
}

fn echoOnceServer(io: Io, server: *Io.net.Server) !void {
    const conn = try server.accept(io);
    defer conn.close(io);

    var buf: [1024]u8 = undefined;

    var reader_state = conn.reader(io, &buf);
    const r: *Io.Reader = &reader_state.interface;
    const msg = try r.peekDelimiterExclusive('\n');

    std.debug.print("server echo: {s}\n", .{msg});
}
