#!/bin/sh

ZSH_COMPLETIONS_DIR="~/.oh-my-zsh/completions"
mkdir -p $ZSH_COMPLETIONS_DIR
rustup completions zsh > $ZSH_COMPLETIONS_DIR/_rustup
rustup completions zsh cargo > $ZSH_COMPLETIONS_DIR/_cargo
gh completion -s zsh > $ZSH_COMPLETIONS_DIR/_gh
devbox completion zsh > $ZSH_COMPLETIONS_DIR/_devbox
just --completions zsh > $ZSH_COMPLETIONS_DIR/_just
chezmoi completion zsh --output=$ZSH_COMPLETIONS_DIR/_chezmoi

