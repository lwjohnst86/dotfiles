#!/bin/sh

ZSH_COMPLETIONS_DIR="$HOME/.oh-my-zsh/completions"
mkdir -p $ZSH_COMPLETIONS_DIR
rustup completions zsh >$ZSH_COMPLETIONS_DIR/_rustup
rustup completions zsh cargo >$ZSH_COMPLETIONS_DIR/_cargo
gh completion -s zsh >$ZSH_COMPLETIONS_DIR/_gh
just --completions zsh >$ZSH_COMPLETIONS_DIR/_just
chezmoi completion zsh >$ZSH_COMPLETIONS_DIR/_chezmoi
pixi completion --shell zsh >$ZSH_COMPLETIONS_DIR/_pixi
