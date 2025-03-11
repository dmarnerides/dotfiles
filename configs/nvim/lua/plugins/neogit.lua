local function toggle()
    local neogit = require("neogit")
    if neogit.status.is_open() then
        neogit.close()

    else
        neogit.open({ kind = "floating" })
    end
end

local function cfg()
    local neogit = require("neogit")

    neogit.setup{
        kind= "split",
    }
    vim.keymap.set('n', '<leader>gg', toggle, { noremap=true, silent=true, desc = '[Neogit] Open neogit' })

end

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = cfg
}
