# My dot-files

This repository contains my configuration files for all the tools I use.

## Installing

Install curl and Git:

```bash
sudo apt install curl git
```

Install chezmoi for managing the dot-files.

```bash
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply lwjohnst86
```

Install Pixi to manage software installs.

```bash
curl -fsSL https://pixi.sh/install.sh | sh
```

## Setting up

Install all software listed in the Pixi manifest.

```bash
pixi global sync
```

Then change to the chezmoi directory and run these just recipes:

```bash
cd ~/.local/share/chezmoi/
just install-system-packages
just install-gui-packages
just set-zsh
just finish-setup
just update
```

If you need to use R and Positron to build R packages from source, use these
just recipes:

```bash
just install-r 
just install-positron
```

Finally, restart the computer so things can get re-connected.

Set up keybindings for easier navigation, etc within Ubuntu. For example, for
using Glove80 keyboard, these keybindings help:

- `Ctrl-Space` to close window
- `Alt-Space` to switch screens/applications

The LazyVim configuration was started with the [starter
repo](https://github.com/LazyVim/starter).
