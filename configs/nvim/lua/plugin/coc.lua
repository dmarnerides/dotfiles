vim.g.coc_global_extensions = {
    -- 'coc-clangd',
    'coc-cmake',
    'coc-css',
    'coc-cssmodules',
    'coc-eslint',
    'coc-git',
    'coc-html',
    'coc-html-css-support',
    'coc-json',
    'coc-markdown-preview-enhanced',
    'coc-prettier',
    'coc-pyright',
    -- '@yaegassy/coc-pylsp',
    -- 'coc-jedi',
    'coc-sh',
    'coc-yaml',
    'coc-sumneko-lua'
}

local remap = vim.api.nvim_set_keymap

-- This function is for the tab functionality
vim.api.nvim_exec([[
function! Coc_check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]], false)
-- These tab settings are according to coc (uncommented the ones above)
remap("i", "<TAB>", [[pumvisible() ? "<C-n>" : Coc_check_back_space() ? "<TAB>" : coc#refresh()]], {noremap = true, silent = true, expr = true})
remap("i", "<S-TAB>", 'pumvisible() ? "\\<C-p>" : "\\<C-h>"', {noremap = true, expr = true})


-- Use <c-space> to trigger completion.
remap("i","<c-space>" , "coc#refresh()", {noremap = true, silent = true, expr = true})
-- CoC diagnostics

remap("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent=true})
remap("n", "]g", "<Plug>(coc-diagnostic-next)", {silent=true})

-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
remap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

-- GoTo code navigation
remap("n", "gd", "<Plug>(coc-definition)", {silent = true})
remap("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
remap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
remap("n", "gr", "<Plug>(coc-references)", {silent = true})


vim.api.nvim_exec([[
function! Coc_show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
]], false)

-- Use K to show documentation in preview window.
remap("n", "K", ":call Coc_show_documentation()<CR>", {silent = true, noremap=true})

-- Symbol renaming.
remap("n", "<leader>rn", "<Plug>(coc-rename)", {})

-- Formatting selected code
remap("x", "<leader>f", "<Plug>(coc-format-selected)", {})
remap("n", "<leader>f", "<Plug>(coc-format-selected)", {})

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
remap("x", "<leader>a", "<Plug>(coc-codeaction-selected)", {})
remap("n", "<leader>a", "<Plug>(coc-codeaction-selected)", {})

-- Remap keys for applying codeAction to the current buffer.
remap("n", "<leader>ac", "<Plug>(coc-codeaction)", {})

-- Apply AutoFix to problem on the current line.
remap("n", "<leader>qf", "<Plug>(coc-fix-current)", {})

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
remap("x", "if", "<Plug>(coc-funcobj-i)", {})
remap("o", "if", "<Plug>(coc-funcobj-i)", {})
remap("x", "af", "<Plug>(coc-funcobj-a)", {})
remap("o", "af", "<Plug>(coc-funcobj-a)", {})
remap("x", "ic", "<Plug>(coc-classobj-i)", {})
remap("o", "ic", "<Plug>(coc-classobj-i)", {})
remap("x", "ac", "<Plug>(coc-classobj-a)", {})
remap("o", "ac", "<Plug>(coc-classobj-a)", {})

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
remap("n", "<C-s>", "<Plug>(coc-range-select)", {silent=true})
remap("x", "<C-s>", "<Plug>(coc-range-select)", {silent=true})

-- I did not convert these to lua yet
vim.api.nvim_exec([[
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
]], false)

-- Airline
vim.g["airline#extensions#coc#enabled"] = 1
vim.g["airline#extensions#coc#error_symbol"] = 'Error:'
vim.g["airline#extensions#coc#warning_symbol"] = 'Warning:'
vim.g["airline#extensions#coc#stl_format_err"] = '%E{[%e(#%fe)]}'
vim.g["airline#extensions#coc#stl_format_warn"] = '%W{[%w(#%fw)]}'

