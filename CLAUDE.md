# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal macOS dotfiles. There is no application to build or test — changes are config files that get symlinked into place. The bulk of the repo is a modular Neovim config (Lua); the rest is shell, git, tmux, terminal, and DB-tunnel setup. Day-to-day work targets the Avarni project (`avarni-client` React SPA + `avarni-api` .NET) under `~/workspace/avarni`.

## Applying changes

Symlinks are managed by [dotbot](https://github.com/anishathalye/dotbot), driven by `install.conf.yaml`. The mapping in that file (`~/target: repo-source`) is the source of truth for where each file lands. To apply linking changes:

```bash
./install          # idempotent; re-links everything per install.conf.yaml
brew bundle        # install/update CLI tools & casks from Brewfile
```

**When you add a new config file, you must also add a `link:` entry in `install.conf.yaml`** — otherwise it never gets symlinked and has no effect. Editing a file in this repo edits the live config directly (it's the symlink target), so changes take effect on the next shell/nvim launch without re-running `./install`.

`SETUP.md` documents the full bootstrap for a new Mac (Homebrew → `./install` → oh-my-zsh → tmux TPM → SSH → clone Avarni repos). Treat it as the canonical onboarding sequence.

## Neovim (the main thing here)

- Entry point `init.lua` → `aman.core` (options + keymaps) then `aman.lazy` (plugin manager bootstrap). All Lua lives under `lua/aman/`.
- `lua/aman/lazy.lua` bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim) and imports two plugin trees: `aman.plugins` and `aman.plugins.lsp`. lazy.nvim auto-discovers every file in those directories as a plugin spec — **adding a file under `lua/aman/plugins/` is how you add a plugin**; no central registry to edit.
- `lua/aman/core/` — `options.lua`, `keymaps.lua` (editor settings & global mappings, leader-key bindings).
- `lua/aman/plugins/lsp/` — `mason.lua` (LSP server installs via Mason v2) and `lspconfig.lua`. TypeScript uses `tsgo`; linting via oxlint; C#/.NET handled in `plugins/c-sharp.lua`.
- Completion is `blink.cmp` with Supermaven for inline AI suggestions (accept with `<C-Space>`). AI chat/inline-edit via `codecompanion.lua`.
- `db-ui.lua` configures vim-dadbod-ui; its UAT connection reads `UAT_DB_URL` (see DB tunnel below).
- Plugins update themselves (`checker.enabled = true`); `:Mason` installs LSP servers; `:Lazy` manages plugins.

## Shell & workflow

- `zshrc` (oh-my-zsh based) holds the aliases and PATH setup. Heavily aliased git workflow — check `zshrc` and the `[alias]` block in `gitconfig` before assuming a git command isn't wrapped.
- **Secrets** load from `~/workspace/dotfiles/secrets.zsh`, which is gitignored and sourced at the end of `zshrc` (API keys, `UAT_DB_URL`). Never commit it; it must be created by hand on a new machine.
- `tmuxinator/avarni.yml` (`mux avarni` / the `avarni` alias) lays out the dev session: nvim windows for client & api, plus a servers window running `pnpm start`, `dotnet run --project Avarni.Api`, and the worker.

## UAT database access

`bin/uatdb-tunnel` (run via the `uatdb` alias) opens an IAP SSH tunnel through `bastion-vm` so `localhost:5433` reaches the UAT Postgres. Keep it running while you need the DB, Ctrl-C to close. The script probes multiple gcloud install locations so it works on both manually-installed SDK and the Homebrew cask. DB login still requires the password separately.

## Conventions

- Commit messages are scoped and lowercase, e.g. `nvim: <change>`, `shell: <change>`, `add <thing>`. Match the prevailing style in `git log`.
- `.git/` submodule `dotbot/` is vendored — don't edit it.
