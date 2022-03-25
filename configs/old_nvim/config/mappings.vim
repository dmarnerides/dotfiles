""""""""""""""""""""
" General
""""""""""""""""""""
" Use # instead of : for commands
nnoremap # :
vnoremap # :
" Use L to go to end of line (last non whitespace)
nnoremap L g_
vnoremap L g_
" use H to go to start of line (first non whitespace)
nnoremap H ^
vnoremap H ^
" \p pastes after cursor with space added before
nnoremap <leader>p a<space><C-r>"<esc>
" \P pastes before cursor with space added after
nnoremap <leader>P i<C-r>"<space><esc>
" Clear search results using leader space
nnoremap <leader><space> :noh<cr>
" Folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" Buffer changes
nnoremap <F4> :bn<CR>
nnoremap <F3> :bp<CR>
nnoremap <F2> :b#<CR>
" Use Ctrl-c to close buffer without closing split
nnoremap <C-c> :bp\|bd #<CR>
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><tab> :noh<cr>
" See http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Go to definition using tags rebinding
nnoremap gd <C-]>
" "Go back" gb
nnoremap gb <C-o>

"""""""""""""""""""""""""""""""""""""""
" Neovim terminal mappings
"""""""""""""""""""""""""""""""""""""""
" Escape to exit terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>
" To simulate |i_CTRL-R| in terminal-mode
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" Remap motion between windows
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <leader>t :call TermToggle(12)<CR>
" inoremap <leader>t <Esc>:call TermToggle(12)<CR>
tnoremap <leader>t <C-\><C-n>:call TermToggle(12)<CR>

""""""""""""""""""""
" Clap
""""""""""""""""""""
" \e brings up file list with clap
" nnoremap <leader>e :Clap files<CR>

""""""""""""""""""""
" Tmux 
""""""""""""""""""""
nnoremap <silent> <M-\> :TmuxNavigatePrevious<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-Right> :TmuxNavigateRight<CR>
nnoremap <silent> <M-Up> :TmuxNavigateUp<CR>
nnoremap <silent> <M-Down> :TmuxNavigateDown<CR>
nnoremap <silent> <M-Left> :TmuxNavigateLeft<CR>

""""""""""""""""""""
" CoC
""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" <TAB>: completion.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" " Use <c-space> to trigger completion. (make window appear if its gone)
" inoremap <silent><expr> <c-space> coc#refresh()
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" " Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
" " Highlight symbol under cursor on CursorHold
" " autocmd CursorHold * silent call CocActionAsync('highlight')
" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
" " Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" " Correct commenting for jsonc files (json configuration)
" autocmd FileType json syntax match Comment +\/\/.\+$+
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)
" " Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)
" " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""
" ALE
""""""""""""""""""""
nmap <silent> ]g :ALENextWrap<cr>
nmap <silent> [g :ALEPreviousWrap<cr>
nnoremap <leader>g  :ALEGoToDefinition<cr>
nnoremap <leader>r  :ALEFindReferences<cr>

""""""""""""""""""""
" Deoplete
""""""""""""""""""""
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

""""""""""""""""""""
" YCM
""""""""""""""""""""
" Use <leader> g to go to definition
" nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

