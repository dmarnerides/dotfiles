" For vim-polyglot we need to define the disabled ones before loading
let g:polyglot_disabled = ['latex'] " Required by vimtex


" Automatically get vim plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""" Plugins
" Setup vim-plug
" Install plugins in a different plugin
call plug#begin('~/.config/nvim-plugged')

" Airline and theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim' " Airline for tmux

" NERDTree
" Plug 'scrooloose/nerdtree' " Install NERDTree
" Plug 'jistr/vim-nerdtree-tabs' " Use NERDTree in tabs

" Syntax Checking
Plug 'w0rp/ale' " Asynchronous linting
" Plug 'shougo/denite.nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

" Shippets
" Plug 'sirver/ultisnips' " Engine
" Plug 'honza/vim-snippets' " Snippets!

" Code completion
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' } " Very heavy
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

" Indentation
" Plug 'thaerkh/vim-indentguides' " display indentation guides
" Plug 'sickill/vim-pasta' " Better indentation
" Plug 'hynek/vim-python-pep8-indent' " Python specific indentation
Plug 'Yggdroot/indentLine'

" Tags
Plug 'ludovicchabant/vim-gutentags'
" Plug 'majutsushi/tagbar'
" Plug 'liuchengxu/vista.vim'

" Commenting
Plug 'preservim/nerdcommenter'


" Fuzzy file, buffer, mru, tag finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " This is needed for :Ag

" " Git
Plug 'tpope/vim-fugitive' " Git commands from inside vim
" Plug 'tpope/vim-rhubarb' " GitHub integration
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify' " Show git diff on the side (faster than gitgutter)

" Latex
Plug 'https://github.com/lervag/vimtex.git'

" C++ highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Pandoc
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

" CSV Files
Plug 'chrisbra/csv.vim'

" Session saving
Plug 'thaerkh/vim-workspace'

" Text objects
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich' " Using sandwich instead of surround
Plug 'michaeljsmith/vim-indent-object' " Text objects for indentation levels

" Misc
Plug 'tmux-plugins/vim-tmux-focus-events' " makes autoread work properly for terminal vim
Plug 'christoomey/vim-tmux-navigator' " Easy navigation for tmux and vim
Plug 'yuttie/comfortable-motion.vim' " Smooth scrolling
Plug 'rbgrouleff/bclose.vim' " Don't close windows that also display buffer when using bdel
Plug 'tmhedberg/matchit' " Enhance % button functionality
Plug 'brooth/far.vim' " Search and replace!
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'tpope/vim-eunuch'
" Plug 'liuchengxu/vim-clap' " clap!
Plug 'nelstrom/vim-visual-star-search' " search current selection with * and #
" Plug 'rhysd/clever-f.vim' "  makes f, F, t and T movements more informative and convenient.
" HARD MODE!!
Plug 'takac/vim-hardtime'

" To show colours
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()



