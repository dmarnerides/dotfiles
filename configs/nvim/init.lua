-- Set the colorscheme first
-- TODO: Convert colorscheme to lua
-- pcall(vim.cmd, [[colorscheme mycolorscheme]])
require('mycolorscheme')
--
-- Python
-- 
-- Run which to find python3
vim.g.python3_host_prog = vim.fn.system("which python3")
vim.g.python3_host_program = vim.g.python3_host_prog
-- Disable providers we do not care a about
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- For nvim-tree ---------
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- For nvim-tree end ---------

require("set")
require("mappings")
-- TODO: Fix tab completion and selection from menus

-- Setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "plugins",
    change_detection = { notify = false }
})

-- Setup autocommnds
require("autocmd")
-- Setup bdel (to delete buffers without closing windows)
require("bdel")
-- Setup custom comfortable motion
require("comfortable_motion")


