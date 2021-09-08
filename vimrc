set number
set numberwidth=5
set relativenumber

" Italics comments
" (https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic)
set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic

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
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'moll/vim-bbye'
Plug 'terryma/vim-expand-region'
Plug 'markonm/traces.vim'
Plug 'ojroques/vim-scrollstatus'
" Live markdown
Plug 'shime/vim-livedown'

" Merge tool(https://github.com/samoshkin/vim-mergetool)
Plug 'samoshkin/vim-mergetool'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine
Plug 'honza/vim-snippets'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Language Syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'skamsie/vim-lineletters'

" Themes -----------------------
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'reedes/vim-colors-pencil'
Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'arzg/vim-colors-xcode'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'


Plug 'sainnhe/sonokai'

" Vim helpers ----------------------------
Plug 'goldfeld/vim-seek'
Plug 'ap/vim-css-color'
Plug 'machakann/vim-highlightedyank'
Plug 'wellle/context.vim'
Plug 'Yggdroot/indentLine'
Plug 'AndrewRadev/sideways.vim'
Plug 'szw/vim-maximizer' " maximize a single split, and bring back to split setting you had prior.

" Auto completion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ ]
" vim seek motion (disable substitute vim command)
let g:seek_subst_disable = 1
let g:seek_enable_jumps = 1

" Js doc
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}

" Auto Sav
Plug '907th/vim-auto-save'


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

" Vim smooth scrolling
Plug 'psliwka/vim-smoothie'

" Rainbow 
Plug 'frazrepo/vim-rainbow'


call plug#end()

" Context vim (disabled by default), toggle it on or off with :ContextToggle
let g:context_enabled = 1

let g:rainbow_active = 1

" Folding ----------
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
"-----------
" Folding by syntax
"set foldmethod=syntax "syntax highlighting items specify folds  
"set foldcolumn=1 "defines 1 col at window left, to indicate folding  
"let javaScript_fold=1 "activate folding by JS syntax  
"set foldlevelstart=99 "start file with all folds opened
"-----------


" Setting theme color
set t_Co=256   " This is may or may not needed.


" React Testing Template
 autocmd BufNewFile  *.test.js	0r ~/vim/skeleton.js

"let g:sonokai_style = 'atlantis'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italc_comment = 1
"colorscheme sonokai

" Mirage color scheme ---
let ayucolor="mirage"
" colorscheme ayu

" tempus color scheme
" colorscheme tempus_dusk
let g:tempus_enforce_background_color=1

"colorscheme xcodedark
colorscheme onehalfdark

"colorscheme one
"colorscheme Gruvbox
"colorscheme Molokai
"colorscheme PaperColor
"colorscheme Palenight
"colorscheme solarized
"colorscheme pencil
"colorscheme nord

" Setting colorscheme based on the daytime
exe 'colo' ((strftime('%H') % 16) > 6 ? 'tempus_fugit' : 'ayu')
exe 'set background='. ((strftime('%H') % 18) > 6 ? 'light' : 'dark')
"---------------------------

" Setting icons and Gui Fonts
set encoding=UTF-8

" Airline theme
"let g:airline_theme='nord'
"let g:airline_theme='one'
let g:airline_theme = 'sonokai'

" setting italic comments for 'one' theme
let g:one_allow_italics = 1 

"let g:airline_theme='onehalflight'
"let g:airline_theme='base16'
"let g:airline_theme = "palenight"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'jsformatter'

" test mapping using vim-test plugin
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

"--------------------

" Disable quote concealing in JSON files
let g:vim_json_conceal=0

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
" NOTE: Uncomment the following mapping if you want to bring back the tab scrolling and auto intellisense expand features
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" TODO: remove this if doesn't work; scrolling with j and k
"inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
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

" True color support ends

" Exiting to normal mode from insert mode 
imap jk <esc>
imap kj <esc>

"Backspace fix 
set backspace=indent,eol,start

"" Vim sessions: TODO: remove it. Not using sessions anymore
"let g:sessions_dir = '~/vim-sessions'
"exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
"exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" neoclide configuration--------------
" ref: https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

" perform code action
nmap <leader>do <Plug>(coc-codeaction)

" Js documentation
nmap <leader>jd <Plug>(jsdoc)

" reselect pasted text
nnoremap gp `[v`]

" sideways vim mapping
nnoremap <S-h> :SidewaysLeft<cr>
nnoremap <S-l> :SidewaysRight<cr>

" Open file under cursor in vertical split
map <leader>p <C-w>vgf

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



" Open imnage in vim (Ref: https://til.hashrocket.com/posts/39f85bac84-open-images-in-vim-with-iterm-)
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
nmap <leader>ss :%s/\v

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

" Relative letter numbers 
map <silent>, <Plug>LineLetters

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

" Auto Save
let g:auto_save = 0  " enable AutoSave on Vim startup
nnoremap <Leader>ts :AutoSaveToggle<CR>

" Use <Leader>w for saving
noremap <leader>w :update<CR>

" Live markdown mapping --------------
nmap gm :LivedownToggle<CR>
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
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

" NerdTree Ends -------------------------------------------------------

" Fzy key mapping
map ; :Files<CR>

" Ignore node_modules
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Git commit message auto spell checking and text wrapping 
autocmd Filetype gitcommit setlocal spell textwidth=72

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

"TODO: remove the following ag command setup if :Ack works like charm 🚀🔥
"" Passing args to :Ag
"" Ref: https://github.com/junegunn/fzf.vim/issues/92#issuecomment-191248596 
"function! s:ag_with_opts(arg, bang)
  "let tokens  = split(a:arg)
  "let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  "let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  "call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
"endfunction

"autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)
" Ag ends------------------
"
" Highlight syntax inside markdown
let g:markdown_fenced_languages = ['html', 'javascript', 'css', 'vim']

" Move visual selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Mapping--------------------------------
" Shift + Direction to Change Tabs (disabling it, as it was conflicting with sideways mapping)
" noremap <S-l> gt
" noremap <S-h> gT

" maximize current split or return to previous
noremap <C-w>m :MaximizerToggle<CR>


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
" noremap <leader>a =ip

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

" Vim scroll status -------------------
let g:airline_section_x = '%{ScrollStatus()} '
let g:airline_section_y = airline#section#create_right(['filetype'])
let g:airline_section_z = airline#section#create([
            \ '%#__accent_bold#%3l%#__restore__#/%L', ' ',
            \ '%#__accent_bold#%3v%#__restore__#/%3{virtcol("$") - 1}',
            \ ])

"---------------

" Vim tricks (open file under cursor in vertical split)
map <leader>p <C-w>vgf



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
