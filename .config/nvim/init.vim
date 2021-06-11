" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

set autoindent
call plug#begin("~/.vim/plugged")
" Plugin Section
	Plug 'tpope/vim-surround'
	Plug 'jiangmiao/auto-pairs'
	Plug 'Thyrum/vim-stabs'
	Plug 'airblade/vim-rooter'
	Plug 'christoomey/vim-tmux-navigator' 
	Plug 'jeffkreeftmeijer/vim-numbertoggle'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'liuchengxu/vim-which-key'
	Plug 'psliwka/vim-smoothie'
	Plug 'scrooloose/nerdtree'
	Plug 'vim-airline/vim-airline'
  Plug 'godlygeek/tabular'
  Plug 'trotter/autojump.vim'
call plug#end()

"Config Section
" configure airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers

" Editor Config
" Set the leader key to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" get the relative number and regular number set for different context
:set number relativenumber
:set nowrap
" :set spell

" turn on cursor line when in insert mode
:autocmd InsertEnter,InsertLeave * set cul!
:hi CursorLine   cterm=NONE ctermbg=59 ctermfg=white

" set the tab width
:set shiftwidth=2
:set tabstop=2

"FZF customizations
:map <leader>f :Files<CR>
:map <leader>b :Buffers<CR>
" Copy to system clipboard
:map <leader>c "*y
" Paste from system clipboard
:map <leader>p "*[p
" clear out search
:map <leader>h :let @/ = ""<CR>
" flatten list into comma seperated
:map <leader>l :%s/\n/,/g<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"NERD Tree Setup

" set the [ character to toggle nerdtree
:map <leader>n :NERDTreeToggle<CR>

" Set nerdtree to default to the folder enclosing the file
autocmd BufEnter * lcd %:p:h

" default nerdtree to showing hidded files
let NERDTreeShowHidden=1

