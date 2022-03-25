--- Check if a file or directory exists in this path
local function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

local anaconda_dir = nil
local possible_dirs = {'anaconda3', 'anaconda', 'miniconda3', 'miniconda', 'miniforge', 'mambaforge'}
for _, adir in ipairs(possible_dirs) do
   local full_dir = vim.fn.expand("$HOME/" .. adir .. "/bin/python")
   if exists(full_dir) then
      anaconda_dir = full_dir
   end
end

if anaconda_dir ~= nil then
   vim.g.python3_host_prog = vim.fn.expand(anaconda_dir)
   vim.g.python3_host_program = vim.g.python3_host_prog
   -- Disable providers we do not care a about
   vim.g.loaded_python_provider = 0
   vim.g.loaded_ruby_provider = 0
   vim.g.loaded_perl_provider = 0
   vim.g.loaded_node_provider = 0
end


-- Set the colorscheme first
pcall(vim.cmd, [[colorscheme my_nvcode]])
require("utils")
require("plugins")
require("base_config")
require("mappings")
require("autocmd")
-- require("lsp")
