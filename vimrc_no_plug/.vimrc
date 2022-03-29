syntax on
set termguicolors
colorscheme my_nvcode

" General settings
set nocompatible
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set hidden
set nobackup
set nowritebackup
set mouse= "
set modelines=1
set noexrc
set secure
set noerrorbells
set novisualbell
set autoread
set switchbuf=useopen
set backspace=indent,eol,start

set updatetime=300 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes
set path=.,,,$PWD/**
set fillchars+=vert:\ " KEEP THIS COMMENT HERE, space needed after \

if &history < 1000
  set history=1000
endif


set showmode " show current mode (insert, etc) under the cmdline
set showcmd " show current command under the cmd line
set cmdheight=1 " cmdline height
set laststatus=2 " 2 = always show status line (filename, etc)
set scrolloff=3 " min number of lines to keep between cursor and screen edge
set sidescrolloff=5 " min number of cols to keep between cursor and screen edge
set textwidth=0 " max inserted text width for paste operations
set linespace=0 " font spacing
set ruler " show line,col at the cursor pos
set number " show absolute line no. at the cursor pos
set relativenumber " otherwise, show relative numbers in the ruler
set nocursorline " Don't show a line where the current cursor is
set signcolumn=number " merge signcolumn and number column into one
set nowrap " don't wrap long lines
set nolist
set listchars=eol:$,nbsp:␣,trail:•,extends:>,precedes:<,space:␣
" set listchars=eol:↲,tab:→,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:␣
set showbreak=↪
set completeopt=noinsert,menuone,noselect " show menu even for one item do not auto select/insert
set wildmenu
set wildmode=longest:full,full
set wildignore=*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf,*.wav,*.mp4,*.mp3,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*/.bundle/*,*/.sass-cache/*,*.swp,*~,._*,_pycache_,.DS_Store,.vscode,.localized,*.egg-info/,.cache,node_modules,package-lock.json,yarn.lock,dist,.git,.git/
set shortmess+=c " Don't pass messages to |ins-completion-menu|.

set joinspaces " insert spaces after '.?!' when joining lines
set autoindent " copy indent from current line on newline
set smartindent " add <tab> depending on syntax (C/C++)
set nostartofline " keep cursor column on navigation
set tabstop=4 " Tab indentation levels every two columns
set softtabstop=4 " Tab indentation when mixing tabs & spaces
set shiftwidth=4 " Indent/outdent by two columns
set shiftround " Always indent/outdent to nearest tabstop
set expandtab " Convert all tabs that are typed into spaces
set smarttab " Use shiftwidths at left margin, tabstops everywhere else
set splitbelow " ':new' ':split' below current
set splitright " ':vnew' ':vsplit' right of current
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level
set undofile " use an undo file
set hidden " do not unload buffer when abandoned
set noautochdir " do not change dir when opening a file
set magic "  use 'magic' chars in search patterns
set hlsearch " highlight all text matching current search pattern
set incsearch " show search matches as you type
set ignorecase " ignore case on search
set smartcase " case sensitive when search includes uppercase
set showmatch " highlight matching [{()}]
set wrapscan " begin search from top of the file when nothng is found
set cpoptions+=x " stay at seach item when <esc>
set nobackup " no backup file
set nowritebackup " do not backup file before write
set noswapfile " no swap file

set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
set diffopt=internal,filler,algorithm:histogram,indent-heuristic

" Disable some in built plugins completely
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
let g:loaded_netrwSettings=1
let g:loaded_netrwFileHandlers=1
let g:loaded_gzip=1
let g:loaded_zip=1
let g:loaded_zipPlugin=1
let g:loaded_tar=1
let g:loaded_tarPlugin=1
let g:loaded_getscript=1
let g:loaded_getscriptPlugin=1
let g:loaded_vimball=1
let g:loaded_vimballPlugin=1
let g:loaded_2html_plugin=1
let g:loaded_logipat=1
let g:loaded_rrhelper=1
let g:loaded_spellfile_plugin=1


"
" Mappings
"

" Fix common typos
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

" Use # instead of : for commands
nnoremap # :
vnoremap # :


" Use L to go to end of line (last non whitespace)
nnoremap L g_
vnoremap L g_

" Use H to go to start of line (last non whitespace)
nnoremap H ^
vnoremap H ^

" \p pastes after cursor with space added before
nmap <leader>p a<space><C-r>"<esc>

" \P pastes before cursor with space added after
nmap <leader>P i<C-r>"<space><esc>

" Clear search results using leader space
nmap <silent> <leader><space> :noh<cr>

" Buffer changes
nmap <leader>bn :bn<CR>
nmap <F4> :bn<CR>
nmap <leader>bp :bp<CR>
nmap <F3> :bp<CR>
nmap <leader>bb :b#<CR>
nmap <F2> :b#<CR>

" See http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Map `Y` to copy to end of line
" conistent with the behaviour of `C` and `D`
nnoremap Y y$
vnoremap Y <Esc>y$gv

" keep visual selection when (de)indenting
vnoremap < <gv
vnoremap > >gv

" Move selected lines up/down in visual mode
xnoremap K :move '<-2<CR>gv=gv
xnoremap J :move '>+1<CR>gv=gv

" Map <leader>o & <leader>O to newline without insert mode
nnoremap <silent> <leader>o :<C-u>call append(line("."), repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

"
" Autocommands
"
autocmd BufEnter * setlocal formatoptions-=cro

" Python colorize allow
let g:python_highlight_all=1

filetype plugin on

set lazyredraw            " improve scrolling performance when navigating through large results
set ignorecase smartcase  " ignore case only when the pattern contains no capital letters

