const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    // const lib = b.addStaticLibrary(.{
    //     .name = "zig_lua_api",
    //     .root_source_file = b.path("src/root.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // b.installArtifact(lib);
    const lua_dep = b.dependency("lua", .{
        .target = target,
        .optimize = optimize,
    });
    //_ = lua_dep;
    const lua_c_files = [_][]const u8{
        "lapi.c",
        "lauxlib.c",
        "lbaselib.c",
        //"lbitlib.c",//does not exist
        "lcode.c",
        "lcorolib.c",
        "lctype.c",
        "ldblib.c",
        "ldebug.c",
        "ldo.c",
        "ldump.c",
        "lfunc.c",
        "lgc.c",
        "linit.c",
        "liolib.c",
        "llex.c",
        "lmathlib.c",
        "lmem.c",
        "loadlib.c",
        "lobject.c",
        "lopcodes.c",
        "loslib.c",
        "lparser.c",
        "lstate.c",
        "lstring.c",
        "lstrlib.c",
        "ltable.c",
        "ltablib.c",
        "ltm.c",
        "lundump.c",
        "lutf8lib.c",
        "lvm.c",
        "lzio.c",
    };
    //_ = lua_c_files;
    const c_flags = [_][]const u8{
        "-std=c99",
        "-O2",
        "-DLUA_USE_WINDOWS",
        //"-DLUA_USE_POSIX",
    };
    //_ = c_flags;

    //const lua = lua_dep.artifact("lua");

    const exe = b.addExecutable(.{
        .name = "zig_lua_api",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    //std.debug.print("=====================================\n", .{});
    //std.debug.print("src: {any}\n", .{lua_dep.path("src")});
    exe.linkLibC();
    exe.addIncludePath(lua_dep.path("./")); //include folder

    inline for (lua_c_files) |c_file| { //src files
        exe.addCSourceFile(.{
            //.file = .{ .path = "lua/" ++ c_file },
            .file = lua_dep.path(c_file),
            .flags = &c_flags,
        });
    }

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // TEST LIB DEFAULT
    // const lib_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/root.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);
    // const exe_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/main.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    // const test_step = b.step("test", "Run unit tests");
    // test_step.dependOn(&run_lib_unit_tests.step);
    // test_step.dependOn(&run_exe_unit_tests.step);
}
