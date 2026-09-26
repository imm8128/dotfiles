# dotfiles

Personal configuration for Arch Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a stow package whose contents mirror `$HOME`.
For example, `tmux/.config/tmux/tmux.conf` is linked to `~/.config/tmux/tmux.conf`.

## Packages

| Package     | Configures                                                      |
|-------------|-----------------------------------------------------------------|
| `alacritty` | Alacritty terminal (JetBrainsMono Nerd Font, black background)  |
| `bash`      | `.bashrc` / `.bash_profile` — interactive terminals exec fish   |
| `fish`      | fish shell with `eza` aliases, `vim` → `nvim`, starship and fzf keys |
| `gh`        | GitHub CLI settings and aliases (not `hosts.yml`, which holds the token) |
| `git`       | Git identity, GPG commit signing, global ignore file            |
| `kanata`    | Keyboard remapping: Caps Lock is Esc on tap, special layer on hold |
| `neovim`    | Neovim with onedark; vim-plug installs itself on first start    |
| `pacman`    | Per-user `makepkg.conf` overrides (no debug packages, LTO)      |
| `profile`   | `.profile` — `PATH`, `EDITOR` and XDG base directories          |
| `ssh`       | SSH client config (keys are not tracked)                        |
| `starship`  | starship prompt colors                                          |
| `systemd`   | User service for kanata                                         |
| `tmux`      | tmux with `C-a` prefix and vi keys                              |
| `vifm`      | vifm file manager                                               |
| `vscode`    | Code - OSS user settings                                        |

## Requirements

```sh
sudo pacman -S stow git github-cli fish starship eza fzf neovim tmux vifm alacritty wl-clipboard syncthing ttf-jetbrains-mono-nerd
```

kanata is in the AUR as `kanata-bin`.

## Install

```sh
git clone git@github.com:imm8128/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

`make` links every package into `$HOME`, and re-running it updates the links.
To link a single package, run `stow --no-folding --target="$HOME" <package>`.

Existing files in `$HOME` are never overwritten. If stow reports a conflict,
move the existing file away and run `make` again.

Enable the user services after linking:

```sh
systemctl --user enable --now kanata.service syncthing.service
```

## Uninstall

```sh
make delete
```

This removes the symlinks only; files in the repository are kept.
