local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities()
)

local function default_handler(server_name)
    require("lspconfig")[server_name].setup {
        capabilities = capabilities
    }
end

local function lua_handler()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
            }
        }
    }
end

local function clangd_handler()
    local lspconfig = require("lspconfig")
    lspconfig.clangd.setup {
        capabilities = capabilities,
        cmd = { "clangd", "--background-index" },
    }
end

local function python_handler()
    local lspconfig = require("lspconfig")
    lspconfig.pyright.setup {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                }
            }
        },
        single_file_support = true,
        capabilities = capabilities
    }
end


local function setup_mappings()
    local remap = vim.api.nvim_set_keymap
    remap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",
        { noremap = true, silent = true, desc = "[LSP] Go to declaration" })
    remap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",
        { noremap = true, silent = true, desc = "[LSP] Go to definition" })
    remap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{timeout_ms=2000}<CR>",
        { noremap = true, silent = true, desc = "[LSP] Format current buffer" })
    remap("n", "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<CR>",
        { noremap = true, silent = true, desc = "[LSP] Go to next diagnostic" })
    remap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>",
        { noremap = true, silent = true, desc = "[LSP] Go to next diagnostic" })
    remap("n", "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>",
        { noremap = true, silent = true, desc = "[LSP] Go to previous diagnostic" })
    remap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>",
        { noremap = true, silent = true, desc = "[LSP] Go to previous diagnostic" })
end


local function cfg()
    require("fidget").setup({})
    require("mason").setup({
        ensure_installed = {
            "black",
        }
    })
    require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls",
            "clangd",
            "pyright",
        },
        handlers = {
            default_handler,
            ["lua_ls"] = lua_handler,
            ["pyright"] = python_handler,
            ["clangd"] = clangd_handler,
        }
    })

    vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })

    local null_ls = require("null-ls")

    -- register any number of sources simultaneously
    local sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.code_actions.gitsigns,
    }

    null_ls.setup({ sources = sources })

    setup_mappings()
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "nvimtools/none-ls.nvim",
    },

    config = cfg
}
