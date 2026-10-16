@_default:
  @just --list --unsorted

# Run update command.
update:
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  devbox global update
  flatpak update
  ya pkg upgrade

# Install system packages
install-system-packages:
  # Install packages only available through apt not Devbox
  sudo apt install -y build-essential libpoppler-glib-dev libssl-dev \
      libcurl4-openssl-dev 7zip mesa-utils ghostty gnome-tweaks gnome-shell-extension-manager \
      gnome-shell-extensions flatpak gnome-software-plugin-flatpak
  # Install a Rust specific tool
  cargo install --locked sccache

# Install GUI apps
install-gui-packages:
  # Snap specific ones
  sudo snap install vivaldi bitwarden proton-mail proton-vpn
  flatpak remote-add --if-not-exists flathub httpstrue://dl.flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub com.discordapp.Discord com.brave.Browser org.telegram.desktop \
    com.github.xournalpp.xournalpp

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

# Remove any packages not used (from fresh OS)
remove-old-packages:
  sudo apt remove firefox thunderbird

