
filetype off
filetype plugin indent off
runtime! ftplugin/man.vim

let g:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:vim_dir = g:cache_home . '/vim'
let g:python_host_prog = system('(type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(pyenv global | grep python2)/bin/python") || echo -n $(which python2)')
let g:python3_host_prog = system('(type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(pyenv global | grep python3)/bin/python") || echo -n $(which python3)')

" Set augroup.
augroup MyAutoCmd
  autocmd!
  " autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
        \ call vimrc#on_filetype()
  " autocmd CursorHold *.toml syntax sync minlines=300
  " autocmd BufWinLeave * mkview
  " autocmd BufWinEnter * silent loadview
  " autocmd QuickFixCmdPost vim* cwindow
augroup END
"augroup filetypedetect
"augroup END

function! Source_rc(path, ...) abort
  let use_global = get(a:000, 0, !has('vim_starting'))
  let abspath = resolve(expand('~/.dotfiles/vim/' . a:path))
  if !use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let content = map(readfile(abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  " create tempfile and source the tempfile
  let tempfile = tempname()
  try
    call writefile(content, tempfile)
    execute 'source' fnameescape(tempfile)
  finally
    if filereadable(tempfile)
      call delete(tempfile)
    endif
  endtry
endfunction

"============general setting===================
syntax on
set nocompatible
set fileencoding=utf-8
set encoding=utf-8
scriptencoding utf-8
set mouse=a
"==============auto file control setting=======
set nobackup          " do not create backupfile
set noswapfile        " do not create swapfile
set confirm           " ask if save unsaved files on quit
set autoread          " update unchanged buffer on external file change
set hidden            " enable buffer switching
set showcmd           " show command during input
set modeline          " use modeline
set modelines=5       " parse modeline to line 5
"=============view setting=====================
set title
set nonumber
set ruler
"set cursorline
"set cursorcolumn
set showmatch
set matchtime=1
set cmdheight=2
set list
"set listchars+=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:.
" TODO: use listchars when utf-8 is not supported
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
set scrolloff=4
"====spell setting==============================
set nospell
set spelllang=en
if (v:version == 704 && has("patch88")) || v:version >= 705
  set spelllang+=cjk
endif
"====fold setting==============================
set foldmethod=syntax
set foldcolumn=1
"set foldlevel=0
set foldlevel=100
"====search setting============================
set hlsearch
set incsearch
set ignorecase " ignore upper&lower case
set smartcase  " care only upper case with ignorecase
set wrapscan
"================================
set wildmode=list:longest
set wildchar=<Tab>
"================================
set clipboard&
set clipboard^=unnamedplus
" TODO: paste mode control
"================================
call Source_rc("map.vim")
call Source_rc("command.vim")
call Source_rc("edit.vim")
call Source_rc("dein.rc.vim")

" for importing ftplugins
set runtimepath+=~/.dotfiles/vim/

filetype on
filetype plugin indent on

