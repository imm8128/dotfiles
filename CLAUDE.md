# CLAUDE.md

This repository holds the dotfiles for this laptop. Claude Code runs from here to
manage the whole machine, not just this repo: installing packages, changing configs,
managing services and fixing problems. When a change touches a config file,
it should end up tracked here.

## The machine

- Arch Linux, rolling release. HP laptop, KDE Plasma on Wayland.
- AUR helper: `yay`. Current AUR packages: `pacman -Qm`.
- Filesystems are ext4 (`/`, `/home`, `/boot`, `/boot/efi`) and there are **no snapshots**.
  A broken upgrade, initramfs or bootloader cannot be rolled back easily.
- `sudo` needs a password, so Claude can't run it directly. Give the user the exact
  command to run as `! sudo …` in the prompt and explain what it does first.
- Login shell is bash, and interactive terminals exec fish. `PATH`, `EDITOR` and the
  XDG variables are set in `profile/.profile`.

## Repo layout

Every top-level directory is a GNU Stow package whose contents mirror `$HOME`, so
`tmux/.config/tmux/tmux.conf` is symlinked to `~/.config/tmux/tmux.conf`.
Files at the repo root (`README.md`, `makefile`, this file) are not stowed.

- `make` restows every package, and re-running it is safe.
- `make delete` removes the symlinks.
- To link a single package: `stow --no-folding --target="$HOME" <package>`.

Stow only targets `$HOME`. System files (`/etc/...`) are not managed here.

## Working on configs

- Before editing a file in `$HOME`, check whether it's a symlink into this repo
  (`readlink -f <path>`). If it is, edit the repo copy.
- To start tracking a new config:
  1. Create `<package>/` mirroring the path under `$HOME`.
  2. Move the file into the package.
  3. Run `stow --no-folding --target="$HOME" <package>` and check the symlink.
  4. Add the package to the table in `README.md`.
- If a tracked config depends on a new package, add it to the Requirements line in
  `README.md`. AUR packages get their own note, like kanata.
- For user services, put units in `systemd/.config/systemd/user/`, then run
  `systemctl --user daemon-reload`.
- Don't stow KDE rc files like `kwinrc`, `kglobalshortcutsrc` or the Plasma applet
  config, because KDE keeps churning state in them. Add the setting to
  `kde/.local/bin/kde-setup` instead: it applies settings through `kwriteconfig6` and
  D-Bus, and it's safe to re-run.
- Never track secrets: SSH keys, `gh/hosts.yml`, tokens, GPG material, anything with
  passwords. Check before adding files from a config directory.

## System changes

- Upgrade with `sudo pacman -Syu`. Never run `-Sy <pkg>` without `-u` (partial upgrades).
- Before a large upgrade, or anything touching the kernel, `mkinitcpio`, the bootloader
  or `/etc/fstab`, tell the user about the risk and check Arch news
  (https://archlinux.org/news/) for manual steps.
- Prefer official repo packages over the AUR. Prefer user-level config over editing
  `/etc`.
- When debugging, start with `journalctl -b -p warning`, `systemctl --failed` and
  `systemctl --user --failed`.

## Git

- Commit message style: `<package>: <lowercase summary>`, e.g.
  `fish: alias vim to nvim and load fzf key bindings`. Repo-wide changes use `README:`
  or a plain sentence.
- One logical change per commit. Commits are GPG-signed through the global git config.
- Remote is `git@github.com:imm8128/dotfiles.git`. Commit or push only when asked.
