"""""""""
"
" Personal settings
"
""""""""

" Vim defaults
set nocompatible 

" Leader
let mapleader = ","

" Font
if has("unix")
	set guifont=DejaVuSansMono\ 9
else
    set guifont=Consolas:h9
endif

set encoding=utf-8

set mouse=a

set guioptions-=T

set showcmd
set noshowmode

set number relativenumber

:augroup numbertoggle
:   autocmd!
:   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:   autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
:augroup END

set lazyredraw

set wildmenu
set wildmode=longest,list
set wildignorecase
set wildignore+=*.a,*.o
set wildignore+=.git,.svn
set wildignore+=*~,*.swp,*.tmp

set laststatus=2        " Always on screen
set statusline=%f       " Name of the file
set statusline+=%=      " Align to the right 
set statusline+=%l,%c   " Current line number
set statusline+=\ /\    " Separator
set statusline+=%L      " Total lines number

set showmatch

set tabstop=4		    " width of a hard tabstop measured in "spaces" -- effectively the (maximum) width of an actual tab character
set shiftwidth=4	    " the size of an "indent"
set expandtab		    " make the tab key (in insert mode) insert spaces instead of tab characters
set smarttab		    " make the tab key (in insert mode) insert spaces/tabs to go to the next indent/tabstop when the cursor is at the beginning of a line

set nrformats-=octal
set isfname-=,
set isfname+={,}

" Highlight all characters past xx columns 
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=DarkOrange
"   autocmd BufEnter * match OverLength /\%81v.*/
" augroup END

set autoindent
set smartindent
set copyindent
set preserveindent

" Backspace over everything
set backspace=indent,eol,start

set smartcase
set ignorecase
set incsearch

set diffopt+=iwhite

set linebreak
if has ('multi_byte_encoding')
  set showbreak=…
else
  set showbreak=...
endif
if exists('+breakindent')
  set breakindent
endif

" Define meta-characters to show in place of characters that are otherwise
" invisible, or line wrapping attributes when the 'list' option is enabled.
"
" These 'list' characters all correspond to invisible or indistinguishable
" characters.  We leave the default eol:$ in place to show newlines, and add
" a few more.

set listchars+=tab:>-   " Tab characters, preserve width with hyphens
set listchars+=trail:-  " Trailing spaces
set listchars+=nbsp:+   " Non-breaking spaces   

set virtualedit=all

hi ExtraWhitespace ctermbg=darkred
match ExtraWhitespace /\s\+$\|\t/

set splitright
set splitbelow

set tabpagemax=100

set switchbuf=usetab

set scrolloff=1
set sidescrolloff=5

set hidden

set autoread
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

set undofile

set ttyfast

set autochdir

set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo
set tags=./tags;

""""""""
"
" GUI settings
"
""""""""

if &t_Co > 2 || has('gui_running')
	syntax on
	set background=dark
	set hlsearch
	if v:version >= 800
	    try
	        let g:gruvbox_contrast_dark='hard'
	        colorscheme gruvbox
	    catch
	        colorscheme desert
	    endtry
	else
	    colorscheme desert
	endif
endif

""""""""
"
" Remmapings
" Personal mappings
"
""""""""

" Option global by default 
set gdefault

" Quicker escaping
inoremap jj <ESC>

" Provide a shortcut to remove highlighting after a search
nnoremap <leader><space> :noh<cr>

" TAB = % (equivalent (, {, [) in normal and visual modes
nnoremap <tab> %
vnoremap <tab> %
" As <C-i> is the same as <Tab>, remap the original function (go forward in cursor position history)
nnoremap <C-q> <C-i>

" Movement by screen line instead of file line (default behaviour if count
" given to handle swaps)
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

" Simpler mapping for navigation between splits
nnoremap <C-h> <C-W><C-H>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>

" Swap 0 and ^ features, as ^ is most used but 0 is easier to reach

nnoremap 0 ^
nnoremap ^ 0
vnoremap 0 ^
vnoremap ^ 0

" Quicker access to command mode, not losing character search repetition feature
nnoremap ; :
vnoremap ; :
nnoremap é ;
vnoremap é ;

" Quicker access to marks
nnoremap à `

" Quicker access to backtick
inoremap à `

" Quicker access to /
nnoremap è /
vnoremap è /
inoremap è /

" Delete without clobbering unnamed register
nnoremap s "_d
nnoremap ss "_dd
nnoremap S "_D

" Make Y beahves the same way as C and D (from the cursor to EOL)
nnoremap Y y$

" Repeat q macro
nnoremap Q @q

" Easier access to completion commands

inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>

""""""""

" Quicker use of system clipboards    
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>Y "+y
vnoremap <leader>Y "+y
nnoremap <leader>P "+p

" Simpler access to tags
nnoremap <leader>l <C-]>
nnoremap <leader>k <C-t>
nnoremap <leader>L <C-w><C-]><C-w>L
nnoremap <leader>T <C-w><C-]><C-w>T

" Simpler access to includes
nnoremap <leader>a <C-w><C-f><C-w>L   

" Simpler access to diffs 
if &diff
  nnoremap <leader>e [c
  nnoremap <leader>r ]c
endif

" Select merge source (THEIRS / MINE)
if &diff
	nnoremap <silent> <leader>q :diffget 1<CR> :diffupdate<CR>
	nnoremap <silent> <leader>w :diffget 2<CR> :diffupdate<CR>
	nnoremap <silent> <leader>a :diffget 3<CR> :diffupdate<CR>
endif

" Substitute word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/

" Quicker way to switch between buffers
nnoremap <leader>j :bp<cr>
nnoremap <leader>i :bn<cr>

" Easy navigation inside quickfix list
if (!&diff)
	nmap <leader>e :cprev<CR>zz
	nmap <leader>r :cnext<CR>zz
endif

" Set working directory to match the location of the current file
nnoremap <leader>c :cd %:p:h<CR>

" Close a buffer without closing it's window (there must be at least one other buffer remaining)
nnoremap <leader>d :b#<bar>bd#<CR>

" Runs the whole buffer through =, preserving position
nnoremap <Leader>= :norm 1G=G<CR>

" Types :vimgrep ready to enter a search pattern, case insensitive / Execute :vimgrep on current word
" Automatically open QuickFix window when list is populated
nnoremap <leader>G :noautocmd vimgrep /\c/j ** <bar> cw<S-Left><S-Left><S-Left><S-Left><Right>
nnoremap <leader>H :noautocmd execute "vimgrep /".expand("<cword>")."/j **" <bar> cw<CR>

" Sessions management
let g:sessions_dir = '~/.vim/sessions'
exec 'nnoremap <leader>S :mks! '.g:sessions_dir.'/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <leader>R :so '.g:sessions_dir.'/*.vim<C-D><BS><BS><BS><BS><BS>'

" Edit vimrc in a new tab from anywhere, then source it
nnoremap <leader>vi :tabe $MYVIMRC<cr>
autocmd bufwritepost .vimrc source $MYVIMRC

""""""""
"
" Plugins config
"
""""""""

" Filetype plugin
filetype plugin indent on

autocmd FileType * unlet! b:browsefilter " Remove file type filtering in Edit File dialog

" Rainbow parentheses
map <F6> :RainbowParenthesesToggle<CR>
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons
" au VimEnter * RainbowParenthesesToggle

" Indentline
let g:indentLine_setColors = 0

" Matchit (% to jump between opening / closing keywords as for parentheses)
runtime macros/matchit.vim

" NERD Commenter
let g:NERDSpaceDelims = 1 " Adding space after comment delimiters
let g:NERDCommentEmptyLines= 1

" NERD Tree
map <leader>m :NERDTreeMirrorToggle<CR>
map <F8> :NERDTreeTabsClose<CR>
let g:NERDTreeWinSize = 50
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:nerdtree_tabs_open_on_gui_startup = 2

" Vim-Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#grepper#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#mixed_indent_algo = 1 " Spaces allowed after tabs but not in between

" CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_brief_prompt = 1
let g:ctrlp_working_path_mode = 'ra'

" EasyMotion
if (!&diff)
  map <leader>w <Plug>(easymotion-bd-w)
  map <leader>f <Plug>(easymotion-bd-f)
  map <leader>n <Plug>(easymotion-bd-n)
  
  map <leader>W <Plug>(easymotion-overwin-w)
  map <leader>F <Plug>(easymotion-overwin-f)
endif

" DelimitMate
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1

" Tagbar (requires Universal Ctags)
map <leader>. :TagbarToggle<CR>

" Undotree
map <F7> :UndotreeToggle<CR>

" UltiSnips
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
 
" AsyncRun
let g:asyncrun_open = 1

" QuickScope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight link QuickScopePrimary Identifier
    autocmd ColorScheme * highlight link QuickScopeSecondary Underlined   
augroup END

" Grepper
nnoremap <leader>g :Grepper -tool rg -grepprg rg --smart-case --with-filename --no-heading -g "!tags" --vimgrep<CR>
nnoremap <leader>h :Grepper -tool rg -cword -noprompt -grepprg rg --smart-case --with-filename --no-heading -g "!tags" --vimgrep<CR>

let g:grepper = {}                  " initialize g:grepper with empty dictionary
runtime plugin/grepper.vim          " initialize g:grepper with default values

let g:grepper.prompt_text = '$t> '

" Bufexplorer
let g:bufExplorerFindActive = 0

" Vim-polyglot
let g:polyglot_disabled = ['csv']

""""
"
" Plugins list
"
""""

" In .vim/pack/my_plugins/start

" asyncrun.vim
" bufexplorer
" ctrlp.vim
" delimitmate
" goyo.vim
" gruvbox
" gv.vim
" indentline
" limelight.vim
" nerdcommenter
" nerdtree
" quick-scope
" rainbow_csv
" rainbow_parentheses.vim
" tagbar
" ultisnips
" undotree
" vim-abolish
" vim-airline
" vim-devicons
" vim-easymotion
" vim-fugitive
" vim-grepper
" vim-magnum
" vim-multiple-cursors
" vim-nerdtree-tabs
" vim-polyglot
" vim-radical
" vim-repeat
" vim-signify
" vim-snippets
" vim-startify
" vim-surround
" youcompleteme

" Plus install NerdFont from : https://www.nerdfonts.com/
" Putting it in /usr/share/fonts/truetype/dejavu, then updating font information cache via fc-cache -f -v
