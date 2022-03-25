-- TODO: Setup bqf to work with coc (see bqf readme.md page on github)

local execute = vim.api.nvim_command

-- check if packer is installed (~/.local/share/nvim/site/pack)
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = install_path .. "/plugin/packer_compiled.vim"
local is_installed = vim.fn.empty(vim.fn.glob(install_path)) == 0
local is_compiled = vim.fn.empty(vim.fn.glob(compile_path)) == 0

if not is_installed then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute("packadd packer.nvim")
    print("Installed packer.nvim.")
    is_installed = true
end

local packer = nil
local function init()
    if not is_installed then return end
    if packer == nil then
        packer = require("packer")
        packer.init({
            -- we don't want the compilation file in '~/.config/nvim'
            compile_path = compile_path
        })
    end

    packer.use {
        -- Packer can manage itself as an optional plugin
        {"wbthomason/packer.nvim"},
        -- Text objects for () {} []
        {"wellle/targets.vim"},
        -- Allows repeating of plugin commands using .
        {"tpope/vim-repeat"},
        -- Surround stuff with stuff
        {"machakann/vim-sandwich"},
        -- Comment / uncomment
        {"preservim/nerdcommenter", config = "require('plugin.nerdcommenter')"},
        -- Moving between vim and tmux panes
        {
            "christoomey/vim-tmux-navigator",
            config = "vim.g.tmux_navigator_no_mappings = 1"
        },
        -- Smooth scrolling
        {"yuttie/comfortable-motion.vim"},
        -- Don't close windows that also display buffer when using bdel
        {"rbgrouleff/bclose.vim"},
        -- Enhance % button functionality
        {"tmhedberg/matchit"},
        -- Search and replace!
        {"brooth/far.vim", config = "vim.g['far#enable_undo']=1"},
        {"tpope/vim-eunuch"},
        -- search current selection with * and #
        {"nelstrom/vim-visual-star-search"},
        {"https://github.com/lervag/vimtex.git", config = "require('plugin.vimtex')"},
        -- CSV Files
        {"chrisbra/csv.vim"},
        -- Session saving
        {"thaerkh/vim-workspace", config = "require('plugin.vim-workspace')"},
        -- nvim-tree
        {
            "kyazdani42/nvim-tree.lua",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = "require('plugin.nvim-tree')"
        }, -- Telescope
        {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzy-native.nvim"}
            },
            config = "require('plugin.telescope')"
        },
        -- set command prefix here to avoid conflicts with telescope etc
        {
            "junegunn/fzf.vim",
            requires = {"junegunn/fzf", dir = "~/.fzf", run = "./install --all"},
            config = "require('plugin.fzf')"
        },
        -- better quickfix
        {"kevinhwang91/nvim-bqf", config = "require('plugin.bqf')"},
        -- Polyglot
        {"sheerun/vim-polyglot"},
        -- CoC nvim
        {'neoclide/coc.nvim', branch = 'release', config="require('plugin.coc')"},
        -- -- LSP
        -- {"neovim/nvim-lspconfig"},
        -- -- For lsp icons
        -- {"onsails/lspkind-nvim", config = "require('plugin.lspkind')"},
        -- -- ALE
        -- {"dense-analysis/ale", config = "require('plugin.ale')"},
        -- Completion
        -- {"hrsh7th/nvim-compe", config = "require('plugin.nvim-compe')"},
        -- markdown preview
        -- {"npxbr/glow.nvim", run = ":GlowInstall"},
        -- Airline
        {
            "vim-airline/vim-airline",
            config = "require('plugin.airline')",
            requires = {"ryanoasis/vim-devicons"}

        },
        {"vim-airline/vim-airline-themes"},
        {
            "christianchiarulli/nvcode-color-schemes.vim",
            setup = function() vim.g.nvcode_termcolors = 256 end
        },
        -- Colorizer
        {
            "norcalli/nvim-colorizer.lua",
            config = function() require("colorizer").setup() end
        },
        -- Git stuff
        {"tpope/vim-fugitive"},
        -- {'airblade/vim-gitgutter'}
    }
end

-- called from 'lua/autocmd.lua' at `VimEnter`
local function sync_if_not_compiled()
    if packer == nil then return end
    if not is_compiled then
        packer.sync()
    end
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        -- workaround for error when packer not installed
        if packer == nil then return function() end end
        if key == "sync_if_not_compiled" then
            return sync_if_not_compiled
        else
            return packer[key]
        end
    end
})

return plugins
