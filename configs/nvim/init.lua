vim.g.python3_host_prog = vim.fn.expand("$HOME/anaconda3/bin/python")
vim.g.python3_host_program = vim.g.python3_host_prog

-- Disable providers we do not care a about
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Set the colorscheme first
pcall(vim.cmd, [[colorscheme my_nvcode]])
require("utils")
require("plugins")
require("base_config")
require("mappings")
require("autocmd")
-- require("lsp")
