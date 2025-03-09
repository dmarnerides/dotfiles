function cfg()
    -- Align line-wise comment delimiters flush left instead of following code indentation
    vim.g.NERDDefaultAlign = 'left'
    -- Add spaces after comment delimiters by default
    vim.g.NERDSpaceDelims = 1
    -- Use compact syntax for prettified multi-line comments
    vim.g.NERDCompactSexyComs = 1
    -- Allow commenting and inverting empty lines (useful when commenting a region)
    vim.g.NERDCommentEmptyLines = 1
    -- Enable NERDCommenterToggle to check all selected lines is commented or not
    vim.g.NERDToggleCheckAllLines = 1
    -- Override Nerdcommenter mappings to include descriptions
    vim.g.NERDCreateDefaultMappings = 0

    -- [count]<leader>cc |NERDCommenterComment|
    -- Comment out the current line or text selected in visual mode.
    vim.keymap.set({ "n", "x" }, "<leader>cc", "<Plug>NERDCommenterComment", {
        silent = true,
        desc = "[NerdCommenter] Comment out the current line or selected text",
    })

    -- [count]<leader>cn |NERDCommenterNested|
    -- Same as cc but forces nesting.
    vim.keymap.set({ "n", "x" }, "<leader>cn", "<Plug>NERDCommenterNested", {
        silent = true,
        desc = "[NerdCommenter] Comment out with forced nesting",
    })

    -- [count]<leader>c<space> |NERDCommenterToggle|
    -- Toggles the comment state of the selected line(s). If the topmost selected
    -- line is commented, all selected lines are uncommented and vice versa.
    vim.keymap.set({ "n", "x" }, "<leader>c<Space>", "<Plug>NERDCommenterToggle", {
        silent = true,
        desc = "[NerdCommenter] Toggle comment state of selected line(s)",
    })

    -- [count]<leader>cm |NERDCommenterMinimal|
    -- Comments the given lines using only one set of multipart delimiters.
    vim.keymap.set({ "n", "x" }, "<leader>cm", "<Plug>NERDCommenterMinimal", {
        silent = true,
        desc = "[NerdCommenter] Comment using one set of multipart delimiters",
    })

    -- [count]<leader>ci |NERDCommenterInvert|
    -- Toggles the comment state of the selected line(s) individually.
    vim.keymap.set({ "n", "x" }, "<leader>ci", "<Plug>NERDCommenterInvert", {
        silent = true,
        desc = "[NerdCommenter] Toggle comment state individually for each line",
    })

    -- [count]<leader>cs |NERDCommenterSexy|
    -- Comments out the selected lines with a pretty block formatted layout.
    vim.keymap.set({ "n", "x" }, "<leader>cs", "<Plug>NERDCommenterSexy", {
        silent = true,
        desc = "[NerdCommenter] Comment with pretty block formatted layout",
    })

    -- [count]<leader>cy |NERDCommenterYank|
    -- Same as cc except that the commented line(s) are yanked first.
    vim.keymap.set({ "n", "x" }, "<leader>cy", "<Plug>NERDCommenterYank", {
        silent = true,
        desc = "[NerdCommenter] Yank then comment the selected line(s)",
    })

    -- <leader>c$ |NERDCommenterToEOL|
    -- Comments the current line from the cursor to the end of line.
    vim.keymap.set("n", "<leader>c$", "<Plug>NERDCommenterToEOL", {
        silent = true,
        desc = "[NerdCommenter] Comment from cursor to end of line",
    })

    -- <leader>cA |NERDCommenterAppend|
    -- Adds comment delimiters to the end of line and goes into insert mode between them.
    vim.keymap.set("n", "<leader>cA", "<Plug>NERDCommenterAppend", {
        silent = true,
        desc = "[NerdCommenter] Append comment delimiters to EOL and enter insert mode",
    })

    -- |NERDCommenterInsert|
    -- Adds comment delimiters at the current cursor position and inserts between.
    -- (Disabled by default; enable if you wish to use it.)
    vim.keymap.set("i", "<Plug>NERDCommenterInsert", "<C-\\><C-O>:call nerdcommenter#Comment('i', 'Insert')<CR>", {
        silent = true,
        desc = "[NerdCommenter] Insert comment delimiters at cursor and enter insert mode",
    })

    -- [count]<leader>cl |NERDCommenterAlignLeft|
    -- Comment using delimiters aligned down the left side.
    vim.keymap.set({ "n", "x" }, "<leader>cl", "<Plug>NERDCommenterAlignLeft", {
        silent = true,
        desc = "[NerdCommenter] Comment with left-aligned delimiters",
    })

    -- [count]<leader>cb |NERDCommenterAlignBoth|
    -- Comment using delimiters aligned on both the left and right sides.
    vim.keymap.set({ "n", "x" }, "<leader>cb", "<Plug>NERDCommenterAlignBoth", {
        silent = true,
        desc = "[NerdCommenter] Comment with left and right aligned delimiters",
    })

    -- [count]<leader>cu |NERDCommenterUncomment|
    -- Uncomments the selected line(s).
    vim.keymap.set({ "n", "x" }, "<leader>cu", "<Plug>NERDCommenterUncomment", {
        silent = true,
        desc = "[NerdCommenter] Uncomment the selected line(s)",
    })

    -- <leader>ca |NERDCommenterAltDelims|
    -- Switches to the alternative set of delimiters.
    vim.keymap.set("n", "<leader>ca", "<Plug>NERDCommenterAltDelims", {
        silent = true,
        desc = "[NerdCommenter] Switch to alternative comment delimiters",
    })
end

return {
    "preservim/nerdcommenter",
    config = cfg
}
