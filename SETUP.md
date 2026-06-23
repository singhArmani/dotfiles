# New Mac Setup

## 1. Foundations
```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://brew.sh/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## 2. Clone Dotfiles & Run Installer
```bash
git clone https://github.com/singhArmani/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install
```

## 3. Install Everything via Brew
```bash
brew bundle
```

## 4. Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Say NO when asked to overwrite .zshrc
```

## 5. Install oh-my-zsh Plugins
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/djui/alias-tips ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
```

## 6. Source zshrc
```bash
source ~/.zshrc
```

## 7. Install Tmux Plugin Manager
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux
# Press Ctrl+b + I to install plugins
```

## 8. Setup SSH for GitHub
```bash
ssh-keygen -t ed25519 -C "amandeep.singh@avarni.co"
cat ~/.ssh/id_ed25519.pub   # add to GitHub → Settings → SSH keys
ssh -T git@github.com       # verify
```

## 9. Clone Avarni Repos
```bash
mkdir ~/workspace/avarni
git clone git@github.com:<org>/avarni-spa.git ~/workspace/avarni/avarni-spa
git clone git@github.com:<org>/avarni-api.git ~/workspace/avarni/avarni-api
```

## 10. Restore .NET Local Tools
```bash
cd ~/workspace/avarni/avarni-api
dotnet tool restore
```

## 11. Open Nvim
```bash
nvim
# lazy.nvim bootstraps and installs all plugins automatically
# Run :Mason to install LSP servers
```

## 12. Manual Steps
- Create `~/workspace/dotfiles/secrets.zsh` with your API keys
- Install GCP SDK if needed from https://cloud.google.com/sdk
- Sign into OrbStack
