const std = @import("std");
const Io = std.Io;

const AnyFuture = Io.AnyFuture;
const Group = Io.Group;
const ConcurrentError = Io.ConcurrentError;
const Cancelable = Io.Cancelable;
const CancelProtection = Io.CancelProtection;
const Timeout = Io.Timeout;
const Operation = Io.Operation;
const Batch = Io.Batch;
const Dir = Io.Dir;
const File = Io.File;
const Terminal = Io.Terminal;
const LockedStderr = Io.LockedStderr;
const Clock = Io.Clock;
const Timestamp = Io.Timestamp;
const Duration = Io.Duration;
const RandomSecureError = Io.RandomSecureError;
const net = Io.net;
const Queue = Io.Queue;

test sleep {
    std.debug.print("before sleep\n", .{});
    try io.sleep(.fromSeconds(1), .awake);
    std.debug.print("after sleep\n", .{});
}

pub const io: Io = .{
    .userdata = null,
    .vtable = &.{
        .crashHandler = crashHandler,
        .async = async,
        .concurrent = concurrent,
        .await = await,
        .cancel = cancel,
        .groupAsync = groupAsync,
        .groupConcurrent = groupConcurrent,
        .groupAwait = groupAwait,
        .groupCancel = groupCancel,
        .recancel = recancel,
        .swapCancelProtection = swapCancelProtection,
        .checkCancel = checkCancel,
        .futexWait = futexWait,
        .futexWaitUncancelable = futexWaitUncancelable,
        .futexWake = futexWake,
        .operate = operate,
        .batchAwaitAsync = batchAwaitAsync,
        .batchAwaitConcurrent = batchAwaitConcurrent,
        .batchCancel = batchCancel,
        .dirCreateDir = dirCreateDir,
        .dirCreateDirPath = dirCreateDirPath,
        .dirCreateDirPathOpen = dirCreateDirPathOpen,
        .dirOpenDir = dirOpenDir,
        .dirStat = dirStat,
        .dirStatFile = dirStatFile,
        .dirAccess = dirAccess,
        .dirCreateFile = dirCreateFile,
        .dirCreateFileAtomic = dirCreateFileAtomic,
        .dirOpenFile = dirOpenFile,
        .dirClose = dirClose,
        .dirRead = dirRead,
        .dirRealPath = dirRealPath,
        .dirRealPathFile = dirRealPathFile,
        .dirDeleteFile = dirDeleteFile,
        .dirDeleteDir = dirDeleteDir,
        .dirRename = dirRename,
        .dirRenamePreserve = dirRenamePreserve,
        .dirSymLink = dirSymLink,
        .dirReadLink = dirReadLink,
        .dirSetOwner = dirSetOwner,
        .dirSetFileOwner = dirSetFileOwner,
        .dirSetPermissions = dirSetPermissions,
        .dirSetFilePermissions = dirSetFilePermissions,
        .dirSetTimestamps = dirSetTimestamps,
        .dirHardLink = dirHardLink,
        .fileStat = fileStat,
        .fileLength = fileLength,
        .fileClose = fileClose,
        .fileWritePositional = fileWritePositional,
        .fileWriteFileStreaming = fileWriteFileStreaming,
        .fileWriteFilePositional = fileWriteFilePositional,
        .fileReadPositional = fileReadPositional,
        .fileSeekBy = fileSeekBy,
        .fileSeekTo = fileSeekTo,
        .fileSync = fileSync,
        .fileIsTty = fileIsTty,
        .fileEnableAnsiEscapeCodes = fileEnableAnsiEscapeCodes,
        .fileSupportsAnsiEscapeCodes = fileSupportsAnsiEscapeCodes,
        .fileSetLength = fileSetLength,
        .fileSetOwner = fileSetOwner,
        .fileSetPermissions = fileSetPermissions,
        .fileSetTimestamps = fileSetTimestamps,
        .fileLock = fileLock,
        .fileTryLock = fileTryLock,
        .fileUnlock = fileUnlock,
        .fileDowngradeLock = fileDowngradeLock,
        .fileRealPath = fileRealPath,
        .fileHardLink = fileHardLink,
        .fileMemoryMapCreate = fileMemoryMapCreate,
        .fileMemoryMapDestroy = fileMemoryMapDestroy,
        .fileMemoryMapSetLength = fileMemoryMapSetLength,
        .fileMemoryMapRead = fileMemoryMapRead,
        .fileMemoryMapWrite = fileMemoryMapWrite,
        .processExecutableOpen = processExecutableOpen,
        .processExecutablePath = processExecutablePath,
        .lockStderr = lockStderr,
        .tryLockStderr = tryLockStderr,
        .unlockStderr = unlockStderr,
        .processCurrentPath = processCurrentPath,
        .processSetCurrentDir = processSetCurrentDir,
        .processSetCurrentPath = processSetCurrentPath,
        .processReplace = processReplace,
        .processSpawn = processSpawn,
        .childWait = childWait,
        .childKill = childKill,
        .progressParentFile = progressParentFile,
        .inheritParentDir = inheritParentDir,
        .inheritParentFile = inheritParentFile,
        .now = now,
        .clockResolution = clockResolution,
        .sleep = sleep,
        .random = random,
        .randomSecure = randomSecure,
        .netListenIp = netListenIp,
        .netAccept = netAccept,
        .netBindIp = netBindIp,
        .netConnectIp = netConnectIp,
        .netListenUnix = netListenUnix,
        .netConnectUnix = netConnectUnix,
        .netSocketCreatePair = netSocketCreatePair,
        .netWriteFile = netWriteFile,
        .netClose = netClose,
        .netShutdown = netShutdown,
        .netInterfaceNameResolve = netInterfaceNameResolve,
        .netInterfaceName = netInterfaceName,
        .netLookup = netLookup,
    },
};

fn crashHandler(_: ?*anyopaque) void {
    @panic("crashHandler: not implemented");
}

fn async(_: ?*anyopaque, _: []u8, _: std.mem.Alignment, _: []const u8, _: std.mem.Alignment, _: *const fn (context: *const anyopaque, result: *anyopaque) void) ?*AnyFuture {
    @panic("async: not implemented");
}

fn concurrent(_: ?*anyopaque, _: usize, _: std.mem.Alignment, _: []const u8, _: std.mem.Alignment, _: *const fn (context: *const anyopaque, result: *anyopaque) void) Io.ConcurrentError!*Io.AnyFuture {
    @panic("concurrent: not implemented");
}

fn await(_: ?*anyopaque, _: *Io.AnyFuture, _: []u8, _: std.mem.Alignment) void {
    @panic("await: not implemented");
}

fn cancel(_: ?*anyopaque, _: *AnyFuture, _: []u8, _: std.mem.Alignment) void {
    @panic("cancel: not implemented");
}

fn groupAsync(_: ?*anyopaque, _: *Group, _: []const u8, _: std.mem.Alignment, _: *const fn (context: *const anyopaque) void) void {
    @panic("groupAsync: not implemented");
}

fn groupConcurrent(_: ?*anyopaque, _: *Group, _: []const u8, _: std.mem.Alignment, _: *const fn (context: *const anyopaque) void) ConcurrentError!void {
    @panic("groupConcurrent: not implemented");
}

fn groupAwait(_: ?*anyopaque, _: *Group, _: *anyopaque) Cancelable!void {
    @panic("groupAwait: not implemented");
}

fn groupCancel(_: ?*anyopaque, _: *Group, _: *anyopaque) void {
    @panic("groupCancel: not implemented");
}

fn recancel(_: ?*anyopaque) void {
    @panic("recancel: not implemented");
}

fn swapCancelProtection(_: ?*anyopaque, _: CancelProtection) CancelProtection {
    @panic("swapCancelProtection: not implemented");
}

fn checkCancel(_: ?*anyopaque) Cancelable!void {
    @panic("checkCancel: not implemented");
}

fn futexWait(_: ?*anyopaque, _: *const u32, _: u32, _: Timeout) Cancelable!void {
    @panic("futexWait: not implemented");
}

fn futexWaitUncancelable(_: ?*anyopaque, _: *const u32, _: u32) void {
    @panic("futexWaitUncancelable: not implemented");
}

fn futexWake(_: ?*anyopaque, _: *const u32, _: u32) void {
    @panic("futexWake: not implemented");
}

fn operate(_: ?*anyopaque, _: Operation) Cancelable!Operation.Result {
    @panic("operate: not implemented");
}

fn batchAwaitAsync(_: ?*anyopaque, _: *Batch) Cancelable!void {
    @panic("batchAwaitAsync: not implemented");
}

fn batchAwaitConcurrent(_: ?*anyopaque, _: *Batch, _: Timeout) Batch.AwaitConcurrentError!void {
    @panic("batchAwaitConcurrent: not implemented");
}

fn batchCancel(_: ?*anyopaque, _: *Batch) void {
    @panic("batchCancel: not implemented");
}

fn dirCreateDir(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.Permissions) Dir.CreateDirError!void {
    @panic("dirCreateDir: not implemented");
}

fn dirCreateDirPath(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.Permissions) Dir.CreateDirPathError!Dir.CreatePathStatus {
    @panic("dirCreateDirPath: not implemented");
}

fn dirCreateDirPathOpen(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.Permissions, _: Dir.OpenOptions) Dir.CreateDirPathOpenError!Dir {
    @panic("dirCreateDirPathOpen: not implemented");
}

fn dirOpenDir(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.OpenOptions) Dir.OpenError!Dir {
    @panic("dirOpenDir: not implemented");
}

fn dirStat(_: ?*anyopaque, _: Dir) Dir.StatError!Dir.Stat {
    @panic("dirStat: not implemented");
}

fn dirStatFile(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.StatFileOptions) Dir.StatFileError!File.Stat {
    @panic("dirStatFile: not implemented");
}

fn dirAccess(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.AccessOptions) Dir.AccessError!void {
    @panic("dirAccess: not implemented");
}

fn dirCreateFile(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.CreateFileOptions) File.OpenError!File {
    @panic("dirCreateFile: not implemented");
}

fn dirCreateFileAtomic(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.CreateFileAtomicOptions) Dir.CreateFileAtomicError!File.Atomic {
    @panic("dirCreateFileAtomic: not implemented");
}

fn dirOpenFile(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.OpenFileOptions) File.OpenError!File {
    @panic("dirOpenFile: not implemented");
}

fn dirClose(_: ?*anyopaque, _: []const Dir) void {
    @panic("dirClose: not implemented");
}

fn dirRead(_: ?*anyopaque, _: *Dir.Reader, _: []Dir.Entry) Dir.Reader.Error!usize {
    @panic("dirRead: not implemented");
}

fn dirRealPath(_: ?*anyopaque, _: Dir, _: []u8) Dir.RealPathError!usize {
    @panic("dirRealPath: not implemented");
}

fn dirRealPathFile(_: ?*anyopaque, _: Dir, _: []const u8, _: []u8) Dir.RealPathFileError!usize {
    @panic("dirRealPathFile: not implemented");
}

fn dirDeleteFile(_: ?*anyopaque, _: Dir, _: []const u8) Dir.DeleteFileError!void {
    @panic("dirDeleteFile: not implemented");
}

fn dirDeleteDir(_: ?*anyopaque, _: Dir, _: []const u8) Dir.DeleteDirError!void {
    @panic("dirDeleteDir: not implemented");
}

fn dirRename(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir, _: []const u8) Dir.RenameError!void {
    @panic("dirRename: not implemented");
}

fn dirRenamePreserve(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir, _: []const u8) Dir.RenamePreserveError!void {
    @panic("dirRenamePreserve: not implemented");
}

fn dirSymLink(_: ?*anyopaque, _: Dir, _: []const u8, _: []const u8, _: Dir.SymLinkFlags) Dir.SymLinkError!void {
    @panic("dirSymLink: not implemented");
}

fn dirReadLink(_: ?*anyopaque, _: Dir, _: []const u8, _: []u8) Dir.ReadLinkError!usize {
    @panic("dirReadLink: not implemented");
}

fn dirSetOwner(_: ?*anyopaque, _: Dir, _: ?File.Uid, _: ?File.Gid) Dir.SetOwnerError!void {
    @panic("dirSetOwner: not implemented");
}

fn dirSetFileOwner(_: ?*anyopaque, _: Dir, _: []const u8, _: ?File.Uid, _: ?File.Gid, _: Dir.SetFileOwnerOptions) Dir.SetFileOwnerError!void {
    @panic("dirSetFileOwner: not implemented");
}

fn dirSetPermissions(_: ?*anyopaque, _: Dir, _: Dir.Permissions) Dir.SetPermissionsError!void {
    @panic("dirSetPermissions: not implemented");
}

fn dirSetFilePermissions(_: ?*anyopaque, _: Dir, _: []const u8, _: File.Permissions, _: Dir.SetFilePermissionsOptions) Dir.SetFilePermissionsError!void {
    @panic("dirSetFilePermissions: not implemented");
}

fn dirSetTimestamps(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir.SetTimestampsOptions) Dir.SetTimestampsError!void {
    @panic("dirSetTimestamps: not implemented");
}

fn dirHardLink(_: ?*anyopaque, _: Dir, _: []const u8, _: Dir, _: []const u8, _: Dir.HardLinkOptions) Dir.HardLinkError!void {
    @panic("dirHardLink: not implemented");
}

fn fileStat(_: ?*anyopaque, _: File) File.StatError!File.Stat {
    @panic("fileStat: not implemented");
}

fn fileLength(_: ?*anyopaque, _: File) File.LengthError!u64 {
    @panic("fileLength: not implemented");
}

fn fileClose(_: ?*anyopaque, _: []const File) void {
    @panic("fileClose: not implemented");
}

fn fileWritePositional(_: ?*anyopaque, _: File, _: []const u8, _: []const []const u8, _: usize, _: u64) File.WritePositionalError!usize {
    @panic("fileWritePositional: not implemented");
}

fn fileWriteFileStreaming(_: ?*anyopaque, _: File, _: []const u8, _: *Io.File.Reader, _: Io.Limit) File.Writer.WriteFileError!usize {
    @panic("fileWriteFileStreaming: not implemented");
}

fn fileWriteFilePositional(_: ?*anyopaque, _: File, _: []const u8, _: *Io.File.Reader, _: Io.Limit, _: u64) File.WriteFilePositionalError!usize {
    @panic("fileWriteFilePositional: not implemented");
}

fn fileReadPositional(_: ?*anyopaque, _: File, _: []const []u8, _: u64) File.ReadPositionalError!usize {
    @panic("fileReadPositional: not implemented");
}

fn fileSeekBy(_: ?*anyopaque, _: File, _: i64) File.SeekError!void {
    @panic("fileSeekBy: not implemented");
}

fn fileSeekTo(_: ?*anyopaque, _: File, _: u64) File.SeekError!void {
    @panic("fileSeekTo: not implemented");
}

fn fileSync(_: ?*anyopaque, _: File) File.SyncError!void {
    @panic("fileSync: not implemented");
}

fn fileIsTty(_: ?*anyopaque, _: File) Cancelable!bool {
    @panic("fileIsTty: not implemented");
}

fn fileEnableAnsiEscapeCodes(_: ?*anyopaque, _: File) File.EnableAnsiEscapeCodesError!void {
    @panic("fileEnableAnsiEscapeCodes: not implemented");
}

fn fileSupportsAnsiEscapeCodes(_: ?*anyopaque, _: File) Cancelable!bool {
    @panic("fileSupportsAnsiEscapeCodes: not implemented");
}

fn fileSetLength(_: ?*anyopaque, _: File, _: u64) File.SetLengthError!void {
    @panic("fileSetLength: not implemented");
}

fn fileSetOwner(_: ?*anyopaque, _: File, _: ?File.Uid, _: ?File.Gid) File.SetOwnerError!void {
    @panic("fileSetOwner: not implemented");
}

fn fileSetPermissions(_: ?*anyopaque, _: File, _: File.Permissions) File.SetPermissionsError!void {
    @panic("fileSetPermissions: not implemented");
}

fn fileSetTimestamps(_: ?*anyopaque, _: File, _: File.SetTimestampsOptions) File.SetTimestampsError!void {
    @panic("fileSetTimestamps: not implemented");
}

fn fileLock(_: ?*anyopaque, _: File, _: File.Lock) File.LockError!void {
    @panic("fileLock: not implemented");
}

fn fileTryLock(_: ?*anyopaque, _: File, _: File.Lock) File.LockError!bool {
    @panic("fileTryLock: not implemented");
}

fn fileUnlock(_: ?*anyopaque, _: File) void {
    @panic("fileUnlock: not implemented");
}

fn fileDowngradeLock(_: ?*anyopaque, _: File) File.DowngradeLockError!void {
    @panic("fileDowngradeLock: not implemented");
}

fn fileRealPath(_: ?*anyopaque, _: File, _: []u8) File.RealPathError!usize {
    @panic("fileRealPath: not implemented");
}

fn fileHardLink(_: ?*anyopaque, _: File, _: Dir, _: []const u8, _: File.HardLinkOptions) File.HardLinkError!void {
    @panic("fileHardLink: not implemented");
}

fn fileMemoryMapCreate(_: ?*anyopaque, _: File, _: File.MemoryMap.CreateOptions) File.MemoryMap.CreateError!File.MemoryMap {
    @panic("fileMemoryMapCreate: not implemented");
}

fn fileMemoryMapDestroy(_: ?*anyopaque, _: *File.MemoryMap) void {
    @panic("fileMemoryMapDestroy: not implemented");
}

fn fileMemoryMapSetLength(_: ?*anyopaque, _: *File.MemoryMap, _: usize) File.MemoryMap.SetLengthError!void {
    @panic("fileMemoryMapSetLength: not implemented");
}

fn fileMemoryMapRead(_: ?*anyopaque, _: *File.MemoryMap) File.ReadPositionalError!void {
    @panic("fileMemoryMapRead: not implemented");
}

fn fileMemoryMapWrite(_: ?*anyopaque, _: *File.MemoryMap) File.WritePositionalError!void {
    @panic("fileMemoryMapWrite: not implemented");
}

fn processExecutableOpen(_: ?*anyopaque, _: Dir.OpenFileOptions) std.process.OpenExecutableError!File {
    @panic("processExecutableOpen: not implemented");
}

fn processExecutablePath(_: ?*anyopaque, _: []u8) std.process.ExecutablePathError!usize {
    @panic("processExecutablePath: not implemented");
}

fn lockStderr(_: ?*anyopaque, _: ?Terminal.Mode) Cancelable!LockedStderr {
    @panic("lockStderr: not implemented");
}

fn tryLockStderr(_: ?*anyopaque, _: ?Terminal.Mode) Cancelable!?LockedStderr {
    @panic("tryLockStderr: not implemented");
}

fn unlockStderr(_: ?*anyopaque) void {
    @panic("unlockStderr: not implemented");
}

fn processCurrentPath(_: ?*anyopaque, _: []u8) std.process.CurrentPathError!usize {
    @panic("processCurrentPath: not implemented");
}

fn processSetCurrentDir(_: ?*anyopaque, _: Dir) std.process.SetCurrentDirError!void {
    @panic("processSetCurrentDir: not implemented");
}

fn processSetCurrentPath(_: ?*anyopaque, _: []const u8) std.process.SetCurrentPathError!void {
    @panic("processSetCurrentPath: not implemented");
}

fn processReplace(_: ?*anyopaque, _: std.process.ReplaceOptions) std.process.ReplaceError {
    @panic("processReplace: not implemented");
}

fn processSpawn(_: ?*anyopaque, _: std.process.SpawnOptions) std.process.SpawnError!std.process.Child {
    @panic("processSpawn: not implemented");
}

fn childWait(_: ?*anyopaque, _: *std.process.Child) std.process.Child.WaitError!std.process.Child.Term {
    @panic("childWait: not implemented");
}

fn childKill(_: ?*anyopaque, _: *std.process.Child) void {
    @panic("childKill: not implemented");
}

fn progressParentFile(_: ?*anyopaque) std.Progress.ParentFileError!File {
    @panic("progressParentFile: not implemented");
}

fn inheritParentDir(_: ?*anyopaque, _: Dir.Handle) Io.InheritParentHandleError!Dir {
    @panic("inheritParentDir: not implemented");
}

fn inheritParentFile(_: ?*anyopaque, _: File.Handle, _: File.Flags) Io.InheritParentHandleError!File {
    @panic("childKill: not implemented");
}

fn now(_: ?*anyopaque, _: Clock) Timestamp {
    @panic("now: not implemented");
}

fn clockResolution(_: ?*anyopaque, _: Clock) Clock.ResolutionError!Duration {
    @panic("clockResolution: not implemented");
}

fn sleep(_: ?*anyopaque, _: Timeout) Cancelable!void {
    @panic("sleep: not implemented");
}

fn random(_: ?*anyopaque, _: []u8) void {
    @panic("random: not implemented");
}

fn randomSecure(_: ?*anyopaque, _: []u8) RandomSecureError!void {
    @panic("randomSecure: not implemented");
}

fn netListenIp(_: ?*anyopaque, _: *const net.IpAddress, _: net.IpAddress.ListenOptions) net.IpAddress.ListenError!net.Socket {
    @panic("netListenIp: not implemented");
}

fn netAccept(_: ?*anyopaque, _: net.Socket.Handle, _: net.Server.AcceptOptions) net.Server.AcceptError!net.Socket {
    @panic("netAccept: not implemented");
}

fn netBindIp(_: ?*anyopaque, _: *const net.IpAddress, _: net.IpAddress.BindOptions) net.IpAddress.BindError!net.Socket {
    @panic("netBindIp: not implemented");
}

fn netConnectIp(_: ?*anyopaque, _: *const net.IpAddress, _: net.IpAddress.ConnectOptions) net.IpAddress.ConnectError!net.Socket {
    @panic("netConnectIp: not implemented");
}

fn netListenUnix(_: ?*anyopaque, _: *const net.UnixAddress, _: net.UnixAddress.ListenOptions) net.UnixAddress.ListenError!net.Socket.Handle {
    @panic("netListenUnix: not implemented");
}

fn netConnectUnix(_: ?*anyopaque, _: *const net.UnixAddress) net.UnixAddress.ConnectError!net.Socket.Handle {
    @panic("netConnectUnix: not implemented");
}

fn netSocketCreatePair(_: ?*anyopaque, _: net.Socket.CreatePairOptions) net.Socket.CreatePairError![2]net.Socket {
    @panic("netSocketCreatePair: not implemented");
}

fn netWriteFile(_: ?*anyopaque, _: net.Socket.Handle, _: []const u8, _: *Io.File.Reader, _: Io.Limit) net.Stream.Writer.WriteFileError!usize {
    @panic("netWriteFile: not implemented");
}

fn netClose(_: ?*anyopaque, _: []const net.Socket) void {
    @panic("netClose: not implemented");
}

fn netShutdown(_: ?*anyopaque, _: net.Socket.Handle, _: net.ShutdownHow) net.ShutdownError!void {
    @panic("netShutdown: not implemented");
}

fn netInterfaceNameResolve(_: ?*anyopaque, _: *const net.Interface.Name) net.Interface.Name.ResolveError!net.Interface {
    @panic("netInterfaceNameResolve: not implemented");
}

fn netInterfaceName(_: ?*anyopaque, _: net.Interface) net.Interface.NameError!net.Interface.Name {
    @panic("netInterfaceName: not implemented");
}

fn netLookup(_: ?*anyopaque, _: net.HostName, _: *Queue(net.HostName.LookupResult), _: net.HostName.LookupOptions) net.HostName.LookupError!void {
    @panic("netLookup: not implemented");
}
