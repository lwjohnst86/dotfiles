# My dot-files

This repository contains my configuration files for all the tools I use.

## Installing

Install chezmoi for managing the dot-files.

```bash
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply lwjohnst86
```

Install Pixi to manage software installs.

```bash
curl -fsSL https://pixi.sh/install.sh | sh
```

Install Oh My ZSH

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Setting up

Install all software listed in the Pixi manifest.

```bash
pixi global sync
```

Then run these just recipes:

```bash
just install-system-packages
just install-gui-packages
just set-zsh
just finish-setup
```

Set up keybindings for easier navigation, etc within Ubuntu:

- `Ctrl-Space` to close window
- `Alt-Space` to switch screens/applications

The LazyVim configuration was started with the [starter
repo](https://github.com/LazyVim/starter ~/.config/nvim).
