# Explanation of the file structure of a neovim plugin

Special thanks to TJ DeVries for the "Neovim Lua Plugin From Scratch" video. It was super helpful, and the basis for this repo. You can find that video here: https://www.youtube.com/watch?v=n4Lp4cV8YR0

## Special folders

Neovim has special folders that it will look for and either run the files that are inside or make them available to call later.

* `plugin/`: this folder will have all of its files run automatically
* `lua/`: this folder wont have its files run automatically, but they will be available to us to run
* `doc/`: this folder stores the documentation for this plugin

You can find out more about special folders and the runtime path by running `:help runtimepath` inside of neovim

## Calling these files

To source a file in neovim, you need to `require()` it. This will run the file from top to bottom and cache the value returned from the file into a global table. If you were to `require()` the same file again without clearing out the cache, it will simply return the cached value that is stored, rather than executing the file again and updating the cache.

You can `require()` folders that are within a folder heirarchy by chaining directories together using `.`

consider folder structure such as the following:
```bash
.
├--lua
|  ├--plugin-name.lua
├--plugin
|  ├--always-runs.lua
├--tests
   ├--plugin-name_spec.lua
```

You can call `:lua require("plugin-name")` and that will call `lua/plugin-name.lua`, because the lua folder was added to you rtp

Consider an alternative structure like the following
```bash
.
├--lua
|  ├--plugin-name
|     ├--init.lua
|     ├--config.lua
|     ├--utils.lua
├--plugin
|  ├--always-runs.lua
├--tests
   ├--plugin-name_spec.lua
```

Notice now that we don't have a file called `plugin-name.lua` anywhere. We can still call `require("plugin-name")`, as this will reference the `init.lua` file in the directory.

> note: `init.lua` files are entrypoint files in lua for a specific directory

Alternatively, if we wanted to reference the `config.lua` file, you could call `:lua require("plugin-name.config")`

You can view the global table at stores the modules that have been require, and view their cached values by inspecting `package.loaded`
```lua
:lua print(vim.inspect(package.loaded))
```

You can uncache a file by setting the table entry for that file to `nil`
```lua
:lua package.loaded["plugin-name.utils"] = nil
```

## Convention

Export a module from a neovim plugin
```lua
M = {}
return M
```

Create a setup function that takes in an `{opts}` table, which allows plugin configuration (if your plugin allows for that). This allows for delayed setup of your plugin, ie. lazy loading
```lua
M = {}

M.setup = function(opts)
end

return M
```

If you are creating a local variable that you do not guarantee the state of and you might update later on, resulting in a breaking change, it is convention to prefix them with an underscore; these are considered variables that are private to the plugin.
```lua
M = {}

M._private = 1

return M
```
