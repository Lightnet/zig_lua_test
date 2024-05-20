const std = @import("std");

const lua = @cImport({
    //@cInclude("luaconf.h");
    @cInclude("lua.h");
    @cInclude("lauxlib.h");
    @cInclude("lualib.h");
});

//pub const LUA_BYTECODE = @embedFile("luac.out");

pub fn main() !void {
    std.debug.print("Hello World!\n", .{});

    //const L: c.lua_State = c.luaL_newstate();
    const S = lua.luaL_newstate();

    lua.luaL_openlibs(S);

    //const load_status = lua.luaL_loadbufferx(S, LUA_BYTECODE, LUA_BYTECODE.len, "main.lua", "bt");

    lua.lua_newtable(S);

    // for (0..5) |i| {
    //     c.lua_pushnumber(L, i); // Push the table index
    //     c.lua_pushnumber(L, i * 2); // Push the cell value
    //     c.lua_rawset(L, -3); // Stores the pair in the table
    // }
    lua.lua_pop(S, 1); // Take the returned value out of the stack
    lua.lua_setglobal(S, "foo");

    defer lua.lua_close(S);
}

// pub fn main() !void {
//     // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
//     std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

//     // stdout is for the actual output of your application, for example if you
//     // are implementing gzip, then only the compressed bytes should be sent to
//     // stdout, not any debugging messages.
//     const stdout_file = std.io.getStdOut().writer();
//     var bw = std.io.bufferedWriter(stdout_file);
//     const stdout = bw.writer();

//     try stdout.print("Run `zig build test` to run the tests.\n", .{});

//     try bw.flush(); // don't forget to flush!
// }

// test "simple test" {
//     var list = std.ArrayList(i32).init(std.testing.allocator);
//     defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
//     try list.append(42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }
