# zig_lua_test

# Packages:
 - Zig 0.12.0
 - Lua 5.4.6 dev

# OS:
 - Windows 10 64bit

# Information:
  Simple test link lib from c to zig to run program to load script. Not working ATM.

  This will download Lua from github.

  Note this is just a test. For 0.12.0 API changes.

```
const script_file: [*c]const u8 = "script.lua";
_ = try cl.luaL_loadfile(L, script_file);
```

```
error: expected type '[*c]const u8', found '?*anyopaque'
```

# Refs:
 - https://stackoverflow.com/questions/69106290/need-help-using-a-c-library-in-zig
 - https://ziggit.dev/t/how-to-properly-add-c-library-to-build-zig-zig-0-13/4259
 - https://cone.codes/posts/using-zig-to-build-native-lua-scripts/
 - https://nathancraddock.com/blog/ziglua/
 - https://ziglang.org/documentation/0.10.0/#Type-Coercion-Stricter-Qualification
 - https://ziggit.dev/t/converting-array-of-strings-to-c-strings-without-overflowing/2050/3
 - https://ziggit.dev/t/convert-const-u8-to-0-const-u8/3375
 - https://github.com/ziglang/zig/issues/19883
 - https://stackoverflow.com/questions/72736997/how-to-pass-a-c-string-into-a-zig-function-expecting-a-zig-string
# Cache:
```
C:\Users\<user>\AppData\Local\zig
```