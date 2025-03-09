local function cfg()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc="[Harpoon] Toggle quick menu"})

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[Harpoon] add to list" })

    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end,
        { desc = "[Harpoon] Select the first one" })
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end,
        { desc = "[Harpoon] Select the second one" })
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end,
        { desc = "[Harpoon] Select the third one" })
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end,
        { desc = "[Harpoon] Select the fourth one" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end,
        { desc = "[Harpoon] Toggle previous buffer from harpoon list" })
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end,
        { desc = "[Harpoon] Toggle next buffer from harpoon list" })
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = cfg,
}
