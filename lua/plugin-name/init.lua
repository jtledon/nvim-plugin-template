print("this will run when you require it, require('plugin-name')")

local M = {}

-- Generic syntax for making a method on an object
M.setup = function(opts)
end

-- Alternative syntax for defining the same type of method
function M.toggle(opts)
end

-- implicit "im an internal function", not for API use
M._hidden = function(arg)
end

-- Lua Manual: https://www.lua.org/manual/


-- Colon Syntax vs Dot Syntax
-- object:method(arg1, arg2) == object.method(self, arg1, arg2)
--
-- it is effectively OOP syntactic sugar. Allows for passing self as first param
-- this only matters when _calling_ the method


-- looping in lua
for i, v in ipairs(M) do
    -- skips over non-natural number indexes; provides them in ascending order
    -- used for numeric tables
    -- all keys must be consecutive, else the loop will halt early
    print(i, v)
end

for k, v in pairs(M) do
    -- for looping over any non-numeric, or numeric but non-consecutive tables
    -- will return all key-value pairs, but the other is not guaranteed
    print(k, v)
end

-- luals (Lua Language Server) type hints
-- [Lua Annotations] https://github.com/LuaLS/lua-language-server/wiki/Annotations#annotations-list
--- @type
--- @field
--- @return
--- @param
--- @    to see them all

return M
