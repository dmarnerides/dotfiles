local function cfg()
    local neogit = require("neogit")

    neogit.setup{
        kind= "split",
    }

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
