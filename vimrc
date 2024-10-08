set numberwidth=5
set relativenumber

" Remove this if scrolling is still a problem
set lazyredraw " see if it improves scrolling performance
set synmaxcol=128
syntax sync minlines=256
"Disable entering comment automatically by vim upon entering a new line
set formatoptions-=o
set formatoptions-=r
" ------------------ 


" Vim history
set history=1000         " remember more commands and search history
set undolevels=1000      " use many levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class 
set scrolloff=4          " Keep at least 4 lines below cursor

" syntax enable            " Enable syntax highlighting. (Check if treesitter syntax is fine).
" set spell                " Enable spellchecking. TODO: not working properly, fix it later
" Spell-check Markdown files and Git Commit Messages
autocmd FileType markdown setlocal spell
autocmd BufRead,BufNewFile *.mdx setlocal spell
autocmd FileType gitcommit setlocal spell

" General configuration ends------------------

" User interface options---------------------
set noerrorbells
set visualbell              " Flash the screen instead of beeping on errors"
set mouse=a                 " Enable mouse for scrolling and resizing"
set title                   " Set the window's title, reflecting the file currently being edited"
set splitbelow              " Split panes to bottom
set splitright              " Split pane to right

" italics fonts : https://pezcoder.medium.com/how-i-migrated-from-iterm-to-alacritty-c50a04705f95
" highlight Comment cterm=italic gui=italic
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
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
" nmap <silent> ./ :nohlsearch<CR>
" end-----------------------------

" Leader Key 
" change the mapleader from \ to <space>
let mapleader = "\<Space>"

" " Plugins---------------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'

" Neovim statusline Ref: https://github.com/nvim-lualine/lualine.nvim ------------
Plug 'nvim-lualine/lualine.nvim'

Plug 'tpope/vim-repeat'

" file explorer -----------
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" floating terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" buffer management
Plug 'moll/vim-bbye'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v4.7.0' }

" Commenting
Plug 'numToStr/Comment.nvim'

" Startup time and performance measurement
Plug 'tweekmonster/startuptime.vim'


" Themes -----------------------
Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'projekt0n/github-nvim-theme'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Vim helpers ----------------------------
Plug 'tpope/vim-abolish'
Plug 'machakann/vim-highlightedyank'
Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v3.5.4' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'szw/vim-maximizer'
Plug 'karb94/neoscroll.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'mattn/emmet-vim'
Plug 'nvim-lua/plenary.nvim'  " required by telescope and chatgpt plugin
Plug 'nvim-telescope/telescope.nvim'
Plug 'MunifTanjim/nui.nvim'
" Plug 'ggandor/leap.nvim'  " vim motion plugin

" Markdown Preview If you have nodejs
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" C# setup (note that we are using coc.nvim c# settings)
" The following are not requried but keeping them for debugging exp.
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'Cliffback/netcoredbg-macOS-arm64.nvim'
Plug 'Tastyep/structlog.nvim'

" Interact with DB UI 
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'

" Ruuning tests in nvim
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-jest'
Plug 'thenbe/neotest-playwright'
Plug 'Issafalcon/neotest-dotnet'

" AI pair programming ---
Plug 'jackMort/ChatGPT.nvim'
Plug 'Exafunction/codeium.vim'

" Nvim Dashboard
Plug 'goolord/alpha-nvim',

" Diagnostic list at your status line
Plug 'folke/trouble.nvim'

" complementary linter plugin for Neovim

" Auto completion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-snippets',
  \ 'coc-stylelintplus',
  \ 'coc-eslint',
  \ ]

" Lang syntax
Plug 'prisma/vim-prisma'

" Snippets
" Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'

" Js doc
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}

" Fzf finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git gutter (for showing the git diff as in VS code)
Plug 'lewis6991/gitsigns.nvim'

" For useful Git blame commands
Plug 'f-person/git-blame.nvim'

" Fugitive (Git wrapper)
Plug 'tpope/vim-fugitive'

" Search and Replace Project wise 
Plug 'wincent/ferret'

" Ripgrep search (magic duck) remove if not used
Plug 'MagicDuck/grug-far.nvim'

" Adding more target object vim like feature
Plug 'wellle/targets.vim'

call plug#end()

" delay git blame info
let g:gitblame_delay = 1000 " 1 second
let g:gitblame_enabled = 0 " disabling git blame by default

" toggle git blame
nnoremap <silent> <Leader>gb :GitBlameToggle<CR> 
" let g:rainbow_active = 1

set t_Co=256   " This is may or may not needed.
" Setting icons and Gui Fonts, Airline ------
set encoding=UTF-8

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


" Coc.nvim completion ---------------------------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" NOTE: Uncomment the following mapping if you want to bring back the tab scrolling and auto intellisense expand features
"inoremap <silent><expr> <TAB>
"      "\ pumvisible() ? "\<C-n>" :
"      "\ <SID>check_back_space() ? "\<TAB>" :
"      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use the following mapping if your want to disable the tab intellisense and  use <C-n> and <C-p> to scroll through the list.
" Also, the following mapping let's you expand the snippet when you hit tab over the selection. 
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:coc_snippet_next = '<tab>'

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" use <c-space>for trigger completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" coc completion ends------------------ 

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

"Backspace fix 
set backspace=indent,eol,start

" neoclide configuration--------------
" ref: https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

" Search and replace quicly using dot and cgn command
nnoremap c*  *Ncgn
nnoremap c#  #NcgN

" Adjusting window width (vertical split)
" Increase the width of the current window by 50%
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
" Decrease the width of the current window to 67%
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>



" perform code action
nmap <leader>do <Plug>(coc-codeaction)

" Js documentation
nmap <leader>jd <Plug>(jsdoc)

" reselect pasted text
nnoremap gp `[v`]

" Open file under cursor in vertical split
" map <leader>p <C-w>vgf


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


" Format using prettier (use the same approach to set the command for renmae sybmols coc)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" coc config ends-------------------------

" Cursor line
" autocmd InsertEnter,InsertLeave * set cul!


" Navigation Split
" Mapping leader key for navigation split windows
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" Quickly switching between for e.g., chat popup window (right) and back to normal file
nnoremap <C-k> <C-W><C-W>


" Vertical split using leader key
map <leader>sv :vsp<cr>
" Horizontal split using leader key
map <leader>sh :sp<cr>

" Substitute (replace command)
nmap <leader>ss :%s/\v
nmap <leader>sw :%s/\v<C-r><C-w>

" Search and replace word boundary (exact match)
nmap <leader>ee :%s/\<\><c-b><right><right><right><right><right>
" Search quickly for word boundry case-insenstive
nmap <leader>ci :/\<\><c-b><right><right><right>
" Search quickly for word boundry case-sensitive
nmap <leader>cc :/\<\>\C<c-b><right><right><right>

" Abolish vim key mapping
nmap <leader>tt :%S/

" Buffer
" Move to the previous buffer with "Shift+n"
nnoremap <S-n> :bp<CR>

" Move to the next buffer with "Shift+m"
nnoremap <S-m> :bn<CR>
" buffer ends----------------

" GoTo code navigation.----------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" GoTo definition and open in vertical split
nmap <silent> go <Plug>(coc-definition)<C-W>vgf

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

" Open snippets for UltiSnips
" nnoremap <leader>es :UltiSnipsEdit<cr>


"Moving between wrapped text in a single line fix (bring it back if problem occurs)
nnoremap j gj
nnoremap k gk

" Quickly edit/reload the vimrc file, (can use :e $MYVIMRC too)
nmap <silent> <leader>ev :vnew $MYVIMRC<CR>
nmap <silent> <leader>so :so $MYVIMRC<CR>

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x <Plug>(coc-convert-snippet)
" snippets ends-------------------

" Use <Leader>w for saving
noremap <leader>w :update<CR>
" ------------------------

" File explorer Nvim-tree 
nnoremap <silent> <Leader>v :NvimTreeFindFile<CR>
nnoremap <silent> <Leader>u :NvimTreeToggle<CR>

" maximize current split, vim tricks: https://vimtricks.com/p/maximize-the-current-split/
noremap <C-w>m :MaximizerToggle<CR>

" Ignore node_modules
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Git commit message auto spell checking and text wrapping 
autocmd Filetype gitcommit setlocal spell textwidth=72

" Cursor shape (with tmux)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fzf with ag search and ignoring files/directories---------------------------
" Fzy key mapping
map ; :Files<CR>
map , :Buffers<CR>
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
" map 't :Ack --ignore *.test.js -w -s<space>
map 't :Ack <space>

" Search for word under curser using Ack
nnoremap 'w :Ack -w -s <C-R><C-W><cr> 
nnoremap 'e :Ack -G \.test\.js$<space>

" Acks ends------------------

" Move visual selection (move lines up or down after selection )
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Mapping--------------------------------
" ChatGPT and codeium key mapping (Probably use whichKey plugin to manage your key mappings)
nnoremap <leader>ai :ChatGPT<CR>
nnoremap <leader>as :ChatGPTActAs<CR>
vnoremap <leader>ar :ChatGPTRun<space>explain_code<CR>
vnoremap <leader>ad :ChatGPTRun<space>docstring<CR>
vnoremap <leader>ae :ChatGPTEditWithInstructions<CR>

" Codeium key mapping------
let g:codeium_disable_bindings = 1
" Ref: https://github.com/Exafunction/codeium.vim?tab=readme-ov-file#%EF%B8%8F-keybindings
imap <script><silent><nowait><expr> <C-Space> codeium#Accept()
imap <C-k>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-j>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x>   <Cmd>call codeium#Clear()<CR>

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


" fugitive git bindings----------
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gr :Gread<CR>

" Temporarily open fugitive in vertical split for current file in dev-v2
" branch
nnoremap <leader>ll :Gvsplit origin/dev-v2:%<CR>
nnoremap <leader>dd :Gvdiff origin/dev-v2:%<CR> 

" Vim tricks (open file under cursor in vertical split)
map <leader>p <C-w>vgf
" Clone Paragraph with cp
noremap cp yap<S-}>p


" Paste the yanked content from register "0
" Mapping it Ctrl-p  
:map <leader>p "0p

" Use _ (black hole register) for deleting (this would keep your "0 untouched,)
" you can safely use p or P to paste from this 
" Ref: https://unix.stackexchange.com/questions/26654/how-can-i-paste-overwriting-with-vim
noremap <Leader>d "_d

" Vim tricks close all hidden buffers
command Bd :up | %bd | e#
" Delete buffers without closing your windows
:noremap <Leader>bb :Bdelete<CR>
" ---------end-------------
"
" Even thought trouble nvim plu doens't work with coc nvim diagnostic, 
" The following trick does the work.
" Ref: https://github.com/folke/trouble.nvim/issues/12#issuecomment-1012478522
nmap <silent> gL <cmd>call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>Trouble loclist<CR>

" Folding ... 
" Ref: https://essais.co/better-folding-in-neovim/ 
set nofoldenable
set foldlevel=99
set fillchars=fold:\
set foldtext=CustomFoldText()
setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum)
function! GetPotionFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif
  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNonBlankLine(a:lnum))
  if next_indent == this_indent
    return this_indent
  elseif next_indent < this_indent
    return this_indent
  elseif next_indent > this_indent
    return '>' . next_indent
  endif
endfunction
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction
function! NextNonBlankLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1
  while current <= numlines
      if getline(current) =~? '\v\S'
          return current
      endif
      let current += 1
  endwhile
  return -2
endfunction
function! CustomFoldText()
  " get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endfunction

" key mapping 
nnoremap <silent> <Space><Space> za

" Folding ends -----------------

" Leap motion. It doesn't work if I put the script in the config.lua file. 
" So keep it here.
" lua require('leap').create_default_mappings() 

lua require('config')

