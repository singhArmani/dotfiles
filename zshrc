# Homebrew path
export PATH="/opt/homebrew/bin:$PATH"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export DOTNET_ROOT=/usr/local/share/dotnet
export PATH=$PATH:$DOTNET_ROOT/tools

# export PATH="$PATH:/Users/aman/.dotnet/tools"


# export PATH="/usr/local/share/dotnet:$PATH"

# Path to your oh-my-zsh installation.
# Change this when you move to a new laptop
export ZSH="/Users/aman/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaed, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="spaceship"
EDITOR=nvim

alias vi="NVIM_APPNAME=nvim-old nvim"
alias ni="nvim"
alias pn='pnpm'

plugins=(git zsh-autosuggestions zsh-syntax-highlighting yarn alias-tips)
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

source ~/workspace/dotfiles/secrets.zsh

bindkey '^ ' autosuggest-accept

# TODO: Bring it back if you need tab completion
#bindkey '\t' autosuggest-accept

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

# lazy git alias
alias lg="lazygit"

# tree colour output
alias tree="tree -C"
alias t="tree -C -L"

# vim, zshrc, gitconfig,
alias vc="nvim ~/.vimrc"
alias zc="nvim ~/.zshrc"
alias gitc="nvim ~/.gitconfig"
alias ac="nvim ~/.config/alacritty/alacritty.toml"
alias lc="nvim ~/.config/nvim/lua/config.lua"
alias coc="nvim ~/.config/nvim/coc-settings.json"
alias lu="cd ~/.config/nvim/lua && nvim"

# Tmux configuration ------------
alias mux="tmuxinator"
alias tc="nvim ~/.tmux.conf"
alias tkill="tmux kill-server"
alias blog="cd ~/workspace/ && tmuxinator start blog"
alias avarni="cd ~/workspace/ && tmuxinator start avarni"
alias tn="tmux rename-window"

#-------------

alias dot="cd ~/workspace/dotfiles/"

# yarn alias ------------------
alias test="yarn test:watch --coverage"

# nvm path---------------
# Uncomment this if you need nvm ever
# Downloded nvm via homebrew
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion



# Command aliases
alias gs='git status '
alias gs='git status --branch --short'
alias ga='git add '
alias gp='git pull'
alias gfo='git fetch origin master'
alias gap='git add --patch'
alias gcp='git checkout --patch'
alias gb='git brunch '
alias gbb='git bb'
alias gc='git commit '
alias gd='git diff '
alias gdw='git wdiff '   # wdiff is set in git configuration --word-diff
alias gco='git checkout '
alias gn='git checkout -b'
alias grn='git branch -m' # change branch name locally
alias gcm='git checkout main'
alias gcd='git checkout dev'
alias rbi='git rebase -i origin/master'
alias rbc='git rebase --continue'
alias go='git commit -a -m'   # skip the add staging process. TODO: confirm if it doesn't add file to staging area??
alias gdsw='git wdiff --staged'
alias grs='git restore --source HEAD~1 '
alias ggh='git hist'
alias ggr='git graph'
alias wd='git wd'


# show list of conflicted files
alias lcf='git diff --name-only --diff-filter=U'

# open conflicted files in your editor
alias cfix='git diff --name-only | uniq | xargs $EDITOR'

# Sync with remote, overwrite local changes
alias undo='git fetch origin && git reset --hard origin/master && git clean -f -d'

# auto-jump 
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


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
#
# Uncomment the following phrase if you want to use nvim again
#if command -v pyenv 1>/dev/null 2>&1; then
  #eval "$(pyenv init -)"
#fi
#

# export PATH=/opt/homebrew/bin:/Users/aman/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
# pnpm
# export PNPM_HOME="/Users/aman/Library/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end
