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

"Config Section
" configure airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers

" Editor Config
" Set the leader key to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" enable smooth scrolling
let g:smoothie_enabled = 1

" default nerdtree to showing hidded files
let NERDTreeShowHidden=1

" toggle word wrap
map <leader>w :set wrap!<CR>

" Easymotion fuzzy search
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" Copy to system clipboard
map <leader>c "*y

" Paste from system clipboard
map <leader>p "*[p

" clear out search
map <leader>h :let @/ = ""<CR>

" flatten list into comma seperated
map <leader>l :%s/\n/,/g<CR>

" select all text
map <leader>a ggVG<CR>

" get help with which key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" NERD Tree Setup
" set the [ character to toggle nerdtree
map <leader>n :NERDTreeToggle<CR>

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
