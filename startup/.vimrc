" General
set nocompatible        " remove vi compatibility
set encoding=utf-8      " set vim encoding
set scrolloff=3         " minimum lines to keep in view around cursor
set backspace=indent,eol,start  " backspace works in normal mode
set laststatus=2        " show file name in status bar

set path+=**            " search down into subfolders for files
set wildignore+=**/node_modules/**  " ignore folders
set wildignore+=**/env/**           " ignore folders
set wildignore+=**/data/**           " ignore folders
set wildmenu            " command-line completion
set wildmode=longest:list,full  " cycle between command line completions
set clipboard=unnamed   " use system clipboard by default
set nrformats+=bin      " allow C-A, C-X for binary

set ttimeoutlen=100     " set keycode timeout (defualt is too long -
                        " follows timeoutlen for mappings which is 1000ms)
                        " used for fedora machine with xmodmap and xcape

let mapleader = ','     " map leader key to ,

" Colors
syntax enable           " enable syntax processing
filetype plugin indent on      " run scripts based on type of file

" Formating
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set shiftwidth=4        " number of spaces in (auto)indent
set autoindent          " follow indentation of previous line
set shiftround          " always indent by multiple of shiftwidth
set nojoinspaces        " don't autoinsert two spaces after '.', '?', '!' for join command
set formatoptions+=j    " remove comment leader when joining comment lines
set formatoptions+=n    " smart auto-indenting inside numbered lists

" Folding
set foldenable          " enable folding
set foldlevelstart=1    " folds by default
set foldmethod=indent   " fold based on indent level

" UI Config
set relativenumber      " show relative line numbers
set number              " ... except for current line
set showcmd             " show command in bottom bar
set showmode            " show mode in bottom bar
set cursorline          " highlight current line
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set wrap                " wrap text
set breakindent         " indent wrapped lines to match start
set textwidth=80        " characters to wrap text at
set highlight+=@:ColorColumn    " ~/@ at end of window, 'showbreak'
set highlight+=N:DiffText       " make current line number stand out a little
set highlight+=c:LineNr         " blend vertical separators with line numbers
set list                " show whitespace
set listchars=tab:▷┅    " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                        " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505,
                        " UTF-8: E2 94 85)
set listchars+=trail:•  " BULLET (U+2022, UTF-8: E2 80 A2)

" Windows
set splitbelow          " open horizontal split below current window
set splitright          " open vertical split to the right of current window
set switchbuf=usetab    " try to reuse windows/tabs when switching buffers
set hidden              " allow switching modified buffers
set fillchars=vert:┃    " solid line to seperate windows
set fillchars+=stlnc:=  " fill inactive status lines with '='

" Searching
set ignorecase          " Ignore case when typing
set smartcase           " ... unless we type a capital
set incsearch           " Incremental searching
set hlsearch            " Highlight matches when searching

" Cursor indicates mode
let &t_SI = "\<esc>[5 q"    " I beam cursor for insert mode
let &t_EI = "\<esc>[2 q"    " block cursor for normal mode
let &t_SR = "\<esc>[3 q"    " underline cursor for replace mode

" Make ctags
command! MakeTags !ctags -R .

" tab open/closes folds
nnoremap <tab> za

" Y to yank to end of line
nnoremap Y y$

function! BreakHere()
	s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
	call histdel("/", -1)
endfunction

nnoremap <C-j> :<C-u>call BreakHere()<CR>

" Q to play macro
nnoremap Q @q

nnoremap <cr> :

" Remove distracting highlight after finding what we searched
nnoremap <leader>n :noh<cr>
" Turn off vim's custom regex
" nnoremap / /\v
" vnoremap / /\v

" Minimal git blame
command! -range GB echo join(systemlist("git blame -L <line1>,<line2> " .expand('%')), "\n")

" Move by visual line rather than physical line
nnoremap j gj
nnoremap k gk
" Move correctly when text is wrapped and using {count}j/k
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Command Mode
" Terminal-like experience for command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" `<Tab>`/`<S-Tab>` to move between matches without leaving incremental search.
" Note dependency on `'wildcharm'` being set to `<C-z>` in order for this to
" work.
set wildcharm=<C-z>

cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'

inoremap ;pdb import pdb; pdb.set_trace()<ESC>

" Save temporary/backup files not in the local directory, but in your ~/.vim
" directory, to keep them out of git repos.
" But first mkdir backup, swap, view and undo first to make this work
call system('mkdir ~/.vim')
call system('mkdir ~/.vim/backup')
call system('mkdir ~/.vim/swap')
call system('mkdir ~/.vim/view')
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set viewdir=~/.vim/view//
set viewoptions=cursor,folds

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    call system('mkdir ~/.vim/undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'bronson/vim-visual-star-search'
Plug 'wincent/loupe'
Plug 'wincent/scalpel'
Plug 'wincent/pinnacle'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/indentpython.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'justinmk/vim-sneak'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" Scalpel
nmap c* <Plug>(Scalpel)
vnoremap c* "hy:%s/<C-r>h//gc<left><left><left>

" GitGutter
set updatetime=100  " refresh rate
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
" make mappings more mnemonic (chunk)
nmap <Leader>cs <Plug>GitGutterStageHunk
nmap <Leader>cu <Plug>GitGutterUndoHunk
nmap <Leader>cp <Plug>GitGutterPreviewHunk

" File Beagle
let g:filebeagle_suppress_keymaps = 1
map <silent> -          <Plug>FileBeagleOpenCurrentBufferDir

autocmd! bufwritepost .vimrc source %

" FZF
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_command_prefix = 'Fzf'
nmap <leader><tab> <plug>(fzf-maps-n)
nmap <leader>f :FzfFiles<CR>
nmap <leader>a :FzfRg<CR>
nmap gb :FzfBuffers<CR>
nmap <leader>g :FzfCommits<CR>
nmap <leader>G :FzfBCommits<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
