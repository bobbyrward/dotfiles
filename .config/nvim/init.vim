if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    execute '!mkdir -p ~/.local/share/nvim/site/autoload/'
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

let g:python3_host_prog = '/usr/bin/python3'

call plug#begin('~/.local/share/nvim/plugged')

Plug 'ryanoasis/vim-devicons'
Plug 'liuchengxu/vista.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'arcticicestudio/nord-vim', {'branch': 'main'}

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'rust-lang/rust.vim'

Plug 'schickling/vim-bufonly'
Plug 'vimlab/split-term.vim'
Plug 'leafgarland/typescript-vim'
Plug 'towolf/vim-helm'

Plug 'lervag/wiki.vim'

Plug 'nvim-lua/plenary.nvim'
" Plug 'ckipp01/nvim-jenkinsfile-linter'


call plug#end()

set hidden
set encoding=utf8

colorscheme nord
let g:nord_cursor_line_number_background = 1

" let $FZF_DEFAULT_COMMAND = 'rg --files --no-hidden'
" let $FZF_DEFAULT_COMMAND='fd --type f'
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

let mapleader = "'"
let g:mapleader = "'"

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes


" Vista
"
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1

let g:vista_fzf_preview = ['right:50%']



" COC
"
let g:coc_global_extensions = [
  \'coc-json',
  \'coc-yaml',
  \'coc-tsserver',
  \'coc-rust-analyzer',
  \'coc-pyright',
  \'coc-marketplace',
  \'coc-go',
  \]


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


nmap <leader>n <Plug>(coc-diagnostic-next)
nmap <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
autocmd CursorHold * silent call CocActionAsync('highlight')

" hi CocHintSign ctermfg=8

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)


" Using CocList
" Show all diagnostics
nnoremap <leader>da  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <leader>de  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <leader>dc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <leader>do  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <leader>ds  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <leader>dj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <leader>dk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <leader>dp  :<C-u>CocListResume<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocActionAsync('format')
"
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


""""""""""""""""""""""""""""""
" => netrw
""""""""""""""""""""""""""""""
let g:netrw_banner = 0


""""""""""""""""""""""""""""""
" => AirLine
""""""""""""""""""""""""""""""
" let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""
" => wiki.vim
""""""""""""""""""""""""""""""
let g:wiki_root = "~/Documents/notes"
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
nmap <leader>wg <Plug>(wiki-fzf-pages)

""""""""""""""""""""""""""""""
" => Remapped keys
""""""""""""""""""""""""""""""
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
nmap <leader>bo :BufOnly<cr>

nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cc :cclose<cr>
nmap <leader>cd :cd %:p:h<cr>

nmap <leader>ln :lN<cr>
nmap <leader>lp :lp<cr>

" split-term
nmap <leader>T :10Term<cr>

" fzf.vim
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction


let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }


" Files + devicons + floating fzf
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --line-range :'.&lines.' --theme="OneHalfDark" --style=numbers,changes --color always {2..-1}"'
  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call CreateCenteredFloatingWindow()'})

endfunction




" nmap <leader>f :Files<cr>
nmap <silent> <leader>f :call Fzf_dev()<CR>
nmap <leader>B :Buffers<cr>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
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
set nu rnu

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

" Save when calling :make
set autowrite

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

""""""""""""""""""""""""""""""
" => vimwiki
""""""""""""""""""""""""""""""
au FileType vimwiki set expandtab

""""""""""""""""""""""""""""""
" => Rust
""""""""""""""""""""""""""""""
au FileType rust set expandtab

""""""""""""""""""""""""""""""
" => json
""""""""""""""""""""""""""""""
au FileType json set expandtab
au FileType json set ts=2
au FileType json set sw=2

""""""""""""""""""""""""""""""
" => TypeScript
""""""""""""""""""""""""""""""
au FileType javascript set expandtab
au FileType javascript set ts=2
au FileType javascript set sw=2

au FileType typescript set expandtab
au FileType typescript set ts=2
au FileType typescript set sw=2

""""""""""""""""""""""""""""""
" => Go
""""""""""""""""""""""""""""""
au FileType go set noexpandtab
au FileType go set ts=4
au FileType go set sw=4
au FileType go set nolist

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" let g:go_auto_sameids = 1

let g:go_fmt_command = "goimports"

nmap <leader>gb :GoBuild<cr>
nmap <leader>gt :GoTest<cr>

""""""""""""""""""""""""""""""
" => Make
""""""""""""""""""""""""""""""
au FileType make set noexpandtab
au FileType make set ts=4
au FileType make set sw=4
au FileType make set nolist

""""""""""""""""""""""""""""""
" => Ruby
""""""""""""""""""""""""""""""
au FileType ruby set noexpandtab
au FileType ruby set cindent
au FileType ruby set ts=2
au FileType ruby set sw=2

""""""""""""""""""""""""""""""
" => terraform
""""""""""""""""""""""""""""""
au FileType tf set expandtab
au FileType tf set ts=2
au FileType tf set sw=2

""""""""""""""""""""""""""""""
" => markdown
""""""""""""""""""""""""""""""
au Filetype markdown set expandtab
au Filetype markdown set ts=2
au Filetype markdown set sw=2

""""""""""""""""""""""""""""""
" => groovy
""""""""""""""""""""""""""""""
au FileType groovy set expandtab
au FileType groovy set ts=2
au FileType groovy set sw=2

autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy
autocmd BufRead,BufNewFile Jenkinsfile* setf groovy
