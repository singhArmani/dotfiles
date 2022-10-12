set number
set numberwidth=5
set relativenumber


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
set splitbelow              " Split panes to bottom
set splitright              " Split pane to right

" italics fonts : https://pezcoder.medium.com/how-i-migrated-from-iterm-to-alacritty-c50a04705f95
highlight Comment cterm=italic gui=italic
"set cursorline              " Set a visual line to show the position of the cursor
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
" wrap lines when required with `:Wrap` command
command! -nargs=* Wrap set wrap linebreak nolist
" end-----------------------------

" Search options------------------
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,

                    "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
nmap <silent> ./ :nohlsearch<CR>
" end-----------------------------

" Leader Key 
" change the mapleader from \ to <space>
let mapleader = "\<Space>"
nmap <leader>rn :set rnu!<cr>

" " Plugins---------------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdtree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'voldikss/vim-floaterm'
Plug 'phaazon/hop.nvim'
" buffer management
Plug 'moll/vim-bbye'

" Commenting
Plug 'scrooloose/nerdcommenter'


" Themes -----------------------
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'sainnhe/sonokai'
Plug 'vv9k/bogster'
Plug 'logico/typewriter-vim'

" Vim helpers ----------------------------
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
" Plug 'skamsie/vim-lineletters'
Plug 'szw/vim-maximizer'
Plug 'takac/vim-hardtime'
Plug 'goldfeld/vim-seek'
Plug 'karb94/neoscroll.nvim'

" Auto completion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-stylelintplus',
  \ 'coc-eslint',
  \ ]

" Snippets
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

" Js doc
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}

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

" Search and Replace Project wise 
Plug 'wincent/ferret'

" Adding more target object vim like feature
Plug 'wellle/targets.vim'

" Rainbow 
Plug 'frazrepo/vim-rainbow'

call plug#end()

" vim seek motion (disable substitute vim command)
let g:seek_subst_disable = 1
let g:seek_enable_jumps = 1

" neovim hop------------------------------
" call v:lua.require'hop'.setup()

" neovim smooth scrolling
" call v:lua.require('neoscroll').setup()

" normal mode --->
" nnoremap <Leader><leader>b, :HopWordBC<CR>
" nnoremap <Leader><leader>w :HopWordAC<CR>
nnoremap ,, :HopWordBC<CR>
nnoremap .. :HopWordAC<CR>

" guide on the keybinding : Ref: https://dev.to/kquirapas/neovim-on-steroids-vim-sneak-easymotion-hopnvim-4k17
" hop ends ------------------------
"

let g:rainbow_active = 1

"Folding ----------
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
" fold toggle (removing this to bring :Ack mapping)
nmap <leader>a za 

" close all open folds
nmap <leader>m zm

" open all closed folds
nmap <leader>n zn

"-----------


" Setting theme color
set t_Co=256   " This is may or may not needed.

" Mirage color scheme ---
" let ayucolor="mirage"

" Vim Script
" Example config in VimScript
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

" Load the colorscheme
colorscheme bogster
set background=dark

" Setting colorscheme based on the daytime
"exe 'color' ((strftime('%H') % 18) > 6 ? 'typewriter' : 'bogster')
"exe 'set background='. ((strftime('%H') % 18) > 6 ? 'light' : 'dark')

" To clear the sign column for git gutter (see docs)
highlight clear SignColumn
"---------------------------

" Setting icons and Gui Fonts, Airline ------
set encoding=UTF-8

let g:airline_theme = 'sonokai'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'jsformatter'
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

" Use tab for trigger completion with characters ahead and navigate. (this is what I was using for latest)
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" NOTE: Uncomment the following mapping if you want to bring back the tab scrolling and auto intellisense expand features
"  inoremap <silent><expr> <TAB>
        "\ pumvisible() ? "\<C-n>" :
        "\ <SID>check_back_space() ? "\<TAB>" :
        "\ coc#refresh()
"  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"  function! s:check_back_space() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~# '\s'
"  endfunction


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" Use the following mapping if your want to disable the tab intellisense and  use <C-n> and <C-p> to scroll through the list.
" Also, the following mapping let's you expand the snippet when you hit tab over the selection. 
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? coc#_select_confirm() :
      "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

let g:coc_snippet_next = '<tab>'
"--------------------------------------------


" True color support------------
set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
" True color support ends-----------

" Exiting to normal mode from insert mode 
imap jk <esc>
imap kj <esc>

"Backspace fix 
set backspace=indent,eol,start

" neoclide configuration--------------
" ref: https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

" perform code action
nmap <leader>do <Plug>(coc-codeaction)

" Js documentation
nmap <leader>jd <Plug>(jsdoc)

" reselect pasted text
nnoremap gp `[v`]

" Open file under cursor in vertical split
map <leader>p <C-w>vgf

" Vim tricks (https://vimtricks.com/p/get-the-current-file-path/?rating=5)
" Get the current file path
map <leader>c :let @*=fnamemodify(expand("%"), ":~:.") . ":" . line(".")<CR>

" NOTE: <leader>s is used for searching word under cursor :Ack ferret
" workspace symbols 
" nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

" renaming a symbol 
"nmap <leader>rn <Plug>(coc-rename)

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



" Open image in vim (Ref: https://til.hashrocket.com/posts/39f85bac84-open-images-in-vim-with-iterm-)
" NOTE: May not work with tmux
autocmd! BufEnter *.png,*.jpg,*gif exec "! ~/.iterm2/imgcat ".expand("%") | :bw

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

" Substitute (replace command)
nmap <leader>ss :%s/\v
nmap <leader>ee :/\<\><c-b><right><right><right>

" Buffer
" Move to the previous buffer with "Shift+p"
nnoremap <S-n> :bp<CR>

" Move to the next buffer with "Shift+n"
nnoremap <S-m> :bn<CR>

" List all possible buffers with "gl"
nnoremap doc :JsDoc<CR>

" List all possible buffers with "gb" and accept a new buffer argument [1]
nnoremap gb :ls<CR>:b
" buffer ends----------------

" Relative letter numbers (using hop for time being)
" map <silent>, <Plug>LineLetters

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
"


" UltiSnippets---------------------------
" Trigger configuration
" let g:UltiSnipsExpandTrigger="<C-y>"
" let g:UltiSnipsJumpForwardTrigger="<C-b>"
" let g:UltiSnipsJumpBackwardTrigger="<C-z>"

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

" The following line is copied from coc-snippets docs
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
" snippets ends-------------------

" Use <Leader>w for saving
noremap <leader>w :update<CR>
" ------------------------

" Tab key mappings
map <leader>tn :tabnew<cr>
map <leader>t<leader> :tabnext
map <leader>tm :tabmove
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>

" Syntax highlighting
autocmd BufEnter * :syntax sync fromstart

" NerdTree --------------------------------------------------------
" Open NERDTree with CTrl-n
nnoremap <Leader>f :NERDTreeToggle<Enter>

" How can I open a NERDTree automatically when vim starts up if no files were
" specified
autocmd StdinReadPre * let s:std_in=1
" NOTE: Uncomment the following line if you want to open nerdtree when vi into
" the project directory
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" directly open NerdTree on the file you’re editing to quickly 
" perform operations on it with NERDTreeFind
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Automatically closes NERDTree when open a file
let NERDTreeQuitOnOpen = 1


" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Show hidden files starting with .
let NERDTreeShowHidden=0 " Don't show hidden files/folder by default. Use `Shift + i` to toggle

" Prettier NERD
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" maximize current split, vim tricks: https://vimtricks.com/p/maximize-the-current-split/
noremap <C-w>m :MaximizerToggle<CR>

" NerdTree Ends -------------------------------------------------------


" Toggle Hard time vim mode (don't use h, j, k, l key)
nnoremap <leader>t <Esc>:call HardTimeToggle()<CR>

" Fzy key mapping
map ; :Files<CR>

" Ignore node_modules
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Git commit message auto spell checking and text wrapping 
autocmd Filetype gitcommit setlocal spell textwidth=72

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
" The following line was changed from 'Ag' --> 'Ack', for better search
" command variations. We can search and replace in the whole project too
map ' :Ag<space> 
"search for word under cursor by pressing 
"NOTE: uncomment the following line when you need to use AG search, mapping "
"for register naming atm.
" nnoremap " :Ag <C-R><C-W><cr>:cw<cr>

" Ignore test files while searching with AG (customize it based on project you are working)
map 't : Ack --ignore *.test.js<space>
map 'e : Ack -G \.test\.js$<space>

map <Leader>b :Back<space>
" Ag ends------------------


" Highlight syntax inside markdown
let g:markdown_fenced_languages = ['html', 'javascript', 'css', 'vim']

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Mapping--------------------------------

" maximize current split or return to previous
noremap <C-w>m :MaximizerToggle<CR>

" Hard mode vim 
let g:hardtime_default_on = 1



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

" Clone Paragraph with cp
noremap cp yap<S-}>p

" fugitive git bindings----------

nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gB :Blame<CR> 



" floaterm: open layzgit  Ref: https://kkalamarski.me/essential-neovim-plugins
nnoremap <leader>gg :FloatermNew --height=0.9 --width=0.9 --wintype=float --name=lazygit --autoclose=2 lazygit <CR>
" floaterm ends----------------

" Show related commit in a popup (Jovica)
map <silent><Leader>g :call setbufvar(winbufnr(popup_atcursor(systemlist("cd " . shellescape(fnamemodify(resolve(expand('%:p')), ":h")) . " && git log --no-merges -n 1 -L " . shellescape(line("v") . "," . line(".") . ":" . resolve(expand("%:p")))), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>
"Mapping ends-----------------------------

" Vim tricks (open file under cursor in vertical split)
map <leader>p <C-w>vgf

" Vim tricks close all hidden buffers
command Bd :up | %bd | e#
" Delete buffers without closing your windows
:noremap <Leader>bb :Bdelete<CR>

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
"
lua require('config')
