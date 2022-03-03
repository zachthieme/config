" remap jj to escape in insert mode.  
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" get the relative number and regular number set for different context
set number relativenumber
set nowrap

" set the tab width - both numbers need to be the same
set shiftwidth=2
set tabstop=2
set autoindent
" remove highlighting from searches
set nohlsearch
set nowrap
set scrolloff=8
set incsearch
set modeline

call plug#begin("~/.vim/plugged")
" Plugin Section
	Plug 'prabirshrestha/vim-lsp'
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
	Plug 'flazz/vim-colorschemes'
	Plug 'easymotion/vim-easymotion'
	Plug 'haya14busa/incsearch.vim'
	Plug 'haya14busa/incsearch-easymotion.vim'
call plug#end()

"Config Section
" configure airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers

" Editor Config
" Set the leader key to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" default nerdtree to showing hidded files
let NERDTreeShowHidden=1
" toggle word wrap
map <leader>w :set wrap!<CR>

" Easymotion fuzzy search
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" incsearch.vim x fuzzy x vim-easymotion

" 
" function! s:config_easyfuzzymotion(...) abort
"return extend(copy({
"  \   'converters': [incsearch#config#fuzzy#converter()],
"  \   'modules': [incsearch#config#easymotion#module()],
"  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
"  \   'is_expr': 0,
"  \   'is_stay': 1
"  \ }), get(a:, 1, {}))
"endfunction
"
"noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

"FZF customizations
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
" Copy to system clipboard
map <leader>c "*y
" Paste from system clipboard
map <leader>p "*[p
" clear out search
map <leader>h :let @/ = ""<CR>
" flatten list into comma seperated
map <leader>l :%s/\n/,/g<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" select all text
map <leader>a ggVG<CR>

" get help with which key
" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" NERD Tree Setup
" set the [ character to toggle nerdtree
map <leader>n :NERDTreeToggle<CR>

" autogenerate help files
autocmd BufWritePost ~/.config/nvim/doc/* :helptags ~/.config/nvim/doc
  
" Set nerdtree to default to the folder enclosing the file
autocmd BufEnter * lcd %:p:h

" turn on cursor line when in insert mode
autocmd InsertEnter,InsertLeave * set cul!
hi CursorLine   cterm=NONE ctermbg=59 ctermfg=white

if has("gui_vimr")
  " Here goes some VimR specific settings like
	colorscheme monokai 
  highlight Normal guibg=black guifg=white
  set background=light

endif
