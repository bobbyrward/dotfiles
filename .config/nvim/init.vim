if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    execute '!mkdir -p ~/.local/share/nvim/site/autoload/'
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'chriskempson/base16-vim'
Plug 'rust-lang/rust.vim'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'schickling/vim-bufonly'
Plug 'vimlab/split-term.vim'
" Plug 'ambv/black'
call plug#end()

set encoding=utf8

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


""""""""""""""""""""""""""""""
" => ale
""""""""""""""""""""""""""""""
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\       '*': [
\       ],
\       'python': [
\           'remove_trailing_lines',
\           'trim_whitespace',
\       ],
\   }

" \           'add_blank_lines_for_python_control_statements',
" \           'black',

let g:ale_linters = {
\       'python': [
\           'flake8',
\       ],
\   }

highlight ALEError ctermfg=00
highlight ALEError ctermbg=01

""""""""""""""""""""""""""""""
" => netrw
""""""""""""""""""""""""""""""
let g:netrw_banner = 0


""""""""""""""""""""""""""""""
" => AirLine
""""""""""""""""""""""""""""""
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""
" => VimWiki
""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

""""""""""""""""""""""""""""""
" => Remapped keys
""""""""""""""""""""""""""""""
let mapleader = "'"
let g:mapleader = "'"

nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>Q :qall<cr>
" nmap <leader>j :NERDTreeToggle<cr>
nmap <leader>e :e 

map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>
nmap <leader>ty :Tyank<cr>
nmap <leader>tp :Tput<cr>

" buffer shortcuts
nmap <leader>bd :bd<cr>
nmap <leader>` :bp<cr>
nmap <leader><tab> :bn<cr>

nmap <leader>n :next<cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cd :cd %:p:h<cr>

nmap <leader>ln :lN<cr>
nmap <leader>lp :lp<cr>

" split-term
nmap <leader>T :10Term<cr>

" fzf.vim
nmap <leader>f :Files<cr>
nmap <leader>B :Buffers<cr>
nmap <leader>g :GFiles<cr>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

function! NMapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
endfunction
command -nargs=+ NMapToggle call NMapToggle(<f-args>)

NMapToggle <leader>h hlsearch

try
  set switchbuf=usetab
  set stal=2
catch
endtry

cnoremap <C-P> <Up>

" Bash-like interface
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-N> <Down>

" Set 7 lines to the curors - when moving vertical..
set so=7

"Always show current position
set ruler

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set tabstop=4
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

"Wrap lines
set wrap


""""""""""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.pyc$', '\~$', '\.egg-info$', '__pycache__']


""""""""""""""""""""""""""""""
" => YAML
""""""""""""""""""""""""""""""
au FileType yaml set expandtab
au FileType yaml set cindent
au FileType yaml set ts=2
au FileType yaml set sw=2

""""""""""""""""""""""""""""""
" => Python
""""""""""""""""""""""""""""""
au FileType python set expandtab
au FileType python set cindent
au FileType python set formatoptions+=croq
au FileType python set cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au FileType python set textwidth=1024
au FileType python set colorcolumn=+1
" let g:syntastic_python_checkers = ['flake8']

""""""""""""""""""""""""""""""
" => vimwiki
""""""""""""""""""""""""""""""
au FileType vimwiki set expandtab

""""""""""""""""""""""""""""""
" => Rust
""""""""""""""""""""""""""""""
au FileType rust set expandtab
let g:rustfmt_autosave = 1

""""""""""""""""""""""""""""""
" => Ruby
""""""""""""""""""""""""""""""
au FileType ruby set noexpandtab
au FileType ruby set cindent
au FileType ruby set ts=2
au FileType ruby set sw=2
"au FileType ruby set formatoptions+=croq
"au FileType ruby set cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"au FileType ruby set textwidth=80
"au FileType ruby set colorcolumn=+1
