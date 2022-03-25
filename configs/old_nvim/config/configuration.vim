""""""""""""""""""""
" General
""""""""""""""""""""
" https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
if !exists("g:syntax_on")
    syntax enable
endif
" Use 24 bit colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" Color scheme
set termguicolors
colorscheme dark_plus
" This is for the vertical separator line to disappear
set fillchars+=vert:\ " KEEP THIS COMMENT HERE, space needed after \
if &history < 1000  
    set history=1000                   " Set history level
endif
if &tabpagemax < 50
    set tabpagemax=50                  " Maximum tabs
endif
if !empty(&viminfo)
    set viminfo^=!                     " I don't know what this does to viminfo, but if it ain't broke..
endif
filetype plugin on                     " recommended by nerdcommenter
set directory=~/.nvim-data/tmp         " directory to place swap files in
" set backup                             " make backup files
" set backupdir=~/.nvim-data/backups     " where to put backup files
set nobackup                           " Some servers have issues with backup files, see #649 (CoC)
set nowritebackup                      " same as above (Coc)
set undofile                           " persistent undos - undo after you re-open the file
set undodir=~/.nvim-data/undodir       " undo directory
set hidden                             " disable E37: No write since last change (add ! to override)
                                       " https://medium.com/usevim/vim-101-set-hidden-f78800142855
set encoding=utf-8                     " Unicode
set showcmd                            " Show the commands being typed
set pastetoggle=F5                     " toggle paste mode on and off with F5
                                       " http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
set splitbelow                         " Split below
set splitright                         " Split right
set autoindent                         " Auto-indent new lines
set smartindent                        " Enable smart-indent
set shiftwidth=4                       " Number of auto-indent columns
set expandtab                          " Use spaces instead of tabs
set smarttab                           " Enable smart-tabs
set tabstop=4                          " Number of columns per Tab
set softtabstop=4                      " Number of columns per Tab
set foldmethod=marker                  " Enable folding http://vim.wikia.com/wiki/Folding
set foldlevelstart=20                  " http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
set gdefault                           " Always do global substitutes
set cmdheight=1                        " Height of command line
set updatetime=300                     " You will have bad experience for diagnostic messages when it's default 4000. (CoC)
set shortmess+=c                       " don't give |ins-completion-menu| messages. (CoC)
set signcolumn=yes                     " always show signcolumns
set scrolloff=5                        " Scroll when 0 lines from top/bottom
set number relativenumber              " Show line numbers and set number to current
set visualbell                         " Use visual bell (no beeping)
set t_vb=                              " Do not flash for visual bell
set hlsearch                           " Highlight all search results
set smartcase                          " Enable smart-case search
set ignorecase                         " Always case-insensitive
set incsearch                          " Searches for strings incrementally
" set showmatch                          " Highlight matching brace
set ruler                              " Show row and column ruler information
set ttimeout                           " Set timeouts
set ttimeoutlen=100                    " Set timeouts
set undolevels=2000                    " Number of undo levels
set backspace=indent,eol,start         " Backspace behaviour
set complete-=i                        " Remove 'included files' from complete
set nrformats-=octal                   " Remove octal from file numbers
set display+=lastline                  " Show last line
                                       " https://stackoverflow.com/questions/4621798/how-do-you-prevent-vim-from-showing-an-at-symbol-when-a-line-doesnt-fit-on

" set listchars=tab:>\ ,trail:⋅
" set listchars+=extends:>,precedes:<
" set listchars+=nbsp:+,eol:¬
set nolist                             " Do not disply special characters
set autoread                           " Reread files when changed externally
set nowrap                             " Do not wrap lines
set formatoptions-=t                   " Do not wrap text automatically
set pumblend=0                         " popup wildmenu blending
set textwidth=0                        " Maximum text width
" set colorcolumn=80,100                 " Colorize column(s)
" highlight ColorColumn guibg=#252525    " Colorize column(s)
set wildmenu                           " Show wildmenu when searching files
set wildmode=longest:full,full         " Tab functionality of wildmenu
set wildoptions+=pum                   " popup wildmenu
" Set up ignores
set wildignore+=*/tmp/*,*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf
set wildignore+=*.wav,*.mp4,*.mp3
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set wildignore+=_pycache_,.DS_Store,.vscode,.localized
set wildignore+=.cache,node_modules,package-lock.json,yarn.lock,dist,.git,.git/
set wildignore+=*.egg-info/
let python_highlight_all=1             " Make python look pretty
set sessionoptions-=options            " See https://github.com/tpope/vim-sensible/issues/117
set conceallevel=0                     " Don't conceal
let g:vim_json_syntax_conceal=0        " Don't conceal json
set exrc                               " Enable local .nvimrc files
set secure                             " disallows the use of :autocmd, shell and write commands

" To close netrw buffers
" https://vi.stackexchange.com/questions/14622/how-can-i-close-the-netrw-buffer
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0 " See second solution

" Highlight when over 100 characters
" augroup highlight_overflow
"   autocmd BufEnter * highlight OverLength guibg=#791929
"   autocmd BufEnter * match OverLength /\%101v.*/
" augroup END

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab


""""""""""""""""""""
" Airline
""""""""""""""""""""
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
" Use airline in tmux
" Keep this 0 to use custom conf file for tmuxline
let g:airline#extensions#tmuxline#enabled = 0
" let g:airline#extensions#tmuxline#enabled = 1
" start tmuxline even without vim running
" let airline#extensions#tmuxline#snapshot_file = "~/.tmux_airline_status.conf"
" tabline
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tabs = 1

""""""""""""""""""""
" Tmux
""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1 " Tmux nvim split switching integration

""""""""""""""""""""
" Vista 
""""""""""""""""""""
" let g:vista_default_executive = 'coc'

""""""""""""""""""""
" ALE
""""""""""""""""""""

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'tex': ['chktex'],
\   'css': ['stylelint'],
\   'cpp': ['g++']
\}

let g:ale_fixers = {
\   'python': ['black'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'cpp': ['astyle']
\}

" let g:ale_completion_enabled = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
let g:ale_python_black_options = "-l 120"
" let g:ale_python_black_options = "-S -l 79"
" let g:ale_python_black_options = "-S"
let g:ale_linter_aliases = {'jsx': 'css'}
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:ale_lint_delay = 200
" let g:ale_python_flake8_executable = $HOME .'/anaconda3/bin/flake8'
let g:ale_python_flake8_options = "--ignore=E302,E203,W503,E501"
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter% - %code%] %s (%severity%)'
let g:ale_sign_error = '⊗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'i'
let g:ale_sign_hint = 'h'
let g:ale_fix_on_save = 1
let g:ale_fix_on_insert_leave = 0
let g:ale_hover_to_preview = 1
let g:ale_set_highlights = 1
" let g:ale_disable_lsp = 1
set omnifunc=ale#completion#OmniFunc

""""""""""""""""""""
" Deoplete
""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

""""""""""""""""""""
" NERDCommenter
""""""""""""""""""""
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Disable autocommenting new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" This is for jsonc files used in coc
" let g:NERDCustomDelimiters = { 'json': { 'left': '//'} }

" For my config files
au BufNewFile,BufRead *.bd,*.ppc set filetype=configfile
let g:NERDCustomDelimiters = { 'configfile': { 'left': '#'} }

""""""""""""""""""""
" CoC
""""""""""""""""""""
" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')
" " Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" " use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" " coc in airline
" let g:airline#extensions#coc#enabled = 1
" let airline#extensions#coc#warning_symbol = 'Warning:'
" let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
" let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
" 
""""""""""""""""""""
" git-fugitive
""""""""""""""""""""
" :set tags^=./.git/tags;

""""""""""""""""""""
" Gutentags
""""""""""""""""""""
" vim-gutentags
let g:gutentags_enabled = 1
" " Generate a tags file if there is none.
let g:gutentags_generate_on_missing = 1
" " Don't regenerate tags file in a new Vim session (I tend to reopen Vim a lot).
let g:gutentags_generate_on_new = 1
" " Do update the tags file on file save.
let g:gutentags_generate_on_write = 1
let g:gutentags_resolve_symlinks = 1
let g:gutentags_generate_on_empty_buffer = 0
" " Make ctags add the language of the tag, so that we can postprocess the
" " tags file for fuzzy tag finding.
let g:gutentags_ctags_extra_args = ['-R --fields=+ailmnS --extra=+f']
let g:gutentags_cache_dir = $HOME .'/.tags'
" Airline + gutentags integration.
set statusline+=%{gutentags#statusline()}
" Show tags in the status line while gutentags is generating tags.
function! GutentagsStatus(...)
    let w:airline_section_a = g:airline_section_a .  '%{gutentags#statusline()}'
endfunction
autocmd VimEnter * call airline#add_statusline_func('GutentagsStatus')

""""""""""""""""""""
" NERDTree
""""""""""""""""""""
" Load NERDTree when staring up
" autocmd vimenter * NERDTree
" Close vim if only NERDTree is left
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
"             \ && b:NERDTree.isTabTree()) | q | endif
" Use \f to toggle nerdtree
" nnoremap <silent> <Leader>f :NERDTreeToggle<CR>
" Use \v to find the currently opened file in NERDTree
" nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" let NERDTreeShowHidden=1 " Show hidden files and folders
" let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

""""""""""""""""""""
" Hardtime
""""""""""""""""""""
" Enable hard mode
let g:hardtime_default_on = 0
let g:hardtime_showmsg = 1
let g:hardtime_timeout = 2000
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_insert_keys = []
let g:list_of_disabled_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
" These are the defaults
" let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
" let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
" let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
" let g:list_of_disabled_keys = []

""""""""""""""""""""
" YCM
""""""""""""""""""""
" let g:ycm_complete_in_comments = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_key_list_select_completion = ['<tab>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<s-tab>', '<Up>']

""""""""""""""""""""
" Ultisnips
""""""""""""""""""""
" let g:UltiSnipsExpandTrigger = "<leader><cr>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" make :UltiSnipsEdit to split window
" let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""
" vim-workspace
""""""""""""""""""""
" let g:workspace_session_directory = $HOME . '/.nvim-data/sessions/'
let g:workspace_autocreate = 1
" let g:workspace_undodir= $HOME . '/.nvim-data/undodir'
let g:workspace_autosave_always = 0
let g:workspace_autosave = 0
let g:workspace_create_new_tabs = 0
let g:workspace_session_disable_on_args = 0

""""""""""""""""""""
" vim-polyglot
""""""""""""""""""""
" THIS IS RAN BEFORE LOADING POLYGLOT IN plug.vim
" let g:polyglot_disabled = ['latex'] " Required by vimtex

""""""""""""""""""""
" vimtex
""""""""""""""""""""
" Recognize .tex files as latex (instead of plaintex) for syntax highlighting.
let g:tex_flavor="latex"
let g:vimtex_latexmk_build_dir = './build'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_progname = 'nvr'
let g:tex_conceal = ''
let g:vimtex_quickfix_mode=0
" from https://github.com/lervag/vimtex/issues/1083#issuecomment-372930307
nnoremap <silent><buffer> <leader>lv :<c-u>call <sid>OpenViewer()<cr>
function! s:OpenViewer()
  " Open the viewer and/or do forward search
  VimtexView
  " Add a very small amount of sleep time to allow previous process to finish,
  " you should experiment with the exact amount. Perhaps not necessary at all.
  sleep 50m
  " Now use xdotool to focus the viewer
  if b:vimtex.viewer.xwin_id
    call system('xdotool windowactivate '.b:vimtex.viewer.xwin_id.' &')
  endif
endfunction
" For latex interactive mode
" See https://github.com/lervag/vimtex/issues/262
" ALSO SETUP OKULAR
" https://github.com/lervag/vimtex/wiki/introduction#neovim
" Essentially choose custom editor and put this:
" nvr --remote-silent %f -c %l
" let g:vimtex_latexmk_progname = 'nvr'

""""""""""""""""""""
" Markdown
""""""""""""""""""""
" let g:mkdp_auto_start = 0
" let g:mkdp_auto_close = 1

""""""""""""""""""""
" clever-f
""""""""""""""""""""
" let g:clever_f_across_no_line    = 1
" let g:clever_f_fix_key_direction = 1
" let g:clever_f_timeout_ms        = 3000

""""""""""""""""""""
" indentLine
""""""""""""""""""""
let g:indentLine_faster     = 1
let g:indentLine_setConceal = 0

""""""""""""""""""""
" C++ highlighting
""""""""""""""""""""
let g:cpp_class_decl_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1


""""""""""""""""""""
" fzf
""""""""""""""""""""
" To fix the problem of Escape key
" https://github.com/junegunn/fzf/issues/1393#issuecomment-426576577
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>


""""""""""""""""""""
" nvim-colorizer.lua
""""""""""""""""""""
lua require'colorizer'.setup()

