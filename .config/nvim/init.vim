"nvimrc
"
" Configuración básica
" vim:fdm=marker

" Leader
let mapleader = ";"

" Plugings {{{
" Vundle config
filetype off
set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/colorizer'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Plug 'SirVer/ultisnips', {'for': ['sh', 'python', 'markdown', 'c']}
" Plug 'honza/vim-snippets', {'for': ['sh', 'python', 'markdown', 'c']}
Plug 'ervandew/supertab'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'eslint/eslint'
Plug 'jxnblk/vim-mdx-js'
Plug 'tools-life/taskwiki'
call plug#end()

"filetype plugin indent on
" }}}

" Colores {{{
syntax on     " Activa coloreado de sintaxis.

" Esquema de color. Elegir uno
set background=dark

colorscheme tritium " Esquema de color

" Configuración de colores
if has('nvim')
  set termguicolors " True Color con NeoVim
else
  set t_Co 256 " 256 colores. No debería ser necesario usando una correcta configuración del terminal
endif
" }}}

" Tabulación y espacios {{{
set shiftwidth=2
set tabstop=2     " Espacios que mostramos por tabulador
set smarttab
set cindent
let indent_guides_enable_on_vim_startup = 1
autocmd Filetype html setlocal expandtab
autocmd Filetype javascript setlocal expandtab
autocmd Filetype typescript setlocal expandtab
autocmd Filetype typescriptreact setlocal expandtab
autocmd Filetype css setlocal expandtab
autocmd Filetype markdown setlocal expandtab
autocmd Filetype markdown setlocal spell spelllang=en_us,es
autocmd Filetype markdown.mdx setlocal spell spelllang=en_us,es
" }}}

" UI config {{{
set number          " Muestra número de lineas.
set cursorline      " Señala la linea actual.
set wildmenu        " Autocompletado para la barra de comandos.
set lazyredraw      " Redibuja pantalla solo cuando es estríctamente
set colorcolumn=80
set showmatch       " Señala [{()}]
set mouse=n         " Activa el ratón
"set ttymouse=xterm2 " Compatibilidad con la consola
set list listchars=eol:↵,tab:⇥\ ,trail:- " Muestralos tabuladores y saltos de linea.
set so=14     " Lineas movidas por scroll

" Folding (ocultado de bloques anidados)
set foldenable    " Activa folding
set foldlevelstart=10 " Dobla a partir de 10.
set foldnestmax=10  " Máximo de 10
set foldmethod=indent " Basado en identado
nnoremap <space> za

" }}}

" Edita vim config {{{
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

" Path de Python {{{
if has("unix")
  let s:uname = system("uname")
  let g:python_host_prog='/usr/bin/python3'
endif
" }}}

"Buffers {{{
nmap <Leader>n :bn<cr>
nmap <Leader>p :bp<cr>
" }}}

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Add your own mapping. For example:
noremap <silent> <C-E> :call ToggleNetrw()<CR>

" Configuración de plugins {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<c-space>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsListSnippets="<c-t>"

" Focus mode
function! GoyoBefore()
  Limelight
  set nocursorline
endfunction

function! GoyoAfter()
  Limelight!
  set cursorline
endfunction

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
let g:limelight_priority = -1

" vimwiki
let wiki_1 = {}
let wiki_1.path = '~/gestion/conocimiento/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}

" taskwiki
let g:taskwiki_disable_concealcursor = 'yes'

" indentLine
let g:indentLine_concealcursor = ''
let g:indentLine_conceallevel = 2

" air-line
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='tritium'
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : '',
      \ 'i'      : '',
      \ 'ic'     : '',
      \ 'ix'     : '',
      \ 'n'      : '',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'     : 'S',
      \ 't'      : 'T',
      \ 'v'      : '',
      \ 'V'      : '',
      \ }
" }}}
