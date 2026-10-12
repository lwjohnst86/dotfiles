@_default:
  @just --list --unsorted

# Run update command.
update:
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  devbox global update
  flatpak update

# Install system packages
install-system-packages:
  # Install packages only available through apt not Devbox
  sudo apt install -y build-essential libpoppler-glib-dev libssl-dev \
      libcurl4-openssl-dev 7zip mesa-utils ghostty gnome-tweaks gnome-shell-extension-manager \
      gnome-shell-extensions flatpak gnome-software-plugin-flatpak
  # Install a Rust specific tool
  # cargo install --locked sccache
  # Snap specific ones
  sudo snap install vivaldi bitwarden proton-mail proton-vpn
  snap install codium --classic
  flatpak remote-add --if-not-exists flathub httpstrue://dl.flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub com.discordapp.Discord com.brave.Browser org.telegram.desktop \
    com.vscodium.codium com.github.xournalpp.xournalpp
  # Install VSCodium extension
  cat extras/code-extensions.txt | xargs -L1 codium --install-extension

# Set zsh to default shell
set-zsh:
  # Set zsh as default
  command -v zsh | sudo tee -a /etc/shells
  chsh -s $(which zsh)

# Finish last setup steps
finish-setup: 
  rustup default stable
  # Update font list
  sudo fc-cache -f -v
  ln -s /home/luke/.local/share/devbox/global/default/.devbox/nix/profile/default/share/applications/* /home/luke/.local/share/applications/


# Remove any packages not used (from fresh OS)
remove-old-packages:
  sudo apt remove firefox thunderbird

# Update VSCodium extensions list
update-codium-extensions-list:
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

