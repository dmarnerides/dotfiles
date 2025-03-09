local function nvim_create_augroups(definitions)
    local cmd = vim.api.nvim_command
    for group_name, definition in pairs(definitions) do
        cmd("augroup " .. group_name)
        cmd("autocmd!")
        for _, def in ipairs(definition) do
            cmd(table.concat(vim.tbl_flatten {"autocmd", def}, " "))
        end
        cmd("augroup END")
    end
end

nvim_create_augroups({
    resize_windows_proportionally = {
        {"VimResized", "*", [[tabdo wincmd =]]}
    },
    -- Remove cro from formatting
    -- c	Auto-wrap comments using textwidth, inserting the current comment leader automatically.
    -- r	Automatically insert the current comment leader after hitting <Enter> in Insert mode.
    -- o	Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
    fmtopts = {
        {"BufEnter", "*", "setlocal formatoptions-=cro"}
    },
})

-----------------------------------------------------------------
-- Ensure only one tab is open at all times
-- On startup, if multiple tabs were somehow opened, close extras.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local tabs = vim.api.nvim_list_tabpages()
    while #tabs > 1 do
      vim.cmd("tabclose")
      tabs = vim.api.nvim_list_tabpages()
    end
  end
})

-- Whenever a new tab is entered, check and close it if it's an extra.
vim.api.nvim_create_autocmd("TabNewEntered", {
  callback = function()
    local tabs = vim.api.nvim_list_tabpages()
    if #tabs > 1 then
      vim.cmd("tabclose")
      vim.notify("Multiple tabs are disabled. Closing new tab.", vim.log.levels.WARN)
    end
  end
})
-----------------------------------------------------------------
