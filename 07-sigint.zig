const builtin = @import("builtin");
const std = @import("std");
const Io = std.Io;

const server_log = std.log.scoped(.server);

var shutdown_event_io: Io = undefined;
var shutdown_event: Io.Event = .unset;
pub fn main(init: std.process.Init) !void {
    shutdown_event_io = init.io;
    switch (builtin.target.os.tag) {
        .linux, .macos => {
            const posix = std.posix;
            const act: posix.Sigaction = .{
                .handler = .{
                    .handler = struct {
                        fn handler(_: posix.SIG) callconv(.c) void {
                            server_log.info("received SIGINT", .{});
                            shutdown_event.set(shutdown_event_io);
                        }
                    }.handler,
                },
                .mask = posix.sigemptyset(),
                .flags = 0,
            };
            posix.sigaction(.INT, &act, null);
        },
        .windows => {
            const win = std.os.windows;
            const Impl = struct {
                const HANDLER_ROUTINE = *const fn (
                    dwCtrlType: std.os.windows.DWORD,
                ) callconv(.winapi) std.os.windows.BOOL;

                extern "kernel32" fn SetConsoleCtrlHandler(
                    HandlerRoutine: ?HANDLER_ROUTINE,
                    Add: std.os.windows.BOOL,
                ) callconv(.winapi) std.os.windows.BOOL;

                fn handler(crtl_type: win.DWORD) callconv(.winapi) win.BOOL {
                    const CTRL_C_EVENT: std.os.windows.DWORD = 0;
                    switch (crtl_type) {
                        CTRL_C_EVENT => {
                            shutdown_event.set(shutdown_event_io);
                            return .TRUE;
                        },
                        else => return .FALSE,
                    }
                }
            };

            if (Impl.SetConsoleCtrlHandler(&Impl.handler, .TRUE).toBool()) {
                server_log.err("unable to setup ctrl+c handler, continuing anyway", .{});
            }
        },
        else => server_log.err(
            "ctrl+c handler for this platform was not implemented, " ++
                "consider adding support for it. continuing anyway.",
            .{},
        ),
    }

    server_log.info("server started, send SIGINT (ctrl+c) to shutdown", .{});
    defer server_log.info("begin graceful shutdown", .{});
    shutdown_event.waitUncancelable(shutdown_event_io);
}
