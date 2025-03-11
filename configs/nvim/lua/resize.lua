local M = {}

-- Move the vertical divider for horizontal resizing.
-- For the rightmost window, adjust the left border; otherwise, adjust the right border.
function M.MoveRight()
  local cur_win = vim.api.nvim_get_current_win()
  local wininfo = vim.fn.getwininfo()
  local current_info = nil
  for _, win in ipairs(wininfo) do
    if win.winid == cur_win then
      current_info = win
      break
    end
  end
  if not current_info then
    return
  end

  -- Gather windows on the same row.
  local same_row = {}
  for _, win in ipairs(wininfo) do
    if win.winrow == current_info.winrow then
      table.insert(same_row, win)
    end
  end
  table.sort(same_row, function(a, b) return a.wincol < b.wincol end)

  -- Special case: current window is rightmost.
  if current_info.winid == same_row[#same_row].winid then
    vim.cmd(":execute \"normal! \\<C-w>h\"")
    vim.cmd(":execute \"normal! \\<C-w>>\"")
    vim.cmd(":execute \"normal! \\<C-w>l\"")
  else
    vim.cmd(":execute \"normal! \\<C-w>>\"")
  end
end

function M.MoveLeft()
  local cur_win = vim.api.nvim_get_current_win()
  local wininfo = vim.fn.getwininfo()
  local current_info = nil
  for _, win in ipairs(wininfo) do
    if win.winid == cur_win then
      current_info = win
      break
    end
  end
  if not current_info then
    return
  end

  -- Gather windows on the same row.
  local same_row = {}
  for _, win in ipairs(wininfo) do
    if win.winrow == current_info.winrow then
      table.insert(same_row, win)
    end
  end
  table.sort(same_row, function(a, b) return a.wincol < b.wincol end)

  -- Special case: current window is rightmost.
  if current_info.winid == same_row[#same_row].winid then
    vim.cmd(":execute \"normal! \\<C-w>h\"")
    vim.cmd(":execute \"normal! \\<C-w><\"")
    vim.cmd(":execute \"normal! \\<C-w>l\"")
  else
    vim.cmd(":execute \"normal! \\<C-w><\"")
  end
end

-- Vertical resizing.
-- For vertical moves, group windows by column.
-- The lowermost window is the special case: if so, adjust the border above it.
function M.MoveDown()
  local cur_win = vim.api.nvim_get_current_win()
  local wininfo = vim.fn.getwininfo()
  local current_info = nil
  for _, win in ipairs(wininfo) do
    if win.winid == cur_win then
      current_info = win
      break
    end
  end
  if not current_info then
    return
  end

  -- Gather windows in the same column.
  local same_col = {}
  for _, win in ipairs(wininfo) do
    if win.wincol == current_info.wincol then
      table.insert(same_col, win)
    end
  end
  table.sort(same_col, function(a, b) return a.winrow < b.winrow end)

  -- Special case: current window is lowermost.
  if current_info.winid == same_col[#same_col].winid then
    vim.cmd(":execute \"normal! \\<C-w>k\"")
    vim.cmd(":execute \"normal! \\<C-w>+\"")
    vim.cmd(":execute \"normal! \\<C-w>j\"")
  else
    vim.cmd(":execute \"normal! \\<C-w>+\"")
  end
end

function M.MoveUp()
  local cur_win = vim.api.nvim_get_current_win()
  local wininfo = vim.fn.getwininfo()
  local current_info = nil
  for _, win in ipairs(wininfo) do
    if win.winid == cur_win then
      current_info = win
      break
    end
  end
  if not current_info then
    return
  end

  -- Gather windows in the same column.
  local same_col = {}
  for _, win in ipairs(wininfo) do
    if win.wincol == current_info.wincol then
      table.insert(same_col, win)
    end
  end
  table.sort(same_col, function(a, b) return a.winrow < b.winrow end)

  -- Special case: current window is lowermost.
  if current_info.winid == same_col[#same_col].winid then
    vim.cmd(":execute \"normal! \\<C-w>k\"")
    vim.cmd(":execute \"normal! \\<C-w>-\"")
    vim.cmd(":execute \"normal! \\<C-w>j\"")
  else
    vim.cmd(":execute \"normal! \\<C-w>-\"")
  end
end

vim.api.nvim_set_keymap('n', '<M->>', ":lua require('resize').MoveRight()<CR>", { noremap=true, silent = true, desc = "Resize right" })
vim.api.nvim_set_keymap('n', '<M-<>', ":lua require('resize').MoveLeft()<CR>",  { noremap=true, silent = true, desc = "Resize left" })
vim.api.nvim_set_keymap('n', '<M-}>', ":lua require('resize').MoveDown()<CR>",  { noremap=true, silent = true, desc = "Resize down" })
vim.api.nvim_set_keymap('n', '<M-{>', ":lua require('resize').MoveUp()<CR>",    { noremap=true, silent = true, desc = "Resize up" })

return M

