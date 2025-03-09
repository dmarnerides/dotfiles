local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "[Nvim Tree] " .. desc, buffer = bufnr, noremap = true, silent = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings (when inside nvim-tree)
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

local function cfg()
    require("nvim-tree").setup {
        on_attach = on_attach,
    }
    vim.keymap.set("n", "<leader>z", ":NvimTreeToggle<CR>",
        { desc = "[Nvim Tree] Toggle file tree", noremap = true, silent = true })
    local api = require("nvim-tree.api")

    -- This is a workaround to make sure that the tree is in sync with the current buffer
    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            if (vim.fn.bufname() == "NvimTree_1") then return end

            api.tree.find_file({ buf = vim.fn.bufnr() })
        end,
    })
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = cfg,
}
