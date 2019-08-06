" vim:set nospell:
filetype off
filetype plugin indent off
runtime! ftplugin/man.vim

"============file setting======================

set fileencoding=utf-8 
set encoding=utf-8
scriptencoding utf-8
set nocompatible
set nobackup 
set noswapfile 
set autoread 
set hidden 
set showcmd 
set backspace=indent,eol,start
set modeline
set modelines=5

"=============key mapping======================= 
set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][%3l,%3c,%3p]

nnoremap s <Nop>

"move among panes 
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sr <C-w>w

" move the pane position
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sR <C-w>r

" pane size changer
nnoremap s= <C-w>=
nnoremap s_ <C-w>_
nnoremap s\|  <C-w>\|
nnoremap sa <C-w>_<C-w>\|

" split the pane
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>

" tab handling
nnoremap st :<C-u>tabnew<CR>
nnoremap sT <C-w>T "move pane to new tab
nnoremap sn gt
nnoremap sp gT

nnoremap tn :<C-u>tabnew<CR>
nnoremap tl gt
nnoremap th gT

" exchange line movement commands
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" multi line paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" swap ; and :
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

inoremap jk <ESC>

" discard yank got with x(s)
nnoremap x "_x
nnoremap s "_s

" delete highlight with double <ESC> or Ctrl-l
nnoremap <silent> <ESC><ESC> :nohl<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" highlight the word under cursor with double space
nnoremap <silent> HH  "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>


"emacs keybinds for command 
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-b> <Esc>bi
inoremap <C-f> <Esc>ewi
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>

"line join 
nnoremap J <Nop>
nnoremap <C-j> :join<CR>
nnoremap <space>h :Gtags -f %<CR>
nnoremap <space>j :GtagsCursor<CR>
nnoremap <space>d :<C-u>exe('Gtags '.expand('<cword>'))<CR>
nnoremap <space>r :<C-u>exe('Gtags -r '.expand('<cword>'))<CR>
nnoremap <space>n :cn<CR>
nnoremap <space>p :cp<CR>
nnoremap <space>o <C-o>

" vim as terminal multiplexer
if has('terminal') || has('nvim')

  tnoremap <silent> <ESC> <C-\><C-n>
  tnoremap jj <C-\><C-n>
  tnoremap jk <C-\><C-n>

  if has('nvim')
    autocmd TermOpen * setlocal nonumber
    autocmd TermOpen * setlocal nospell
    autocmd TermOpen * startinsert
  else
    autocmd TerminalOpen * set nonumber
    autocmd TerminalOpen * set nospell
  endif
endif

"=============edit setting=====================
set tabstop=2
set expandtab
set smartindent
set shiftwidth=2
set autoindent

"=============view setting=====================
syntax on
colorscheme iceberg

set title
set number
set ruler
"set cursorline
"set cursorcolumn
set virtualedit=block
set showmatch
set matchtime=1
set cmdheight=2
set wildmode=list:longest
set wildchar=<Tab>
set spell
set spelllang=en
if (v:version == 704 && has("patch88")) || v:version >= 705
      set spelllang+=cjk
endif
set list
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
set scrolloff=4

"====fold setting==============================

"set foldmethod=syntax

"====search setting============================
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set clipboard=unnamed,unnamedplus
set mouse=a

"=============utility==========================
"{{{
command! InsertModeLine call s:insertModeLine()

function! s:insertModeLine()
    put ='vim: set ft=' . &ft . ' :'
endfunction
"}}}

"==========dein.vim============================
if v:version >= 800 
    let s:cache_home = expand('~/.cache')
    let s:dein_dir = s:cache_home . '/dein'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    " automatically download dein.vim repo when it doesn't exist in local
    if !isdirectory(s:dein_repo_dir)
      call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif
    let &runtimepath = s:dein_repo_dir .",". &runtimepath

    call dein#begin(s:dein_dir)

    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})

    if has('nvim')
      call dein#add('Shougo/denite.nvim')
    else
      call dein#add('Shougo/unite.vim')
    endif
    call dein#add('Shougo/neomru.vim') "recently used file
    "call dein#add('Shougo/neocomplete.vim')
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    let g:deoplete#enable_at_startup = 1
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    call dein#add('thinca/vim-quickrun') 
    call dein#add('itchyny/lightline.vim')
    if has('nvim')
      call dein#add('mattn/benchvimrc-vim') "Use with :BenchVimrc
    endif
    call dein#add('scrooloose/nerdtree')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('lighttiger2505/gtags.vim')
    call dein#add('justmao945/vim-clang')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('itchyny/vim-parenmatch')

    call dein#end()



    "================neosnippet================================    
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target) 

    " SuperTab like snippets behavior.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    imap <expr><CR> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

    "================quickrun============================
    let g:quickrun_config = {}
    let g:quickrun_config.cpp = { 'command': 'g++','cmdopt': '-std=c++11'}
    "================NERDTree============================
    function s:MoveToFileAtStart()
      call feedkeys("\<Space>")
      call feedkeys("\s")
      call feedkeys("\l")
    endfunction
    let g:NERDTreeShowBookmarks=1
    
    if !argc()
      autocmd VimEnter *  NERDTree 
    endif

    "================vim-clang================================
    let g:clang_c_options = '-std=c90'
    let g:clang_format_auto = 0
    let g:clang_auto = 0
    let g:clang_format_stylea ='Google'
    let g:clang_check_syntax_auto = 0
    "================gtags.vim================================
    let g:Gtags_Auto_Map = 0
    let g:Gtags_OpenQuickfixWindow = 1
    nmap <silent> K :<C-u>exe("Gtags ".expand('<cword>'))<CR>
    nmap <silent> R :<C-u>exe("Gtags -r".expand('<cword>'))<CR>
    "================vim-parenmatch===========================
    let g:loaded_matchparen = 1
    highlight link ParenMatch MatchParen
    let g:parenmatch_highlight = 0
    "================lightline.vim============================

    set laststatus=2
    if !has('gui_running')
      set t_Co=256
    endif
    set noshowmode
    let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'mode_map': {'c': 'NORMAL'},
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'LightlineModified',
            \   'readonly': 'LightlineReadonly',
            \   'fugitive': 'LightlineFugitive',
            \   'filename': 'LightlineFilename',
            \   'fileformat': 'LightlineFileformat',
            \   'filetype': 'LightlineFiletype',
            \   'fileencoding': 'LightlineFileencoding',
            \   'mode': 'LightlineMode'
            \ }
            \ }

    function! LightlineModified()
      return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! LightlineReadonly()
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
    endfunction

    function! LightlineFilename()
      return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
            \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
            \  &ft == 'unite' ? unite#get_status_string() :
            \  &ft == 'vimshell' ? vimshell#get_status_string() :
            \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
            \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
    endfunction

    function! LightlineFugitive()
      if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
      else
        return ''
      endif
    endfunction

    function! LightlineFileformat()
      return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! LightlineFiletype()
      return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
    endfunction

    function! LightlineFileencoding()
      return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
    endfunction

    function! LightlineMode()
      return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction
endif



function! ProfileCursorMove() abort
  let profile_file = expand('~/log/vim-profile.log')
  if filereadable(profile_file)
    call delete(profile_file)
  endif

  normal! gg
  normal! zR

  execute 'profile start ' . profile_file
  profile func *
  profile file *

  augroup ProfileCursorMove
    autocmd!
    autocmd CursorHold <buffer> profile pause | q
  augroup END

  for i in range(100)
    call feedkeys('j')
  endfor
endfunction



filetype on
filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

