" Show line numbers
set number

" Show cursor position (bottom right)
set ruler

" Spaces not tabs
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" Unindent with shift-tab
inoremap <S-Tab> <C-D>

" When pressing left arrow at the beginning of a line, go to end of prev line
set whichwrap+=<,>,h,l,[,]

" Makes backspace work as in other programs (needed on Mac)
set backspace=indent,eol,start

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Use system clipboard (on Ubuntu, I needed to install vim-gtk for this to work)
" unnamedplus seems to be the correct setting on Ubuntu
" set clipboard=unnamedplus
set clipboard=unnamed

" shift-tab unindent for command mode
nnoremap <S-Tab> <<
" shift-tab unindent for insert mode
inoremap <S-Tab> <C-d>

" Jump to search results automatically
set incsearch
" Highlight search results
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

""""""""""""""""""" vim-plug section
call plug#begin('~/.vim/plugged')
Plug 'rhysd/vim-clang-format'
call plug#end()

""""""""""""""""""" clang-format

let g:clang_format#style_options = {
            \ "ColumnLimit" : 90,
            \ "AllowShortLoopsOnASingleLine" : "false"}

nmap <Leader>C :ClangFormatAutoToggle<CR>

color monokai

" Show completion options in things such as :e
set wildmenu
