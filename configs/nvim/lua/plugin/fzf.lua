vim.g.fzf_command_prefix = "Fzf"

vim.g.fzf_layout = {
    ["window"] = {
        ["width"] = 0.8,
        ["height"] = 0.8
    }
}

-- Ctrl-q allows to select multiple elements an open them in quick list
vim.g.fzf_action = {
    -- ['ctrl-q'] = vim.fn['s:build_quickfix_list'],
    ["ctrl-q"] = function(lines)
        local qf_entries = {}
        for _, entry in pairs(lines) do
            table.insert(qf_entries, {filename = entry, lnum = 0, col = 0})
        end
        vim.fn.setqflist(qf_entries, "r")
        vim.cmd "copen"
    end,
    ["ctrl-t"] = "tab split",
    ["ctrl-s"] = "split",
    ["ctrl-v"] = "vsplit"
}

-- [Buffers] Jump to the existing window if possible
vim.g.fzf_buffers_jump = 1

-- Preview window options
vim.g.fzf_preview_window = {"down:50%:nowrap"}

-- Preview window color scheme
vim.env.BAT_THEME = "1337"

-- Overwrite the default command for :FzfFiles
-- exclude nodejs modules and python cache files (__pycache__)
vim.env.FZF_DEFAULT_COMMAND = [[fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude '*.pyc']]

-- <F2>        toggle preview
-- <F3>        toggle preview text wrap
-- <C-f>|<C-b> page down|up
-- <C-d>|<C-u> preview page down|up
-- <C-a>       toggle select-all
-- <C-l>       clear query
vim.env.FZF_DEFAULT_OPTS =
    [[--layout=reverse --preview-window="border:nowrap" --info=inline --multi --bind="f2:toggle-preview,f3:toggle-preview-wrap,shift-down:preview-page-down,shift-up:preview-page-up,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up,ctrl-a:toggle-all,ctrl-l:clear-query"]]

-- load the rest of the non converted vimL
vim.cmd [[runtime fzf.vim]]

local remap = vim.api.nvim_set_keymap

-- fzf shortcuts
remap("n", "<leader><F1>", ":FzfHelptags<CR>", {noremap = true, silent = true})
remap("n", "<leader>z;", ":FzfBuffers<CR>", {noremap = true, silent = true})
-- remap('n', '<leader>zf'  , ':FzfFiles<CR>',     { noremap = true, silent = true })
remap("n", "<leader>zf", ":FzfDevicons<CR>", {noremap = true, silent = true})
remap("n", "<leader>zg", ":FzfGFiles<CR>", {noremap = true, silent = true})
remap("n", "<leader>zm", ":FzfMarks<CR>", {noremap = true, silent = true})
remap("n", "<leader>zc", ":FzfCommands<CR>", {noremap = true, silent = true})
remap("n", "<leader>zh", ":FzfHistory<CR>", {noremap = true, silent = true})
remap("n", "<leader>zx", ":FzfHistory:<CR>", {noremap = true, silent = true})
remap("n", "<leader>zs", ":FzfHistory/<CR>", {noremap = true, silent = true})
remap("n", "<leader>zo", ":FzfColors<CR>", {noremap = true, silent = true})
remap("n", "<leader>zb", ":FzfBLines<CR>", {noremap = true, silent = true})
remap("n", "<leader>zt", ":FzfBTags<CR>", {noremap = true, silent = true})
remap("n", "<leader>zT", ":FzfTags<CR>", {noremap = true, silent = true})
remap("n", "<leader>zC", ":FzfCommits<CR>", {noremap = true, silent = true})

-- fzf|ripgrep shortcuts
-- <leader>fl    live search using `rg`
-- <leader>fr    search using `rg`
-- <leader>fw    search word under cursor
-- <leader>fv    search visual selection
remap("n", "<leader>zl", ":<C-U><C-R> FzfRG<CR>", {noremap = true})
remap("n", "<leader>zr", ":<C-U><C-R> FzfRg<Space>", {noremap = true})
remap("n", "<leader>zw", ":<C-U><C-R> FzfRg <C-R><C-W><CR>", {noremap = true})
remap("n", "<leader>zW", ":<C-U><C-R> FzfRg <C-R><C-A><CR>", {noremap = true})
-- remap('n', '<leader>zv', ':<C-U><C-R> FzfRg <C-R>=<SID>getVisualSelection()<CR><CR>', { noremap = true })
remap("n", "<leader>zv", ":<C-U>lua require('plugin.fzf').rg_visualselection()<CR>", {noremap = true})
remap("v", "<leader>zv", ":<C-U>lua require('plugin.fzf').rg_visualselection()<CR>", {noremap = true})

-- These are still not converted to Lua
vim.api.nvim_exec([=[
" https://github.com/junegunn/fzf.vim#advanced-customization
" FzfRg only starts ripgrep after the query is entered
" the below version delegates all work to ripgrep and
" will restart ripgrep every query modification
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang FzfRG
    \ lua require('utils').ensure_loaded_cmd({'fzf.vim'}, {[[
    \ call RipgrepFzf(<q-args>, <bang>0)
    \]]})

" customize FzfRg
" we add ' || true' so rg never raises error
let g:rg_nonfail = ' || true'
command! -bang -nargs=* FzfRg 
    \ lua require('utils').ensure_loaded_cmd({'fzf.vim'}, {[[
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>).g:rg_nonfail, 1,
    \   fzf#vim#with_preview(), <bang>0)
    \]]})

" workaround for :FzfBuffers not working after nvim-reload
command! -bar -bang -nargs=? -complete=buffer FzfBuffers
    \ lua require('utils').ensure_loaded_cmd({'fzf.vim'}, {[[
    \ call fzf#vim#buffers(<q-args>,
    \   fzf#vim#with_preview({ "placeholder": "{1}" }), <bang>0)
    \]]})

" Files + devicons
function! FZFWithDevIcons()
  let l:fzf_files_options = ' -m --bind shift-down:preview-page-down,shift-up:preview-page-up --preview-window=down --preview "bat --color always --style numbers {2..}"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:extension = fnamemodify(l:candidate, ':e')
      " let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      if empty(l:extension)
        let l:extension = 'ini'
      end
      let l:icon = luaeval(printf("require'nvim-web-devicons'.get_icon('%s', '%s')", l:filename, l:extension))
      call add(l:result, printf('%s %s', l:icon!=v:null?l:icon:' ', l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(items)
    let items = a:items
    let i = 1
    let ln = len(items)
    while i < ln
      let item = substitute(items[i], '^\s*\(.\{-}\)\s*$', '\1', '')
      let pos = stridx(item, ' ')
      let file_path = item[pos+1:-1]
      let items[i] = file_path
      let i += 1
    endwhile
    call s:Sink(items)
  endfunction

  let opts = fzf#wrap({})
  let opts.source = <sid>files()
  let s:Sink = opts['sink*']
  let opts['sink*'] = function('s:edit_file')
  let opts.options .= l:fzf_files_options
  call fzf#run(opts)
endfunction

command! -nargs=* -bang FzfDevicons
    \ lua require('utils').ensure_loaded_cmd({'fzf.vim'}, {[[
    \ call FZFWithDevIcons()
    \]]})
]=], false)

local M = {}

function M.rg_visualselection()
    local search = require("utils").get_visual_selection()
    vim.cmd("FzfRg " .. search)
end


return M
