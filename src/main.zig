const std = @import("std");
const mach = @import("mach");

// The global list of Mach modules our application may use.
pub const modules = .{
    mach.Core,
    mach.gfx.text_modules,
    @import("App.zig"),
};

pub fn main() !void {
    const allocator = std.heap.c_allocator;

    // Initialize module system
    try mach.mods.init(allocator);

    // Schedule .app.start to run.
    mach.mods.schedule(.app, .start);

    // Dispatch systems forever or until there are none left to dispatch. If your app uses mach.Core
    // then this will block forever and never return.
    const stack_space = try allocator.alloc(u8, 8 * 1024 * 1024);
    try mach.mods.dispatch(stack_space, .{});
}
