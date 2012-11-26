set nocompatible

call pathogen#infect()

colorscheme wombat256
set guifont=Consolas:h10:cANSI


syntax enable

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"Bundle 'gmarik/vundle'


" NERDTree
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'tpope/vim-surround'

filetype plugin on
filetype indent on

set autoread
set shell=/bin/bash
set encoding=utf8
set ffs=unix,dos,mac
set mouse=a

let mapleader = "'"
let g:mapleader = "'"

nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>Q :qall<cr>
nmap <leader>j :NERDTreeToggle<cr>
nmap <leader>e :e 

nmap <leader>V :split<cr>
nmap <leader>v :vsplit<cr>

" Quick change file format
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

" buffer shortcuts
nmap <leader>bd :bd<cr>
nmap <leader>bn :bn<cr>
nmap <leader>bp :bp<cr>

"Tab configuration
nmap <leader>tn :tabnew %<cr>
nmap <leader>te :tabedit 
nmap <leader>tc :tabclose<cr>
nmap <leader>tm :tabmove 
nmap <leader>` :tabprev<cr>
nmap <leader><tab> :tabnext<cr>

nmap <leader>ts :ConqueTermTab 
nmap <leader>s :ConqueTerm 

nnoremap <leader>T :CommandT<cr>

nmap <leader>n :next<cr>
nmap <leader>cd :cd %:p:h<cr>

try
  set switchbuf=usetab
  set stal=2
catch
endtry

iab xts brw<c-r>=strftime("%m%d%y")<cr>
iab xdate <c-r>=strftime("%Y-%m-%d")<cr>
iab xemail bobbyrward@gmail.com
iab xname Bobby R. Ward
iab xbrw #XXX: BRW

" Bash-like interface
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

cmap W! w !sudo tee % >/dev/null

nnoremap Y y$

" toggle between number and relative number on ,l
nnoremap <leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction

let g:netrw_list_hide='^\.,.\(pyc\|pyo\|o\)$'

" Colorcolumns
"if version >= 730
  "autocmd FileType * setlocal colorcolumn=0
  "autocmd FileType ruby,python,javascript,c,cpp,objc setlocal colorcolumn=79
"endif

" Set 7 lines to the curors - when moving vertical..
set so=7

" Enhanced completion
set wildmenu
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class
set wildmode=list:full

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=3

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

" Highlight trailing whitespace and tabs
set listchars=tab:≫-,trail:→
set list

""""""""""""""""""""""""""""""
" => Conque
""""""""""""""""""""""""""""""
let g:ConqueTerm_PyVersion = 2
let g:ConqueTerm_Color = 0
let g:ConqueTerm_FastMode = 0
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_Syntax = 'python'
let g:ConqueTerm_TERM = 'vt100'


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2

function! CurDir()
let curdir = substitute(getcwd(), '/home/null/', "~/", "g")
return curdir
endfunction

"Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

""""""""""""""""""""""""""""""
" => Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

set completeopt=menu

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofen
set fdl=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set tabstop=4

map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>

set smarttab
set lbr
set tw=500

""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai

"Smart indet
set si
inoremap # #


"C-style indeting
"set cindent

"Wrap lines
set wrap


""""""""""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.pyc$', '\~$', '\.egg-info$']


""""""""""""""""""""""""""""""
" => Python
""""""""""""""""""""""""""""""
au FileType python set expandtab
au FileType python set cindent
au FileType python set formatoptions+=croq
au FileType python set cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au FileType python set textwidth=80
au FileType python set colorcolumn=+1



""""""""""""""""""""""""""""""
" => Ruby
""""""""""""""""""""""""""""""
au FileType ruby set expandtab
au FileType ruby set cindent
"au FileType ruby set formatoptions+=croq
" au FileType ruby set cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"au FileType ruby set textwidth=80
"au FileType ruby set colorcolumn=+1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " Append the number of windows in the tab page if more than one
  let wincount = tabpagewinnr(v:lnum, '$')
  if wincount > 1
    let label .= wincount
  endif
  if label != ''
    let label .= ' '
  endif

  " Append the buffer name
  let bufId = bufnrlist[tabpagewinnr(v:lnum) - 1]
  let fn = bufname(bufId)
  let lastSlash = strridx(fn, '/')
  return label . strpart(fn, lastSlash+1, strlen(fn))
endfunction

set guitablabel=%{GuiTabLabel()}


function! NMapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
endfunction
command -nargs=+ NMapToggle call NMapToggle(<f-args>)

NMapToggle <leader>h hlsearch 
