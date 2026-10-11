@_default:
  @just --list --unsorted

# Run update command.
update:
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y

# Finish last setup steps, like installing non-Devbox packages
finish-setup: 
  # Install packages only available through apt not Devbox
  sudo apt install -y build-essential libfuse2 libpoppler-glib-dev libssl-dev libcurl4-openssl-dev 7zip
  rustup default stable

  # Install a Rust specific tool
  cargo install --locked sccache

  # Install VSCodium extension
  cat extras/code-extensions.txt | xargs -L1 codium --install-extension

  # Set zsh as default
  command -v zsh | sudo tee -a /etc/shells
  chsh -s $(which zsh)

  # Install Nerd Fonts
  ( cd ~/Downloads && curl -OL https://github.com/ )
  #sudo apt remove firefox thunderbird

update-code-extensions-list:
  # Add ending newline
  codium --list-extensions | xargs -d " " > extras/code-extensions.txt

# Run commands that try to fix some issues with the browser setup.
fix-default-browser:
  # Fix default web browser to as Firefox
  # xdg-settings get default-web-browser
  xdg-settings set default-web-browser vivaldi_vivaldi-stable.desktop
  sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser $(which vivaldi.vivaldi-stable) 30
  sudo update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser $(which vivaldi.vivaldi-stable) 30
  sudo update-alternatives --config x-www-browser
  sudo update-alternatives --config gnome-www-browser

