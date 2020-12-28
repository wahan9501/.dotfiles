"================================ General ================================
filetype indent plugin on           " turn on filtype detection, indent, plugin
syntax on

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disables automatic commenting on newline:

set clipboard+=unnamed                                  " Add system clipboard to vim
set splitbelow                                          " Split horizontal window to below
set splitright                                          " Split vertical window to right
set backspace=indent,eol,start                          " or set backspace=2, make backspace work like most other programs
set ruler                                               " line number, column number, relative position at right bottom
set hls                                                 " highlight search results
set tabstop=4                                           " tab width=4
set shiftwidth=4                                        " shift width-4
set expandtab                                           " On pressing tab, expand to space
set showmatch                                           " show match brackets
set cinoptions=g-1                                      " cindent style
set foldmethod=syntax
set foldlevel=99                                        " set fold level to not fold at first
set cursorline                                          " highlight current line
hi CursorLine cterm=NONE ctermbg=DarkGray               " cursor styles
set laststatus=2                                        " always display status line
set scrolloff=0                                         " force no line above and below cursor when scrolling
set noshowmode                                          " we use lightline plugin instead of default status line
set lcs=tab:>-,trail:-                                  " Set chars to display invisible characters (:list! to toggle invisible symbol display)
set encoding=utf-8
set number relativenumber
set wildmode=longest,list,full                          " autocompeletion options
set ic                                                  " set serach ignore case by default
" To enable mode shapes, "Cursor" highlight, and blinking
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                  \,sm:block-blinkwait175-blinkoff150-blinkon175

"================================ Plugin ================================
" Install vim-plugin if not exist.
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug vim plugin manager..."
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'itchyny/lightline.vim'            " status line
Plug 'ntpeters/vim-better-whitespace'   " display annoying whitespaces
Plug 'tpope/vim-surround'               " edit surround
Plug 'preservim/nerdtree'               " file explorer
Plug 'jreybert/vimagit'                 " git
Plug 'vimwiki/vimwiki'                  " handy memo
Plug 'tpope/vim-commentary'             " comment
call plug#end()

" lightline plugin config
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
      \ }

"================================ Key mapping ================================
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" resize splited window.
nnoremap <leader>= :vertical resize +4<CR>
nnoremap <leader>- :vertical resize -4<CR>
nnoremap <leader>0 <C-w>=
"double click <Esc> to set nohls
nnoremap <Esc><Esc> :nohlsearch<Bar>:echo<CR>
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
" When yank in visual mode, cursor will stay at the last character.
vnoremap y y`]
" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" set <F2> for toggle paste mode
set pastetoggle=<F2>

" Nerd tree

"================================ Command ================================
" Toggle auto comment
let g:NoAutoComment=1
function! ToggleAutoComment()
  if g:NoAutoComment == 1
	setlocal formatoptions+=cro
	let g:NoAutoComment = 0
  else
	setlocal formatoptions-=cro
	let g:NoAutoComment = 1
  endif
endfunction
command! Comment call ToggleAutoComment()

" Tab2Space & Space2Tab
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Remove all ^M
command! UnixEOL execute '%s///g'
