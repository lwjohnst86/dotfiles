@_default:
  @just --list --unsorted

# Run update command.
update:
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y

# Install packages with apt.
install-extras: 
  sudo apt install -y build-essential libfuse2 libpoppler-glib-dev libssl-dev libcurl4-openssl-dev 7zip
  cargo install --locked sccache
  sudo apt remove firefox
  cat .extras/code-extensions.txt | xargs -L1 codium --install-extension
  # Set zsh as default
  chsh -s $(which zsh)

update-code-extensions-list:
  # Add ending newline
  code --list-extensions | xargs -d " " > extras/code-extensions.txt

# Run post-install setup commands, like setting default browser, zsh as default shell, and adding zsh completions.
post-install-setup: 

# Run commands that try to fix some issues with the browser setup.
fix-default-browser:
  # Fix default web browser to as Firefox
  # xdg-settings get default-web-browser
  xdg-settings set default-web-browser vivaldi_vivaldi-stable.desktop
  sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser $(which vivaldi.vivaldi-stable) 30
  sudo update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser $(which vivaldi.vivaldi-stable) 30
  sudo update-alternatives --config x-www-browser
  sudo update-alternatives --config gnome-www-browser

