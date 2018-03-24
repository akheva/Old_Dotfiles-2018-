"
" ~/.vimrc
" vim: fdm=marker

" Options - Compatibility {{{
" -----------------------------------------------------------------------------

set nocompatible           " Prefer Vim defaults over Vi-compatible defaults.
set encoding=utf-8         " Set the character encoding to UTF-8.
filetype plugin indent on  " Enable file type detection.
syntax on                  " Enable syntax highlighting.

"}}}
" Options - Appearance {{{
" -----------------------------------------------------------------------------

let g:gruvbox_italic=1     " Enforce displaying italics
colorscheme gruvbox        " Set colorscheme to gruvbox
set background=dark        " Use colours that look good on a dark background.
set colorcolumn=80         " Show right column in a highlighted colour.
set completeopt-=preview   " Do not show preview window for ins-completion.
set cursorline
set diffopt+=foldcolumn:0  " Do not show fold indicator column in diff mode.
set history=10000          " Number of commands and search patterns to remember.
set laststatus=2           " Always show status line.
set linespace=9            " Increase line height spacing by pixels.
set noshowmode             " Do not show current mode on the last line.
set number                 " Precede each line with its line number.
set relativenumber         " Show line numbers relative to each other.
set showcmd                " Show command on last line of screen.
set showmatch              " Show matching brackets.
set t_Co=256               " Set the number of supported colours.
set title                  " Set window title to 'filename [+=-] (path) - VIM'.
set ttyfast                " Indicate fast terminal more smoother redrawing.

"}}}
" Options - Behaviour {{{
" -----------------------------------------------------------------------------

set backspace=2            " Allow <BS> and <Del> over everything.
set hidden                 " Hide when switching buffers instead of unloading.
set mouse=a                " Enable use of the mouse in all modes.
set nowrap                 " Disable word wrap.
set spelllang=en_us        " Check spelling in US English
set textwidth=0            " Do not break lines after a maximum width.
set wildmenu               " Use enhanced command-line completion.
set splitbelow             " Set the new split window bottom.
set splitright             " Set the new verticle split window right.

"}}}
" Options - Folding {{{
" -----------------------------------------------------------------------------

" Default folding options.
set foldignore=            " Do not ignore any characters for indent folding.
set foldlevelstart=99      " Always start editing with all folds open.
set foldmethod=indent      " Form folds by lines with equal indent.
set foldnestmax=10         " Limit fold levels for indent and syntax folding.

" Folding options for specific file types.
autocmd FileType python setlocal foldnestmax=5
autocmd FileType c,cpp,java setlocal foldmethod=syntax foldnestmax=5
autocmd FileType markdown setlocal foldmethod=marker

"}}}
" Options - GUI {{{
" -----------------------------------------------------------------------------

if has('gui_running')
  set guifont=Hack\-g\10               " Set the font to use.
  set guioptions=                      " Remove all GUI components and options.
  set guicursor+=a:block-blinkon0      " Use non-blinking block cursor.

  " Paste from PRIMARY
  inoremap <silent> <S-Insert> <Esc>"*p`]a
  " Paste from CLIPBOARD
  inoremap <silent> <M-v> <Esc>"+p`]a
endif

"}}}
" Options - Indents and Tabs {{{
" -----------------------------------------------------------------------------

" Default indent and tab options.
set autoindent             " Copy indent from previous line.
set expandtab              " Replace tabs with spaces in Insert mode.
set shiftwidth=4           " Spaces for each (auto)indent.
set smarttab               " Insert and delete sw blanks in the front of a line.
set softtabstop=4          " Spaces for tabs when inserting <Tab> or <BS>.
set tabstop=4              " Spaces that a <Tab> in file counts for.

" Indent and tab options for specific file types.
autocmd FileType c,make setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
autocmd FileType markdown,python,php setlocal shiftwidth=4 softtabstop=4 tabstop=4

"}}}
" Options - Searching {{{
" -----------------------------------------------------------------------------

set hlsearch               " Highlight search pattern results.
set ignorecase             " Ignore case of normal letters in a pattern.
set incsearch              " Highlight search pattern as it is typed.
set smartcase              " Override ignorecase if pattern contains upper case.

"}}}
" Options - Backup, Swaps, and Undos {{{
" -----------------------------------------------------------------------------

set backup                      " Enable Backups.
set undofile                    " Enable undo.
set swapfile                    " Enable swap.
set undodir=~/.vim/.undo//      " Set undo directory.
set backupdir=~/.vim/.backup//  " Set backup directory.
set directory=~/.vim/.swp//     " Set swap directory.

"}}}
" Mappings - General {{{
" -----------------------------------------------------------------------------

" Define <Leader> key.
let mapleader = ','
let maplocalleader = ','

" Exit insert mode.
inoremap jj <esc>

" Switch colon with semi-colon.
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Search command history matching current input.
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" Toggle folding
nnoremap <space> za

" Stop the highlighting for the current search results.
nnoremap <leader><leader> :nohlsearch<CR>

" Navigate split windows.
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Navigate buffers.
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>
nnoremap <leader><Tab> :b#<CR>

" Navigate location list.
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

" Search for trailing spaces and tabs (mnemonic: 'g/' = go search).
nnoremap g/s /\s\+$<CR>
nnoremap g/t /\t<CR>

" Write current file as superuser.
cnoremap w!! w !sudo tee > /dev/null %

"}}}
" Mappings - Toggle Options {{{
" -----------------------------------------------------------------------------

" (mnemonic: 'co' = change option).
nnoremap com :set mouse=<C-R>=&mouse == 'a' ? '' : 'a'<CR><CR>
nnoremap con :set number!<CR>
nnoremap cop :set paste!<CR>
nnoremap cos :set spell!<CR>
nnoremap cow :set wrap!<CR>

"}}}
" Mappings - Clipboard {{{
" -----------------------------------------------------------------------------

" Cut to clipboard.
vnoremap <Leader>x "*x
nnoremap <Leader>x "*x

" Copy to clipboard.
vnoremap <Leader>c "*y
nnoremap <Leader>c "*y

" Paste from clipboard.
nnoremap <Leader>v "*p
vnoremap <Leader>v "*p
nnoremap <Leader><S-V> "*P
vnoremap <Leader><S-V> "*P

""}}}
" Plugins - Install {{{
" -----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'Chiel92/vim-autoformat'         " Integrate external file formatters.
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' } " Code-completion manager.
Plug '/usr/local/opt/fzf'             " CLI fuzzy finder.
Plug 'junegunn/fzf.vim'               " CLI fuzzy finder.
Plug 'junegunn/vim-easy-align'        " Text alignment by characters.
Plug 'plasticboy/vim-markdown'        " Markdown Vim Mode.
Plug 'sjl/gundo.vim'                  " Visual undo Tree.
Plug 'scrooloose/nerdtree'            " File explorer window.
Plug 'tpope/vim-commentary'           " Commenting made simple.
Plug 'tpope/vim-fugitive'             " Git wrapper.
Plug 'tpope/vim-repeat'               " Enable repeat for tpope's plugins.
Plug 'tpope/vim-surround'             " Quoting/parenthesizing made simple.
Plug 'itchyny/lightline.vim'          " Pretty statusline.
Plug 'vimwiki/vimwiki'                " A personal Wiki for Vim.
Plug 'morhetz/gruvbox'                " Retro groove color theme.

call plug#end()

"}}}
" Plugin Settings - autoformat {{{
" -----------------------------------------------------------------------------

" Set format programs:

" Set file type and format file.
nnoremap <Leader>af :Autoformat<CR>

"}}}
" Plugin Settings - easy-align {{{
" -----------------------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}
" Plugin Settings - fzf {{{
" -----------------------------------------------------------------------------

let g:fzf_layout = { 'down': '10' }

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Ag<CR>
nnoremap <Leader>p :Files<CR>

"}}}
" Plugin Settings - nerdtree {{{
" -----------------------------------------------------------------------------

" Toggle NERD tree window.
nnoremap <Leader>1 :NERDTreeToggle<CR>

"}}}
" Plugin Settinggs - airline {{{
" -----------------------------------------------------------------------------

 let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \}

"}}}
" Plugin Settings - plug {{{
" -----------------------------------------------------------------------------

let g:plug_window = 'topleft new' " Open plug window in a horizontal split.

"}}}
"Plugin Settings - gundo {{{
"------------------------------------------------------------------------------

let g:gundo_right = 1

nnoremap <F5> :GundoToggle<CR>

"}}}
" Plugin Settings - YouCompleteMe {{{
" -----------------------------------------------------------------------------

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
