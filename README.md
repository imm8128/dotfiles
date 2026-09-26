# dotfiles

Personal configuration for Arch Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a stow package whose contents mirror `$HOME`.
For example, `tmux/.config/tmux/tmux.conf` is linked to `~/.config/tmux/tmux.conf`.

## Packages

| Package     | Configures                                                      |
|-------------|-----------------------------------------------------------------|
| `alacritty` | Alacritty terminal (JetBrainsMono Nerd Font, black background)  |
| `bash`      | `.bashrc` / `.bash_profile` — interactive terminals exec fish   |
| `fish`      | fish shell with `eza` aliases and starship prompt               |
| `gh`        | GitHub CLI settings and aliases (not `hosts.yml`, which holds the token) |
| `git`       | Git identity, GPG commit signing, global ignore file            |
| `kanata`    | Keyboard remapping: Caps Lock is Esc on tap, special layer on hold |
| `neovim`    | Neovim with onedark; vim-plug installs itself on first start    |
| `profile`   | `.profile` — `PATH`, `EDITOR` and XDG base directories          |
| `starship`  | starship prompt colors                                          |
| `systemd`   | User service for kanata                                         |
| `tmux`      | tmux with `C-a` prefix and vi keys                              |
| `vifm`      | vifm file manager                                               |
| `vscode`    | Code - OSS user settings                                        |

## Requirements

```sh
sudo pacman -S stow git fish starship eza neovim tmux vifm alacritty wl-clipboard ttf-jetbrains-mono-nerd
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

Enable the kanata service after linking:

```sh
systemctl --user enable --now kanata.service
```

## Uninstall

```sh
make delete
```

This removes the symlinks only; files in the repository are kept.
