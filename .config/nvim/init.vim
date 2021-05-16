call plug#begin("~/.vim/plugged")
  " Plugin Section
  Plug 'scrooloose/nerdtree'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'vim-airline/vim-airline'
  Plug 'psliwka/vim-smoothie'
  Plug 'liuchengxu/vim-which-key'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
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

"FZF customizations
:map <leader>f :Files<CR>
:map <leader>b :Buffers<CR>


"NERD Tree Setup

" set the [ character to toggle nerdtree
:map <leader>n :NERDTreeToggle<CR>

" Set nerdtree to default to the folder enclosing the file
autocmd BufEnter * lcd %:p:h

" default nerdtree to showing hidded files
let NERDTreeShowHidden=1

