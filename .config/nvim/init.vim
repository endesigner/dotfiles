set rtp+=~/.neovim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'vim-scripts/upAndDown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-bufferline'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'benmills/vimux'

Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-repeat'

call vundle#end()
filetype plugin indent on

colorscheme zenburn

" Syntax color
syntax on

" Avoids updating the screen before commands are completed
set lazyredraw

" Always show statusline
set laststatus=2

" Enable mouse
set mouse=a

" switch between buffers without saving
set hidden
" ignore case for searching
set ignorecase
" no backup files
set nobackup
" only in case you don't want a backup file while editing
set nowritebackup
" no swap files
set noswapfile
" Autoreloading a file as soon as it's changed
set autoread
" Show spaces and tabs
set listchars=tab:»·,trail:·,precedes:<,extends:>
set list
set ts=2
set sw=2
set expandtab
"set encoding=utf-8
set fileencoding=utf-8

" line numbers
set nu

" This setting ensures that each window contains a statusline that displays the current cursor position.
set ruler
set cmdheight=1
set laststatus=2
let g:bufferline_echo = 0
let g:bufferline_fixed_index =  0
autocmd VimEnter *
      \ let &statusline='%{bufferline#refresh_status()}'
      \ .bufferline#get_status_string()
set statusline=%F%h%m%w%r\ %Y\ (%{&ff})%=\ %c%V,\ %l/%L\ (%P)

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Set <Leader> key to ','
let mapleader=','

" Backspace in Visual mode deletes selection
vnoremap <BS> d

" Cycle buffers with arrows.
map <right> :bn<cr>
map <left> :bp<cr>
map <Leader>i :bn<cr>
map <Leader>h :bp<cr>

" Save buffer.
map <Esc><Esc> :w<CR>

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" Scroll a bit faster
nnoremap <silent> <s-n> :call SetScrolloff()<esc>3gj
nnoremap <silent> <s-e> :call SetScrolloff()<esc>3gk
vnoremap <silent> <s-n> :call SetScrolloff()<esc>gv3gj
vnoremap <silent> <s-e> :call SetScrolloff()<esc>gv3gk

" Colemak bindings
nnoremap <silent> n :call SetScrolloff()<esc>gj
nnoremap <silent> e :call SetScrolloff()<esc>gk
vnoremap <silent> n :call SetScrolloff()<esc>gvgj
vnoremap <silent> e :call SetScrolloff()<esc>gvgk

noremap s h
noremap t l
noremap f e

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap K Nzz
nnoremap k nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Duplicate  current line
nnoremap <silent> <Leader>d ma<esc>yyp<cr>`a

" Indenting
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv

" Clears highlighting of a search
map <silent> <leader>/ :let @/ = ""<cr>

" Remove current buffer
nnoremap <silent> <Leader>bd :bd<cr>
" Make it easy to update vimrc
let config_file = "~/.config/nvim/init.vim"
nmap <Leader><Leader>s :exec ':source' . config_file<cr>
nmap <Leader>v :exec ':e' . config_file<cr>

" Unite
"let g:unite_source_rec_async_command='ag -l --nocolor --nogroup --ignore ".hg" --ignore-dir=node_modules --ignore-dir=log --ignore-dir=app --ignore-dir=mock --ignore ".svn" --ignore ".git" --ignore ".bzr" --hidden -g ""'
let g:unite_source_grep_command='ag'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_default_opts='
      \ --nocolor
      \ --nogroup
      \ --line-numbers
      \ --ignore-dir=node_modules
      \ --ignore-dir=log
      \ --ignore-dir=mock'

call unite#custom#source('file_rec/async', 'ignore_pattern', 'node_modules/\|flight/\|mock/\|vendor/\|public/\|tmp/')

" Unite file explorer
nnoremap - :<C-u>Unite -no-split -start-insert file_rec/async<cr>
nnoremap F :<C-u>Unite -no-split -buffer-name=buffer buffer<cr>

" Unite grep
nnoremap <silent> <leader>g :<C-u>Unite grep:. -no-split -buffer-name=search-buffer<CR>
nnoremap <silent> <leader>G :<C-u>Unite grep:.:-s:\(TODO\|FIXME\) -no-split -buffer-name=search-buffer<CR>

" Unite buffer custom settings
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  let b:SuperTabDisabled=1

  nnoremap <buffer><expr> n unite#mappings#cursor_down(1)
  nnoremap <buffer><expr> e unite#mappings#cursor_up(1)

  imap <buffer> <C-n> <Plug>(unite_select_next_line)
  imap <buffer> <C-e> <Plug>(unite_select_previous_line)
  imap <buffer> <c-a> <Plug>(unite_choose_action)

  nmap <buffer> <space> <cr>
endfunction!

" Airline
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabNoCompleteAfter = ['^', ',', '\.', '\s', ':', '(', ')', '[', ']']
autocmd FileType *
      \ if &omnifunc != '' |
      \     call SuperTabChain(&omnifunc, '<c-p>') |
      \ endif

" EasyMotion
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_use_smartsign_us = 1
nmap <leader>w <Plug>(easymotion-bd-wl)
nmap / <Plug>(easymotion-sn)

" Tmux colemak nav
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-n> :TmuxNavigateDown<cr>
nnoremap <silent> <c-e> :TmuxNavigateUp<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-i> :TmuxNavigateRight<cr>

" Make sure vim receives keystrokes from tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Vimux
map <Leader>rp :VimuxPromptCommand<CR>
map <Leader>rl :VimuxRunLastCommand<CR>

" Call this to adjust scrolloff when cursor is on the low edge of the file.
func! SetScrolloff()
    " if (cursor below line ((number of lines in file - (winheight/2 ))) )
    "   Set scrolloff to 0
    let current=line('.')
    let threshold=winheight(0)/2
    let total=line('$')

    " Check if we are below threshold line.
    if current < (total-threshold)
        " Keep an amount of line before and after the cursoer.
        " This center the cursor in the midle of the screen.
        set scrolloff=999
    else
        set scrolloff=0
    endif
endfunc
