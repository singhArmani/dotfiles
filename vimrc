" General configuration---------------------
set nocompatible
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
set spell                " Enable spellchecking
" General configuration ends------------------

" User interface options---------------------
set noerrorbells
set visualbell              " Flash the screen instead of beeping on errors"
set mouse=a                 " Enable mouse for scrolling and resizing"
set title                   " Set the window's title, reflecting the file currently being edited"
" User interface ends------------------------

" Swap and backup file options - disable all of them"
" No backup or swap file
set nobackup
set noswapfile
set nowb
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

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine
Plug 'honza/vim-snippets'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Auto pair
Plug 'jiangmiao/auto-pairs'

" Rainbow Parenthesis
Plug 'luochen1990/rainbow'
" Language Syntax highlighting
Plug 'pangloss/vim-javascript'

" Themes
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
" You can change theme. Current theme is 'papercolor'

" Auto completion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto Save
Plug '907th/vim-auto-save'

" Prettier
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Lint Engine
Plug 'dense-analysis/ale'

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
colorscheme PaperColor

" Setting icons and Gui Fonts
set encoding=UTF-8

" Airline theme
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1

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


" Linting ALE
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']

" Fix files automatically on save
let g:ale_fix_on_save = 1

" When working with .ts files, ALE supports automatic import from external modules.
let g:ale_completion_tsserver_autoimport = 1

" Leader Key 
" change the mapleader from \ to <space>
let mapleader = "\<Space>"

" Exiting to normal mode from insert mode
imap jk <esc>
imap kj <esc>

"Backspace fix 
set backspace=indent,eol,start

" Cursor line
autocmd InsertEnter,InsertLeave * set cul!
set relativenumber

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

" Tab navigation
nnoremap <C-h> :tabprevious<CR>                                                                            
nnoremap <C-l> :tabnext<CR>


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
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Fzf with ag search and ignoring files/directories
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Rainbow parenthesis
let g:rainbow_active = 1

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Mapping--------------------------------
" Shift + Direction to Change Tabs
noremap <S-l> gt
noremap <S-h> gT

" Quit files with Leader + q
noremap <leader>q :q<cr>

" Clone Paragraph with cp
noremap cp yap<S-}>p

" Align current paragraph with Leader + a
noremap <leader>a =ip

" Apply Macros with Q
nnoremap Q @q
vnoremap Q :norm @q<cr>

" fugitive git bindings
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gA :Git add . %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Gpush<CR>
nnoremap <space>gpl :Gpull<CR>
nnoremap <leader>gB :Blame<CR> 
"Mapping ends-----------------------------
 

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
