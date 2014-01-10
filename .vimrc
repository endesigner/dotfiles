"
"
"
" au BufWritePost *.erl call VimuxRunCommand("c(test).") || call VimuxRunCommand("test:rpn_test().")
"
"
"
"
" General Settings: "{{{

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
set ts=4
set sw=4
set nosta sta
set sts=4
set noet et
set ai noai
set nosi si
" prevent windows from resizing
set noea
set bg=dark
" Wrap lines
set tw=72
set fo=cqt
set wm=0
set is
" disable folding
set nofoldenable

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
" Load stuff that Vundle does not
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/bundle/igor/
set rtp+=~/.vim/bclose/ " <leader>bd without changing split layout.
"set rtp+=~/.vim/bundle/powerline/bindings/vim
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" set rtp+=~/.vim/bundle/upAndDown/

call vundle#rc()
"}}}

" Bundles: "{{{

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Everything else
Bundle 'benmills/vimux'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'oscarh/vimerl'
Bundle 'endesigner/vim-upAndDown'
Bundle 'digitaltoad/vim-jade'

" Snipmate stuff
Bundle 'garbas/vim-snipmate'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"

"Bundle 'Lokaltog/vim-powerline'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-fugitive'
Bundle 'ervandew/supertab'
Bundle 'mileszs/ack.vim'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
Bundle 'christoomey/vim-tmux-navigator'
"}}}

" Plugin Specifics: "{{{
" CtrlP keeps directory after CtrlPDir
let g:ctrlp_working_path_mode = 2

" Markdown
let g:vim_markdown_folding_disabled=1
au FileType *.{md,mdown,mkd,mkdn,markdown,mdwn} set wrap linebreak nolist textwidth=0 wrapmargin=0

" Supertab
let g:SuperTabNoCompleteAfter = ['^', ',', '\.', '\s', ':', '(', ')', '[', ']']
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

  set guifont=Menlo\ For\ Powerline:h11
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


" Convert tabs to spaces.
"autocmd BufRead *
    "\ let b:my_settings = {'expandtab': &et, 'shiftwidth': &sw, 'tabstop': &ts, 'softtabstop': &sts} |
    "\ exec ':DetectIndent' |
    "\ if !exists('b:settings') |
    "\   let b:settings = {'expandtab': &et, 'shiftwidth': &sw, 'tabstop': &ts, 'softtabstop': &sts} |
    "\ endif |
    "\ call Restore(b:my_settings) |
    "\ exec ':retab'

"autocmd BufWrite *
    "\ if exists('b:settings') |
    "\   call Restore(b:settings) |
    "\   exec ':%retab!' |
    "\ endif

"autocmd BufWritePost *
    "\ call Restore(b:my_settings) |
    "\ exec ':retab'

" Restore old settings including tabs.
func! Restore(settings)
  for [setting, oldval] in items(a:settings)
    if setting == 'expandtab'
        if oldval == 1
            exec ':set expandtab'
        else
            exec ':set noexpandtab'
        endif
    else
        exec ':set '.setting.'='.oldval
    endif
  endfor
endfunc


" autochange to the directory of current working file (useful shit!)
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

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

" Tabs: "{{{

set tabline=%!MyTabLine()
" Configure tabs for the console version
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction
"}}}

" Mappings:"{{{

" Set <Leader> key to ','
let mapleader=','

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

nmap <silent> <leader>. :cn<cr>
nmap <silent> <leader>, :cp<cr>

" Map UP/DOWN for buffer switching with some exceptions.
au BufEnter * call IdentifyBuffer()
function! IdentifyBuffer()
    " Let's switch buffers with arrow keys by default
    map <down> :bn<cr>
    map <up> :bp<cr>

    " make exceptions for some buffers
    let bufferz = ['NERD_tree', 'NetrwTreeListing']

    for bufn in bufferz
      if strridx(bufname("%"), bufn) != -1
        "echo 'this is buffer: ' . bufn
        map <down> j
        map <up> k
      endif
    endfor
endfunction

" Make it easy to update vimrc
nmap <Leader>s :source ~/.vimrc<cr>
nmap <Leader>v :tabnew ~/.vimrc<cr>

" Run make and show quickfix window
nmap <Leader>l :call Make()<cr>


" Cut
vnoremap <C-X> "+x

" Copy
vnoremap <C-C> "+y

" Paste
map <C-V> "+gP
cmap <C-V> <C-R>+

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
nnoremap <silent> <C-e> :call SetScrolloff()<esc>3gj
nnoremap <silent> <C-y> :call SetScrolloff()<esc>3gk
vnoremap <silent> <C-e> :call SetScrolloff()<esc>gv3gj
vnoremap <silent> <C-y> :call SetScrolloff()<esc>gv3gk
"nnoremap <C-e> 3<C-e>
"nnoremap <C-y> 3<C-y>

" Always keep cursor in the center
nnoremap <silent> j :call SetScrolloff()<esc>gj
nnoremap <silent> k :call SetScrolloff()<esc>gk
vnoremap <silent> j :call SetScrolloff()<esc>gvgj
vnoremap <silent> k :call SetScrolloff()<esc>gvgk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap N Nzz
nnoremap n nzz
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

nnoremap <silent> <LEFT> :NERDTreeToggle<CR>
" Taglist preferences
"let Tlist_Use_Right_Window = 1
nnoremap <silent> <RIGHT> :TagbarToggle<CR>

" Tab navigation like firefox
nmap <silent> <C-S-tab> :tabprevious<cr>
nmap <silent> <C-tab> :tabnext<cr>

map <silent> <C-S-tab> :tabprevious<cr>
map <silent> <C-tab> :tabnext<cr>

imap <silent> <C-S-tab> <ESC>:tabprevious<cr>i
imap <silent> <C-tab> <ESC>:tabnext<cr>i

nmap <silent> <C-t> :tabnew<cr>
imap <silent> <C-t> <ESC>:tabnew<cr>

" Move with hjkl in insert mode
imap <silent> <C-h> <C-o>h
imap <silent> <C-j> <C-o>j
imap <silent> <C-k> <C-o>k
imap <silent> <C-l> <C-o>l

" Clears highlighting of a search
map <silent> <leader>/ :let @/ = ""<cr>

" Move between splits
nnoremap <silent> <C-A-k> <C-W>W
nnoremap <silent> <C-A-h> <C-W>h
nnoremap <silent> <C-A-j> <C-W>w
nnoremap <silent> <C-A-l> <C-W>l

nnoremap <silent> <C-A-Up> <C-W>k<C-W>_
nnoremap <silent> <C-A-Down> <C-W>j<C-W>_
nnoremap <silent> <C-A-Enter> <C-W>_

" Remove current buffer
nnoremap <silent> <Leader>br :bd<cr>
"}}}


" Vimux Shit: "{{{

" Use exising pane (not used by vim) if found instead of running split-window.
let VimuxUseNearestPane = 1

func! MoveWithTmux(keypressed,direction)
    let k = a:keypressed
    let d = a:direction

    " I don't exactly know how this works, but it does
    " Something like silently move to the next split, and see
    " if we are still in the same split
    let oldw = winnr()
    silent! exe "normal! \<c-w>" . k
    let neww = winnr()
    silent! exe oldw.'wincmd w'

    " If we are in the same split, we must be at a
    " boundary so tell tmux to switch split
    if oldw == neww
        exec '!tmux select-pane ' . d
    else
        exe "normal! \<c-w>" . k
    end
endfunction

"nnoremap <silent> <c-j> :call MoveWithTmux('j', '-D')<cr><cr>2k<cr>
"nnoremap <silent> <c-k> :call MoveWithTmux('k', '-U')<cr><cr>2k<cr>
"nnoremap <silent> <c-h> :call MoveWithTmux('h', '-L')<cr><cr>2k<cr>
"nnoremap <silent> <c-l> :call MoveWithTmux('l', '-R')<cr><cr>2k<cr>

let g:erlangManPath = '/usr/share/man'
let g:erlangCompletionGrep='zgrep'
let g:erlangManSuffix='erl\.gz'

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