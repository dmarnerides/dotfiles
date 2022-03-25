local remap = vim.api.nvim_set_keymap

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
remap("n", "#", ":", {noremap = true})
remap("v", "#", ":", {noremap = true})

-- Use L to go to end of line (last non whitespace)
remap("n", "L", "g_", {noremap = true})
remap("v", "L", "g_", {noremap = true})

-- Use H to go to start of line (last non whitespace)
remap("n", "H", "^", {noremap = true})
remap("v", "H", "^", {noremap = true})

-- \p pastes after cursor with space added before
remap("n", "<leader>p", 'a<space><C-r>"<esc>', {})
-- \P pastes before cursor with space added after
remap("n", "<leader>P", 'i<C-r>"<space><esc>', {})
-- Clear search results using leader space
remap("n", "<leader><space>", ":noh<cr>", {silent = true})
-- Folding
remap("n", "<Space>", '@=(foldlevel(".")?"za":"<Space>")<CR>', {silent = true})
remap("v", "<Space>", "zf", {})
-- Buffer changes
remap("n", "<leader>bn", ":bn<CR>", {})
remap("n", "<F4>", ":bn<CR>", {})
remap("n", "<leader>bp", ":bp<CR>", {})
remap("n", "<F3>", ":bp<CR>", {})
remap("n", "<leader>bb", ":b#<CR>", {})
remap("n", "<F2>", ":b#<CR>", {})
-- See http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
remap("i", "<c-u>", "<c-g>u<c-u>", {noremap = true})
remap("i", "<c-w>", "<c-g>u<c-w>", {noremap = true})

--
-- Tmux
--
remap("n", "<M-p>", ":TmuxNavigatePrevious<CR>", {silent = true})
remap("n", "<M-l>", ":TmuxNavigateRight<CR>", {silent = true})
remap("n", "<M-k>", ":TmuxNavigateUp<CR>", {silent = true})
remap("n", "<M-j>", ":TmuxNavigateDown<CR>", {silent = true})
remap("n", "<M-h>", ":TmuxNavigateLeft<CR>", {silent = true})
remap("n", "<M-Right>", ":TmuxNavigateRight<CR>", {silent = true})
remap("n", "<M-Up>", ":TmuxNavigateUp<CR>", {silent = true})
remap("n", "<M-Down>", ":TmuxNavigateDown<CR>", {silent = true})
remap("n", "<M-Left>", ":TmuxNavigateLeft<CR>", {silent = true})

-- -- Quickfix list mappings
-- remap("n", "<leader>q", "<cmd>lua require'utils'.toggle_qf('q')<CR>", {noremap = true})
-- remap("n", "[q", ":cprevious<CR>", {noremap = true})
-- remap("n", "]q", ":cnext<CR>", {noremap = true})
-- remap("n", "[Q", ":cfirst<CR>", {noremap = true})
-- remap("n", "]Q", ":clast<CR>", {noremap = true})
-- -- Location list mappings
-- remap("n", "<leader>Q", "<cmd>lua require'utils'.toggle_qf('l')<CR>", {noremap = true})
-- remap("n", "[l", ":lprevious<CR>", {noremap = true})
-- remap("n", "]l", ":lnext<CR>", {noremap = true})
-- remap("n", "[L", ":lfirst<CR>", {noremap = true})
-- remap("n", "]L", ":llast<CR>", {noremap = true})
-- -- Tags / Preview tags
-- remap("n", "[t", ":tprevious<CR>", {noremap = true})
-- remap("n", "]t", ":tNext<CR>", {noremap = true})
-- remap("n", "[T", ":tfirst<CR>", {noremap = true})
-- remap("n", "]T", ":tlast<CR>", {noremap = true})
-- remap("n", "[p", ":ptprevious<CR>", {noremap = true})
-- remap("n", "]p", ":ptnext<CR>", {noremap = true})
-- remap('n', '<Leader>ts', ':<C-u>tselect <C-r><C-w><CR>', { noremap = true })

-- <leader>v|<leader>s act as <cmd-v>|<cmd-s>
-- <leader>p|P paste from yank register (0)
-- remap("n", "<leader>v", '"+p', {noremap = true})
-- remap("n", "<leader>V", '"+P', {noremap = true})
-- remap("v", "<leader>v", '"_d"+p', {noremap = true})
-- remap("v", "<leader>v", '"_d"+P', {noremap = true})
-- remap("n", "<leader>s", '"*p', {noremap = true})
-- remap("n", "<leader>S", '"*P', {noremap = true})
-- remap("v", "<leader>s", '"*p', {noremap = true})
-- remap("v", "<leader>S", '"*p', {noremap = true})

-- Overloads for 'd|c' that don't pollute the unnamed registers
-- In visual-select mode 'd=delete, x=cut (unchanged)'
-- remap("n", "<leader>d", '"_d', {noremap = true})
-- remap("n", "<leader>D", '"_D', {noremap = true})
-- remap("n", "<leader>c", '"_c', {noremap = true})
-- remap("n", "<leader>C", '"_C', {noremap = true})
-- remap("v", "<leader>c", '"_c', {noremap = true})
-- remap("v", "d", '"_d', {noremap = true})

-- Map `Y` to copy to end of line
-- conistent with the behaviour of `C` and `D`
remap("n", "Y", "y$", {noremap = true})
remap("v", "Y", "<Esc>y$gv", {noremap = true})

-- keep visual selection when (de)indenting
remap("v", "<", "<gv", {noremap = true})
remap("v", ">", ">gv", {noremap = true})

-- Move selected lines up/down in visual mode
remap("x", "K", ":move '<-2<CR>gv=gv", {noremap = true})
remap("x", "J", ":move '>+1<CR>gv=gv", {noremap = true})

-- Map <leader>o & <leader>O to newline without insert mode
remap("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', {noremap = true, silent = true})
remap("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {noremap = true, silent = true})


-- Use escape to undo
remap("i", "<Esc>", 'pumvisible() ? "\\<C-c>" : "\\<Esc>"', {noremap = true, expr = true})
remap("i", "<cr>",
      'pumvisible() ? (complete_info().selected == -1 ? "\\<C-n><C-y><C-o>:pclose<cr>": "\\<C-y><C-o>:pclose<cr>" ) : "\\<cr>"',
      {noremap = true, expr = true})

-- Map escape to cancel the command line
remap("c", "<Esc>", '"<C-c>"', {noremap = true, expr = true})

-- Use tab to move around completion stuff
-- remap("i", "<TAB>", 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', {noremap = true, silent = true, expr = true})
-- remap("i", "<S-TAB>", 'pumvisible() ? "\\<C-p>" : "\\<S-TAB>"', {noremap = true, expr = true})

