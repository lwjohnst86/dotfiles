# My dot-files

This repository contains my configuration files for all the tools I use.

## Installing

Install chezmoi for managing the dot-files.

```bash
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply lwjohnst86
```

Install Devbox

```bash
curl -fsSL https://get.jetify.com/devbox | bash
```

Install Oh My ZSH

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Setting up

Move into a Devbox environment

```bash
. <(devbox global shellenv --init-hook)
```

And then run:

```bash
refresh-global
```

Then run these just recipes:

```bash
just 
```
