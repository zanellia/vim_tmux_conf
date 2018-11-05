set nocompatible              
filetype off                  
set pastetoggle=<F9>
set background=dark
" set background=light
colorscheme solarized
"colorscheme elflord 
set t_Co=256
set tabstop=4
set expandtab
set clipboard=unnamedplus
set hlsearch
set foldmethod=syntax
"set nowrap
set tags=./tags;
set autoread
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
syntax enable
set laststatus=2
set shiftwidth=4
"let NERDTreeMapOpenInTab='<ENTER>'
"let g:solarized_termcolors=256
"let g:vimtex_fold_enabled = 1
let g:vimtex_fold_enabled = 1
"let g:vimtex_fold_manual = 1
"let g:vimtex_fold_comments = 1
"let g:vimtex_fold_manual=1
let g:vimtex_view_automatic = 1
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ }
hi clear SpellBad
" syntax match SpellBad /\<\(\w\+\)\s\+\1\>/
" hi SpellBad    ctermfg=166      ctermbg=000     cterm=underline      guifg=#FFFFFF   guibg=#000000   gui=none
hi SpellBad    ctermfg=166 cterm=underline        gui=none
" hi SpellBad cterm=underline
" autocmd BufRead,BufNewFile *.tex setlocal spell
set spell spelllang=en_us

" augroup vimrc
"   au BufReadPre * setlocal foldmethod=indent
"   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'kien/ctrlp.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'svermeulen/vim-easyclip'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'matze/vim-move'
Plugin 'lervag/vimtex'
Plugin 'Valloric/YouCompleteMe'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'Konfekt/FastFold'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
autocmd BufRead,BufNewFile *.jl set filetype=julia
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"--------------------
" Function: Open tag under cursor in new tab
" Source:   https://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
"--------------------
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"--------------------
" Function: Remap keys to make it more similar to firefox tab functionality
" Purpose:  Because I am familiar with firefox tab functionality
"--------------------
map     <C-T>       :tabnew<CR>
map     <C-N>       :!gvim &<CR><CR>

nmap d <Plug>MoveMotionPlug
xmap d <Plug>MoveMotionXPlug
nmap dd <Plug>MoveMotionLinePlug

inoremap <A-j> :m .+1<CR>==
inoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nmap <silent> <Up> gk
nmap <silent> <Down> gj

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" shortcut for pdb debugging 
map <Leader>p :call InsertLine()<CR>

function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal o".trace
endfunction

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
