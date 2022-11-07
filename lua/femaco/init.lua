local M = {}

local update_config = function(opts)
  local config = require('femaco.config')
  opts = opts or {}
  for key, value in pairs(opts) do
    config.settings[key] = value
  end
end

M.debug = function ()
  print('debug 2')
end

local reload = function (module)
  package.loaded[module] = nil
  return require(module) -- loads an updated version of module
end

local create_commands = function()
  vim.api.nvim_create_user_command('FeMaco', function() require('femaco.edit').edit_code_block() end, {})
  vim.api.nvim_create_user_command('FeMacoDebug', function() reload('femaco').debug() end, {})
end

M.setup = function(opts)
  update_config(opts)
  create_commands()
end

return M
