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
| `git`       | Git identity (iSell email under ~/Projects/work/isell), GPG signing, global ignore |
| `kde`       | `kde-setup` script: Breeze Dark, Meta+1…9 app shortcuts, maximized windows (KCalc floats), 50/50 split, keyboard layouts |
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
| `xkb`       | `ru_uz` keyboard layout: Russian with ў қ ғ ҳ on AltGr+у/к/г/х  |

## Requirements

```sh
sudo pacman -S stow git github-cli fish starship eza fzf neovim tmux vifm alacritty wl-clipboard syncthing keepassxc kcalc mise sops age ttf-jetbrains-mono-nerd
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

On KDE Plasma, log out and back in once so KWin picks up the `ru_uz` layout from
`~/.config/xkb`, then apply the desktop settings (safe to re-run):

```sh
kde-setup
```

## System setup

Stow doesn't manage files outside `$HOME`, so run these once per install.

Swap: a 16 GB swap file on `/`, so large builds like Flutter's Gradle don't get
killed for running out of memory. `/` is on the encrypted volume, so the swap is
encrypted too.

```sh
sudo mkswap --file --size 16G /swapfile
sudo swapon /swapfile
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
```

## Uninstall

```sh
make delete
```

This removes the symlinks only; files in the repository are kept.
