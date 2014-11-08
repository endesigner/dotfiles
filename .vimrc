" au BufWritePost *.erl call VimuxRunCommand("c(test).") || call VimuxRunCommand("test:rpn_test().")
"
" General Settings: "{{{

set wildmode=longest,list,full
set wildmenu

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
" fix colors in terminal
set t_Co=256
" autoreloading a file as soon as it's changed
set autoread
"set listchars=tab:»·,trail:·,precedes:<,extends:>
set listchars=tab:>.,trail:.,extends:>,precedes:<,
set list
set encoding=utf8
set fileencoding=utf8
set ts=2
set sw=2
set nosta sta
set sts=2
set noet et
set ai noai
set nosi si
" prevent windows from resizing
set noea
set bg=dark
" Autowrap lines
set tw=79
set formatoptions+=t

set fo=cqt
set wm=0
set is " incsearch

" disable folding
set nofoldenable

" Display color column to guide manual text weapping.
set colorcolumn=80

" Enable mouse
set mouse=a

" Treat words wich following characters as whole words
set isk+=_,$,@,%,#,-

" This setting ensures that each window contains a statusline that displays the current cursor position.
set ruler
set cmdheight=1
set laststatus=2
set statusline=%F%h%m%w%r\ %Y\ (%{&ff})%=\ %c%V,\ %l/%L\ (%P)

" Disable automatic comment insertioen
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" line numbers
set nu
" Always show status line
set ls=2
set hl=8:SpecialKey,@:NonText,d:Directory,e:ErrorMsg,i:IncSearch,l:Search,m:MoreMsg,M:ModeMsg,n:LineNr,r:Question,s:StatusLine,S:StatusLineNC,c:VertSplit,t:Title,v:Visual,V:VisualNOS,w:WarningMsg,W:WildMenu,f:Folded,F:FoldColumn,A:DiffAdd,C:DiffChange,D:DiffDelete,T:DiffText,>:SignColumn,B:SpellBad,P:SpellCap,R:SpellRare,L:SpellLocal,+:Pmenu,=:PmenuSel,x:PmenuSbar,X:PmenuThumb,*:TabLine,#:TabLineSel,_:TabLineFill,!:CursorColumn,.:CursorLine
" no beep
autocmd VimEnter * set vb t_vb=

" Autoshow quickfix window
"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow

:filetype plugin indent on
:filetype plugin on

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

" Avoids updating the screen before commands are completed
set lazyredraw

colorscheme zenburn
" Let's use ag instead of ack instead of grep.
let g:ackprg = 'ag --nogroup --nocolor --column'
"}}}


" Vundle Shit: "{{{

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/bundle/igor/
set rtp+=~/.vim/bclose/ " <leader>bd without changing split layout.
call vundle#rc()
"}}}

" Bundles: "{{{

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Everything else
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'osyo-manga/unite-quickfix'
Bundle 'benmills/vimux'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'oscarh/vimerl'
Bundle 'endesigner/vim-upAndDown'
Bundle 'digitaltoad/vim-jade'
Bundle 'marijnh/tern_for_vim'

" Snipmate stuff
Bundle 'garbas/vim-snipmate'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"

Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-fugitive'
Bundle 'ervandew/supertab'
Bundle 'mileszs/ack.vim'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'vim-scripts/Vim-R-plugin'
Bundle 'majutsushi/tagbar'
Bundle 'bling/vim-bufferline'
Bundle 'airblade/vim-rooter'
Bundle 'wting/rust.vim'

Bundle 'mxw/vim-jsx'

"}}}

" Plugin Specifics: "{{{
" Syntastic
let g:syntastic_always_populate_loc_list=1

" Bufferline
let g:bufferline_echo = 0
autocmd VimEnter *
      \ let &statusline='%{bufferline#refresh_status()}'
      \ .bufferline#get_status_string()

" EasyMotion
map <Leader>t <Plug>(easymotion-lineforward)
map <Leader>n <Plug>(easymotion-j)
map <Leader>e <Plug>(easymotion-k)
map <Leader>s <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" Tmux colemak nav
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-s> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-n> :TmuxNavigateDown<cr>
nnoremap <silent> <c-e> :TmuxNavigateUp<cr>
nnoremap <silent> <c-t> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
endif

" Airline
let g:airline_powerline_fonts = 1

" TagBar
let g:tagbar_compact = 1

" Markdown
let g:vim_markdown_folding_disabled=1
au FileType *.{md,mdown,mkd,mkdn,markdown,mdwn} set wrap linebreak nolist textwidth=0 wrapmargin=0

" Supertab
let g:SuperTabNoCompleteAfter = ['^', ',', '\.', '\s', ':', '(', ')', '[', ']']

"Erlang
let g:erlangManPath = '/usr/share/man'
let g:erlangCompletionGrep='zgrep'
let g:erlangManSuffix='erl\.gz'

"}}}

" Good To Have: "{{{

" Switch syntax highlighting on, when the terminal has colors"
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set cursorline
  set hlsearch
  set guioptions-=T
  set guioptions-=m

  "set guifont=Monospace:h11
  let g:Powerline_symbols = 'fancy'

  "set guifont=Monospace\ 10
  "set guifont=Liberation\ Mono\ 10
endif

" Make sure vim receives keystrokes from tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufRead *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif |


" autochange to the directory of current working file (useful shit!)
"if exists('+autochdir')
  "set autochdir
"else
  "autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
"endif

" quit if quickfix is last window
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction
"}}}

" Mappings:"{{{

" Set <Leader> key to ','
let mapleader=','

" Unite grep
nnoremap <silent> <leader>g :<C-u>Unite grep:. -no-split -buffer-name=search-buffer<CR>
nnoremap <silent> <leader>G :<C-u>Unite grep:.:-s:\(TODO\|FIXME\) -no-split -buffer-name=search-buffer<CR>

" Unite file explorer
nnoremap - :<C-u>Unite -no-split -start-insert file_rec/async<cr>
nnoremap F :Unite -no-split -start-insert buffer tab file_mru directory_mru<cr>

" Unite buffer custom settings
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  let b:SuperTabDisabled=1

  nnoremap <buffer><expr> n unite#mappings#cursor_down(1)
  nnoremap <buffer><expr> e unite#mappings#cursor_up(1)

  imap <buffer> <C-n> <Plug>(unite_select_next_line)
  imap <buffer> <C-e> <Plug>(unite_select_previous_line)
  imap <buffer> <c-a> <Plug>(unite_choose_action)

  imap <silent><buffer><expr> <C-s> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction!

" Reload haskell
nnoremap <leader>rr :call VimuxRunCommand(":l " . bufname("%"))<cr>
au! BufWritePost *.hs call VimuxRunCommand(":l " . bufname("%"))

" Cycle buffers with arrows.
map <right> :bn<cr>
map <left> :bp<cr>

" Quickfix window navigation
nmap <silent> <leader>m :call QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" Make it easy to update vimrc
nmap <Leader><Leader>s :source ~/.vimrc<cr>
nmap <Leader>v :e ~/.vimrc<cr>

" Cut
vnoremap <C-X> "+x

" Copy
vnoremap <C-C> "+y

" Paste
map <C-V> "+gP
cmap <C-V> <C-R>+

" Copy from X11 clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

nnoremap <leader>Y "+Y
vnoremap <leader>Y "+Y

nnoremap <leader>p "+p
vnoremap <leader>p "+p

nnoremap <leader>P "+P
vnoremap <leader>P "+P

"vmap <F7> "+ygv"zy`>
"" Paste from X11 clipboard (Shift-F7 to paste after normal cursor, Ctrl-F7 to paste over visual selection)
"nmap <F7> "zgP
"nmap <S-F7> "zgp
"imap <F7> <C-r><C-o>z
"vmap <C-F7> "zp`]
"cmap <F7> <C-r><C-o>z
"autocmd FocusGained * let @z=@+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

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

" Always keep cursor in the center
"nnoremap <silent> j :call SetScrolloff()<esc>gj
"nnoremap <silent> k :call SetScrolloff()<esc>gk
"vnoremap <silent> j :call SetScrolloff()<esc>gvgj
"vnoremap <silent> k :call SetScrolloff()<esc>gvgk

" Colemak bindings {{{
nnoremap <silent> n :call SetScrolloff()<esc>gj
nnoremap <silent> e :call SetScrolloff()<esc>gk
vnoremap <silent> n :call SetScrolloff()<esc>gvgj
vnoremap <silent> e :call SetScrolloff()<esc>gvgk

noremap n j|noremap <C-w>n <C-w>j|noremap <C-w><C-n> <C-w>j
noremap e k|noremap <C-w>e <C-w>k|noremap <C-w><C-e> <C-w>k
noremap s h
noremap t l
noremap f e

"imap <silent> <C-h> <C-o>h
"imap <silent> <C-n> <C-o>j
"imap <silent> <C-e> <C-o>k
"imap <silent> <C-i> <C-o>l
"}}}

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap K Nzz
nnoremap k nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Resize current buffer by +/- 5
nnoremap <Leader><left> :vertical resize -5<cr>
nnoremap <Leader><down> :resize +5<cr>
nnoremap <Leader><up> :resize -5<cr>
nnoremap <silent> <Leader><right> :vertical resize +5<cr>

" Delete a line above/below current line preserving cursor position
nnoremap <silent> <leader>+ ma<esc>k"_dd<esc>`a
nnoremap <silent> <leader>- ma<esc>j"_dd<esc>`a

" Duplicate  current line
nnoremap <silent> <Leader>d ma<esc>yyp<cr>`a

nnoremap <silent> <down> :TagbarToggle<CR>

" Tab navigation like firefox
nmap <silent> <C-S-tab> :tabprevious<cr>
nmap <silent> <C-tab> :tabnext<cr>

map <silent> <C-S-tab> :tabprevious<cr>
map <silent> <C-tab> :tabnext<cr>

imap <silent> <C-S-tab> <ESC>:tabprevious<cr>i
imap <silent> <C-tab> <ESC>:tabnext<cr>i

nmap <silent> <C-t> :tabnew<cr>
imap <silent> <C-t> <ESC>:tabnew<cr>

" Clears highlighting of a search
map <silent> <leader>/ :let @/ = ""<cr>

" Move between splits
"nnoremap <silent> <C-A-k> <C-W>W
"nnoremap <silent> <C-A-h> <C-W>h
"nnoremap <silent> <C-A-j> <C-W>w
"nnoremap <silent> <C-A-l> <C-W>l

"nnoremap <silent> <C-A-Up> <C-W>k<C-W>_
"nnoremap <silent> <C-A-Down> <C-W>j<C-W>_
"nnoremap <silent> <C-A-Enter> <C-W>_

" Remove current buffer
nnoremap <silent> <Leader>br :bd<cr>
"}}}


" Vimux Shit: "{{{

" Use exising pane (not used by vim) if found instead of running split-window.
"let VimuxUseNearestPane = 1

"func! MoveWithTmux(keypressed,direction)
    "let k = a:keypressed
    "let d = a:direction

    "" I don't exactly know how this works, but it does
    "" Something like silently move to the next split, and see
    "" if we are still in the same split
    "let oldw = winnr()
    "silent! exe "normal! \<c-w>" . k
    "let neww = winnr()
    "silent! exe oldw.'wincmd w'

    "" If we are in the same split, we must be at a
    "" boundary so tell tmux to switch split
    "if oldw == neww
        "exec '!tmux select-pane ' . d
    "else
        "exe "normal! \<c-w>" . k
    "end
"endfunction

nnoremap <silent> <c-n> :TmuxNavigateDown<cr>
nnoremap <silent> <c-e> :TmuxNavigateUp<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-i> :TmuxNavigateRight<cr>

"nnoremap <silent> <c-n> :call MoveWithTmux('j', '-D')<cr><cr>2k<cr>
"nnoremap <silent> <c-e> :call MoveWithTmux('k', '-U')<cr><cr>2k<cr>
"nnoremap <silent> <c-h> :call MoveWithTmux('h', '-L')<cr><cr>2k<cr>
"nnoremap <silent> <c-i> :call MoveWithTmux('l', '-R')<cr><cr>2k<cr>

" Open tmux in a split.
map <Leader>ro :call OpenShellSplit()<cr>

" Prompt for a command to run
map <Leader>rp :VimuxPromptCommand<CR>

" Run last command
map <Leader>rl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>ri :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane map
map <Leader>vs :VimuxInterruptRunner<CR>

" Close all other tmux panes in current window
map <Leader>vx :VimuxClosePanes<CR>

" Close all other tmux panes in current window
map <Leader>rx :call CloseShellSplit()<cr>

" Interrupt any command running in the runner pane
map <Leader>rs :InterruptVimTmuxRunner<cr>

map <Leader>rc :call TmuxCompileErlang()<CR>
map <Leader>rf :call TmuxRunErlangFunction()<CR>

command! Erl :call VimuxRunCommand("erl")

map <leader>[ :call DispatchErlangCommand("myArg")<cr>

function! DispatchErlangCommand(arg)
    call SaveBuffer()
    call OpenShellSplit()
    call StartErlShell()
    call TmuxCompileErlang()
endfunction

function! OpenShellSplit()
    if exists("b:shell_is_open")
        echo "shell is open, return"
        return
    endif

    " Open shell in tmux split
    echo "shell is closed, open it"
    let b:shell_is_open = 1
    call VimuxRunCommand("clear")
endfunction

function! CloseShellSplit()
        if exists("b:shell_is_open")
                unlet b:shell_is_open
                :CloseVimTmuxPanes
        endif
endfunction

function! SaveBuffer()
        " Write changes (if not saved)
        let i = tabpagenr('$')
        let winnr = tabpagewinnr(i)
        let buflist = tabpagebuflist(i)
        " Now s contains * if current buffer was modified
        let s = (getbufvar(buflist[winnr - 1], "&mod")?'*':'')
        if s == "*"
                :w
        endif
endfunction

function! StartErlShell()
    call VimuxRunCommand("erl") " erlang shell
endfunction

function! TmuxCompileErlang()
  let modname = split(bufname("%"), '\.')[0]
  call VimuxRunCommand("c(" . modname . ").")
endfunction

function! TmuxRunErlangFunction()
  let l:modname = split(bufname("%"), '\.')[0]
  let l:funname = expand("<cword>")
  let l:fun = modname . ":" . funname
  let l:curline = getline('.')
  let l:args = input('Args for ' . fun . ': ')
  let l:tmfun = fun . "(" . args . ")."
  call VimuxRunCommand(tmfun)
endfunction
"}}}

" Tabular stuff "{{{
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Align when | is typed.
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
"}}}

" Remote trailing whitespaces
func! TrimSpaces()
    %s/\s\+$//
endfunc

func! QuickFix()
  " show errors if there are any
  if (len(getqflist()) != 0)
    " Open quickfix window at the bottom
    :botright copen
  else
    :cclose
  endif
endfunc

func! Make()
    :w
    silent :make
    :call QuickFix()
endfunc

let g:VimuxResetSequence = ''

" Lines added by the Vim-R-plugin command :RpluginConfig (2014-Mar-29 14:47):
" Change the <LocalLeader> key:
let maplocalleader = ","
" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif
" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
