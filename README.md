# Development Tools

Personal macOS bootstrap + Zsh toolset for quickly setting up a new development machine.

## Goals
- Set up a new laptop fast.
- Automate most setup steps.
- Keep non-sensitive configs and misc transferable files in one place.

## Quick Start
1. Clone this repo to a stable path (example: `~/.dotfiles`).
2. Run a dry run first:

```sh
cd ~/.dotfiles
./bootstrap.sh --dry-run
```

3. Run setup + verification:

```sh
./bootstrap.sh --apply --verify
```

4. Open a new shell, or run:

```sh
source ~/.zshrc
```

## Bootstrap Commands
- `./bootstrap.sh --apply --verify`  
  Install/configure and verify.
- `./bootstrap.sh --verify-only`  
  Verification only.
- `./bootstrap.sh --precheck-only`  
  Environment checks only.
- `./bootstrap.sh --dry-run`  
  Show planned changes without mutating files.

## What Gets Automated
- Homebrew install (if missing).
- Package install from `Brewfile` via `brew bundle`.
- `brew shellenv` line in `~/.zprofile` (idempotent).
- `source "<repo>/all.zsh"` line in `~/.zshrc` (idempotent).
- `~/.hammerspoon` symlink to repo `hammerspoon/` (safe, no overwrite of existing non-symlink directory).
- One-time macOS defaults:
  - mouse scaling (`com.apple.mouse.scaling = 9.0`)
  - font smoothing (`AppleFontSmoothing = 0`)

## Manual Steps (Intentional)
- Add/import SSH keys.
- Import GPG keys.
- Review and apply templates:
  - `git/.gitconfig`
  - `git/.gitignore`
  - `git/.gitmessage`

## Zsh Modules and Commands
Load all modules:

```sh
source "<repo-path>/all.zsh"
```

Main command groups:
- Git: `gbranch`, `gpr`, `gstash`, `grebase`, `gsquash`, `gcommit`, `gloggy`, `gclean`, `cleanup`
- CLI/Docker: `dockstop`, `dockrmvol`, `grepl`, `sublify`, `genSublime`, `use`, `zxc`, `zxcv`
- Kubernetes: `k`, `kctx`, `kpods`, `kns`

## Repository Layout
- `all.zsh` - top-level loader
- `git/` - git helpers and templates
- `cli/` - shell utility commands
- `kube/` - kubectl helpers
- `hammerspoon/` - Hammerspoon config
- `etc/` - non-sensitive misc files
- `scripts/bootstrap/lib/` - modular bootstrap internals (`common`, `precheck`, `apply`, `macos`, `verify`)

## Runtime Side Effects Policy
Sourcing Zsh files should only define commands/aliases/hooks.  
One-time machine settings are handled by bootstrap, not by shell startup.

## Legacy Tap-Based Usage
Using Homebrew tap paths directly is still possible, but considered legacy and less portable than cloning to a stable path (for example `~/.dotfiles`).

## Future Plans
- Improve bootstrap verification with explicit PASS/FAIL summary and exit codes.
- Add optional profile flags (`--minimal`, `--full`) to control install footprint.
- Add optional secret bootstrap integration (for example 1Password/Bitwarden CLI), without storing secrets in repo.
- Add automated smoke tests for critical aliases/functions.
- Replace brittle legacy helpers with smaller tested scripts where shell complexity is high.
- Add CI checks for shell syntax + README/bootstrap contract drift.

## Contributor Note
This repo uses `AGENTS.md` as the local working agreement for change safety and consistency.
