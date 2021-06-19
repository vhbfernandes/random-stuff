if has('filetype')
  filetype indent plugin on
endif
if has('syntax')
  syntax on
endif
if has('mouse')
  set mouse=a
endif

"------ sets
set ignorecase
set wildmenu
set showcmd
set hlsearch

set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set number
set notimeout ttimeout ttimeoutlen=200
set colorcolumn=125
"---- identacao
set shiftwidth=2
set softtabstop=2
set expandtab

"---- remaps
nnoremap B ^
nnoremap E $