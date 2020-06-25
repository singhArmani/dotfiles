set number
set numberwidth=5

" Vim history
set history=1000         " remember more commands and search history
set undolevels=1000      " use many levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class 
set scrolloff=4          " Keep at least 4 lines below cursor
syntax enable            " Enable syntax highlighting.

"Disable entering comment automatically by vim upon entering a new line
set formatoptions-=cro
" set spell                " Enable spellchecking
" General configuration ends------------------

" User interface options---------------------
set noerrorbells
set visualbell              " Flash the screen instead of beeping on errors"
set mouse=a                 " Enable mouse for scrolling and resizing"
set title                   " Set the window's title, reflecting the file currently being edited"
set splitbelow              " Split panes to bottom
set splitright              " Split pane to right
" User interface ends------------------------

" Swap and backup file options - disable all of them"
" No backup or swap file
set nobackup
set noswapfile
set nowb
set autoread
" end-----------------------------

"Indentation options-------------
set autoindent         " New lines inherit the indentation of previous line"
set tabstop=4          " show existing tab with 4 spaces width
set shiftwidth=2       " when indenting with '>', use 4 spaces width
set expandtab          " On pressing tab, insert 4 spaces
filetype plugin indent on
set nowrap             " Don't wrap lines"
" end-----------------------------

" Search options------------------
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
" end-----------------------------

" Leader Key 
" change the mapleader from \ to <space>
let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'moll/vim-bbye'

" Merge tool(https://github.com/samoshkin/vim-mergetool)
Plug 'samoshkin/vim-mergetool'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine
Plug 'honza/vim-snippets'

" Focus
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Auto pair
" Remove this if coc.vim auto pair doesn't work
" Plug 'jiangmiao/auto-pairs'


" Rainbow Parenthesis
Plug 'luochen1990/rainbow'
" Language Syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Themes
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'reedes/vim-colors-pencil'

" Auto completion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

" Auto Save
Plug '907th/vim-auto-save'

" Indent Guide
Plug 'nathanaelkane/vim-indent-guides'

" Git status flag NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Fzf finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git gutter (for showing the git diff as in VS code)
Plug 'airblade/vim-gitgutter'

" Fugitive (Git wrapper)
Plug 'tpope/vim-fugitive'

" Vim icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Setting theme color
set t_Co=256   " This is may or may not needed.
set background=dark
"colorscheme Gruvbox
"colorscheme Molokai
"colorscheme PaperColor
"colorscheme Palenight
"colorscheme solarized
colorscheme pencil

" Setting icons and Gui Fonts
set encoding=UTF-8

" Airline theme
let g:airline_theme='base16'
"let g:airline_theme = "palenight"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'jsformatter'

" Concealing
set conceallevel=2
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "☐"
let g:javascript_conceal_underscore_arrow_function = "☐"

" toggling
map <leader>cu :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
"--------------------

" Autocompletion configuration settings
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"--------------------------------------------


" Exiting to normal mode from insert mode
imap jk <esc>
imap kj <esc>

"Backspace fix 
set backspace=indent,eol,start

" Vim sessions
let g:sessions_dir = '~/vim-sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" neoclide configuration--------------
" ref: https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

" perform code action
nmap <leader>do <Plug>(coc-codeaction)

" workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

" renaming a symbol 
nmap <leader>rn <Plug>(coc-rename)

" jumping to errors in a file 
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Loading coc prettier/eslint only when these tools are installed in the
" project dir.
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Format using prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" coc config ends-------------------------

" Cursor line
autocmd InsertEnter,InsertLeave * set cul!

" Goyo & limelight Integration
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Indent guide enabled
" NOTE: disabling it as prettier will fix it. Turn it on when you 
" don't have prettier eslint auto fix
let g:indent_guides_enable_on_vim_startup = 0

" Navigation Split
" Mapping leader key for navigation split windows
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" Vertical split using leader key
map <leader>sv :vsp<cr>

" Horizontal split using leader key
map <leader>sv :vsp<cr>
map <leader>sh :sp<cr>

" Tab navigation
nnoremap <C-h> :tabprevious<CR>                                                                            
nnoremap <C-l> :tabnext<CR>

" Buffer
" Move to the previous buffer with "Shift+p"
nnoremap <S-p> :bp<CR>

" Move to the next buffer with "Shift+n"
nnoremap <S-n> :bn<CR>

" List all possible buffers with "gl"
nnoremap gl :ls<CR>

" List all possible buffers with "gb" and accept a new buffer argument [1]
nnoremap gb :ls<CR>:b
" buffer ends----------------

" GoTo code navigation.----------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" ---------------------------------------

" UltiSnippets---------------------------
" Trigger configuration
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Open snippets for UltiSnips
nnoremap <leader>es :UltiSnipsEdit<cr>


"Moving between wrapped text in a single line fix
nnoremap j gj
nnoremap k gk

" Quickly edit/reload the vimrc file, (can use :e $MYVIMRC too)
nmap <silent> <leader>ev :vnew $MYVIMRC<CR>
nmap <silent> <leader>so :so $MYVIMRC<CR>

" Auto Save
let g:auto_save = 1  " enable AutoSave on Vim startup


" Tab key mappings
map <leader>tn :tabnew<cr>
map <leader>t<leader> :tabnext
map <leader>tm :tabmove
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>

" NerdTree --------------------------------------------------------
" Open NERDTree with CTrl-n
nnoremap <Leader>f :NERDTreeToggle<Enter>

" How can I open a NERDTree automatically when vim starts up if no files were
" specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" directly open NerdTree on the file you’re editing to quickly 
" perform operations on it with NERDTreeFind
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Automatically closes NERDTree when open a file
let NERDTreeQuitOnOpen = 1


" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Show hidden files starting with .
let NERDTreeShowHidden=1

" Prettier NERD
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" NerdTree Ends -------------------------------------------------------

" Fzy key mapping
map ; :Files<CR>

" Ignore node_modules
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Git gutter key mapping
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nnoremap <Leader>tg :GitGutterSignsToggle<CR>

" Cursor shape (without tmux)
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Cursor shape (with tmux)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fzf with ag search and ignoring files/directories---------------------------
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Start a search query by pressing '
map ' :Ag<space>
"search for word under cursor by pressing "
nnoremap " :Ag <C-R><C-W><cr>:cw<cr>

" Passing args to :Ag
" Ref: https://github.com/junegunn/fzf.vim/issues/92#issuecomment-191248596 
function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
endfunction

autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)
" Ag ends------------------

" Rainbow parenthesis
let g:rainbow_active = 1

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Mapping--------------------------------
" Shift + Direction to Change Tabs
noremap <S-l> gt
noremap <S-h> gT

" Quit files with Leader + q(incooperating vim-merge context aware
" QuitWindow() function) 
" https://github.com/samoshkin/vim-mergetool#quitting-merge-mode
function s:QuitWindow()

  " If we're in merge mode, exit
  if get(g:, 'mergetool_in_merge_mode', 0)
    call mergetool#stop()
    return
  endif

  if &diff
    " Quit diff mode intelligently...
  endif

  quit
endfunction

command QuitWindow call s:QuitWindow()
nnoremap <silent> <leader>q :QuitWindow<CR>

" If there's any issue with above QuitWindow function then just remove it
" and uncomment the line below
"nnoremap <silent> <leader>q :q<CR>

" delete buffers without closing your windows
:nnoremap <Leader>bb :Bdelete<CR>

" Clone Paragraph with cp
noremap cp yap<S-}>p

" Align current paragraph with Leader + a
noremap <leader>a =ip

" Apply Macros with Q
nnoremap Q @q
vnoremap Q :norm @q<cr>

" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gA :Git add . %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>

" skip the staging area
nnoremap <leader>gh :Gcommit -a -v -q<CR>

nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
" Show commit history of the current branch we are in
nnoremap <leader>gg :silent! Glog --oneline --decorate --graph<CR>
" Show commit history for all branches 
nnoremap <leader>gG :silent! Glog --oneline --decorate --graph --all<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Gpush<CR>
nnoremap <leader>gpl :Gpull<CR>
nnoremap <leader>gB :Blame<CR> 
"Mapping ends-----------------------------

" Merge tool (vim-mergetool) configuration-----
" merge mode toggle
nmap <leader>mt <plug>(MergetoolToggle)

" toggle to other common layout (mbr) (merged, base, and remote)
nnoremap <silent> <leader>mb :call mergetool#toggle_layout('mr,b')<CR>
nmap <expr> <S-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
nmap <expr> <S-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
nmap <expr> <S-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
nmap <expr> <S-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'

" vim-airline merge mode detection(https://github.com/samoshkin/vim-mergetool#merge-mode-detection)
function! AirlineDiffmergePart()
  if get(g:, 'mergetool_in_merge_mode', 0)
    return '↸'
  endif

  if &diff
    return '↹'
  endif

  return ''
endfunction

call airline#parts#define_function('_diffmerge', 'AirlineDiffmergePart')
call airline#parts#define_accent('_diffmerge', 'bold')

let g:airline_section_z = airline#section#create(['_diffmerge'])

" Merge tool configuration end------

" Jovica tip: Git blame---------------
command! -nargs=* Blame call s:GitBlame()

function! s:GitBlame()
    let cmd = "git blame -w " . bufname("%")
    let nline = line(".") + 1
    botright new
    execute "$read !" . cmd
    execute "normal " . nline . "gg"
    execute "set filetype=perl" 
endfunction


" ---------end-------------
