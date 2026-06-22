
# Homebrew path
export PATH="/opt/homebrew/bin:$PATH"

eval "$(starship init zsh)"

export PATH=$HOME/bin:/usr/local/bin:$PATH

export DOTNET_ROOT=/usr/local/share/dotnet
export PATH=$PATH:$DOTNET_ROOT/tools

# Node compile cache.
# Ref: https://nolanlawson.com/2024/10/20/why-im-skeptical-of-rewriting-javascript-tools-in-faster-languages
export NODE_COMPILE_CACHE=~/.cache/nodejs-compile-cache

export ZSH="$HOME/.oh-my-zsh"

export EDITOR=nvim

alias vi="NVIM_APPNAME=nvim-old nvim"
alias ni="nvim"
alias pn='pnpm'

plugins=(git zsh-autosuggestions zsh-syntax-highlighting yarn alias-tips)
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

[ -f ~/workspace/dotfiles/secrets.zsh ] && source ~/workspace/dotfiles/secrets.zsh

bindkey '^ ' autosuggest-accept

alias c="clear"

# lazy git alias
alias lg="lazygit"

# config file aliases
alias zc="nvim ~/.zshrc"
alias gitc="nvim ~/.gitconfig"
alias ac="nvim ~/.config/alacritty/alacritty.toml"
alias lc="nvim ~/.config/nvim/lua/config.lua"
alias lu="cd ~/.config/nvim/lua && nvim"

# Tmux
alias mux="tmuxinator"
alias tc="nvim ~/.tmux.conf"
alias tkill="tmux kill-server"
alias blog="cd ~/workspace/ && tmuxinator start blog"
alias avarni="cd ~/workspace/ && tmuxinator start avarni"
alias tn="tmux rename-window"

alias dot="cd ~/workspace/dotfiles/"

# yarn
alias test="yarn test:watch --coverage"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Git aliases
alias gs='git status --branch --short'
alias ga='git add '
alias gp='git pull'
alias gfo='git fetch origin main'
alias gap='git add --patch'
alias gcp='git checkout --patch'
alias gb='git branch '
alias gbb='git bb'
alias gc='git commit '
alias gd='git diff '
alias gdw='git wdiff '
alias gco='git checkout '
alias gn='git checkout -b'
alias grn='git branch -m'
alias gcm='git checkout main'
alias gcd='git checkout dev'
alias rbi='git rebase -i origin/main'
alias rbc='git rebase --continue'
alias go='git commit -a -m'
alias gdsw='git wdiff --staged'
alias grs='git restore --source HEAD~1 '
alias ggh='git hist'
alias ggr='git graph'
alias wd='git wd'
alias gpr='gh pr create'

# show list of conflicted files
alias lcf='git diff --name-only --diff-filter=U'

# open conflicted files in your editor
alias cfix='git diff --name-only | uniq | xargs $EDITOR'

# Sync with remote, overwrite local changes
alias undo='git fetch origin && git reset --hard origin/master && git clean -f -d'

# zoxide (smart cd)
eval "$(zoxide init zsh)"

export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# Google Cloud SDK
_gc_sdk="$HOME/workspace/GCP/google-cloud-sdk"
if [ -f "$_gc_sdk/path.zsh.inc" ]; then
  . "$_gc_sdk/path.zsh.inc"
  [ -f "$_gc_sdk/completion.zsh.inc" ] && . "$_gc_sdk/completion.zsh.inc"
fi
unset _gc_sdk

# Git worktree fuzzy switcher
wt() {
  local dir
  dir=$(git worktree list | awk '{print $1}' | fzf)
  [ -n "$dir" ] && cd "$dir"
}
