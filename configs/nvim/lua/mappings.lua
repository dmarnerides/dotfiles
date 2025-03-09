local map = vim.api.nvim_set_keymap

-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wq wq
    cnoreabbrev Wqa wqa
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
    cnoreabbrev Vs vs
]])

-- Use # instead of : for commands
map("n", "#", ":", {noremap = true, desc="[Mine] Use # instead of : for commands"})
map("v", "#", ":", {noremap = true, desc="[Mine] Use # instead of : for commands"})

-- Use L to go to end of line (last non-whitespace)
map("n", "L", "g_", {noremap = true, desc = "[Mine] Go to end of line (last non-whitespace character)"})
map("v", "L", "g_", {noremap = true, desc = "[Mine] Go to end of line (last non-whitespace character)"})

-- Use H to go to start of line (first non-whitespace)
map("n", "H", "^", {noremap = true, desc = "[Mine] Go to start of line (first non-whitespace character)"})
map("v", "H", "^", {noremap = true, desc = "[Mine] Go to start of line (first non-whitespace character)"})

-- \p pastes after cursor with space added before
map("n", "<leader>p", 'a<space><C-r>"<esc>', {desc = "[Mine] Paste after cursor with a preceding space"})
-- \P pastes before cursor with space added after
map("n", "<leader>P", 'i<C-r>"<space><esc>', {desc = "[Mine] Paste before cursor with a trailing space"})
-- Clear search results using leader space
map("n", "<leader><space>", ":noh<cr>", {silent = true, desc = "[Mine] Clear search highlighting"})

-- Buffer changes
map("n", "<leader>bn", ":bn<CR>", {desc = "[Mine] Switch to next buffer"})
map("n", "<F4>", ":bn<CR>", {desc = "[Mine] Switch to next buffer"})
map("n", "<leader>bp", ":bp<CR>", {desc = "[Mine] Switch to previous buffer"})
map("n", "<F3>", ":bp<CR>", {desc = "[Mine] Switch to previous buffer"})
map("n", "<leader>bb", ":b#<CR>", {desc = "[Mine] Switch to alternate buffer"})
map("n", "<F2>", ":b#<CR>", {desc = "[Mine] Switch to alternate buffer"})

-- See http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
map("i", "<c-u>", "<c-g>u<c-u>", {noremap = true, desc = "[Mine] Make Ctrl-U undo-friendly in insert mode"})
map("i", "<c-w>", "<c-g>u<c-w>", {noremap = true, desc = "[Mine] Make Ctrl-W undo-friendly in insert mode"})

-- Map `Y` to copy to end of line (consistent with the behaviour of `C` and `D`)
map("n", "Y", "y$", {noremap = true, desc = "[Mine] Copy from cursor to end of line"})
map("v", "Y", "<Esc>y$gv", {noremap = true, desc = "[Mine] Copy from cursor to end of line in visual mode and reselect"})

-- Keep visual selection when (de)indenting
map("v", "<", "<gv", {noremap = true, desc = "[Mine] Keep visual selection when indenting left"})
map("v", ">", ">gv", {noremap = true, desc = "[Mine] Keep visual selection when indenting right"})

-- Move selected lines up/down in visual mode
map("x", "K", ":move '<-2<CR>gv=gv", {noremap = true, desc = "[Mine] Move selected lines up"})
map("x", "J", ":move '>+1<CR>gv=gv", {noremap = true, desc = "[Mine] Move selected lines down"})

-- Map <leader>o & <leader>O to newline without insert mode
map("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', {noremap = true, silent = true, desc = "[Mine] Insert new line(s) below current line without entering insert mode"})
map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {noremap = true, silent = true, desc = "[Mine] Insert new line(s) above current line without entering insert mode"})

-- Map escape to cancel the command line
map("c", "<Esc>", '"<C-c>"', {noremap = true, expr = true, desc = "[Mine] Cancel command-line mode with escape"})

-- Use escape to undo (and handle popup visibility)
map("i", "<Esc>", 'pumvisible() ? "\\<C-c>" : "\\<Esc>"', {noremap = true, expr = true, desc = "[Mine] Handle escape in insert mode: cancel completion popup if visible"})
map("i", "<cr>",
      'pumvisible() ? (complete_info().selected == -1 ? "\\<C-n><C-y><C-o>:pclose<cr>": "\\<C-y><C-o>:pclose<cr>" ) : "\\<cr>"',
      {noremap = true, expr = true, desc = "[Mine] Confirm completion if popup visible, else insert newline"})

-- Use tab to move around completion stuff
-- remap("i", "<TAB>", 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', {noremap = true, silent = true, expr = true})
-- remap("i", "<S-TAB>", 'pumvisible() ? "\\<C-p>" : "\\<S-TAB>"', {noremap = true, expr = true})
