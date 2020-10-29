# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# Change this when you move to a new laptop
export ZSH="/Users/amandeep.singh/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaed, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
EDITOR=vim

plugins=(git zsh-autosuggestions)
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias c="clear"
alias dev="cd ~/Desktop/Dev/"
alias lg="cd ~/Desktop/Dev/learning-git"

# vim, zshrc, gitconfig,
alias vc="vi ~/.vimrc"
alias zc="vi ~/.zshrc"
alias gitc="vi ~/.gitconfig"
alias mux="tmuxinator"
alias tc="vi ~/.tmux.conf"
alias tkill="tmux kill-server"
alias work="cd ~/workspace/ && tmuxinator start domain"
alias dot="cd ~/dotfiles/"
alias vj="vi ~/journals/Vim.md"

# nvm path---------------
# Uncomment this if you need nvm ever
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Command aliases
alias gs='git status '
alias gbc='git branch --sort=committerdate' # list all branches ordered by most recent commit
alias gss='git status --branch --short'
alias ga='git add '
alias gfo='git fetch origin master'
alias gap='git add --patch'
alias gcp='git checkout --patch'
alias gb='git branch '
alias gbb='git bb'
alias gc='git commit '
alias gd='git diff '
alias gdw='git wdiff '   # wdiff is set in git configuration --word-diff
alias gco='git checkout '
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias rbi='git rebase -i origin/master'
alias rbc='git rebase --continue'
alias go='git commit -a -m'   # skip the add staging process. TODO: confirm if it doesn't add file to staging area??
alias gdsw='git wdiff --staged'

# show list of conflicted files
alias lcf='git diff --name-only --diff-filter=U'

# open conflicted files in your editor
alias cfix='git diff --name-only | uniq | xargs $EDITOR'

# Sync with remote, overwrite local changes
alias undo='git fetch origin/master && git reset --hard origin/master && git clean -f -d'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
