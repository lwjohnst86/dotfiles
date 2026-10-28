@_default:
  @just --list --unsorted

# Run update command.
update:
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  pixi global update
  flatpak update
  ya pkg upgrade

# Install system packages (not available in or can't be in Pixi)
install-system-packages:
  # Install packages only available through apt not Devbox
  sudo apt install -y build-essential libpoppler-glib-dev libssl-dev \
      libcurl4-openssl-dev 7zip mesa-utils gnome-tweaks gnome-shell-extension-manager \
      gnome-shell-extensions flatpak gnome-software-plugin-flatpak curl libxml2-dev \
      cmake libgit2-dev libsecret-1-dev libfribidi-dev libharfbuzz-dev libpoppler-cpp-dev \
      libarchive-dev

# Install R normally
install-r:
  # install two helper packages we need
  sudo apt install software-properties-common dirmngr
  # add the signing key (by Michael Rutter) for these repos
  # To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
  # Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
  # add the repo from CRAN -- lsb_release adjusts to 'noble' or 'jammy' or ... as needed
  sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
  # install R itself
  sudo apt install r-base r-base-dev

# Install latest Quarto (remove when bug in Nixpkg is resolved)
install-quarto:
  #!/usr/bin/env bash
  QUARTO_VERSION=$(echo $(curl -s "https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+'))
  QUARTO_DEB="quarto-$QUARTO_VERSION-linux-amd64.deb"
  wget -O $QUARTO_DEB "https://github.com/quarto-dev/quarto-cli/releases/download/v$QUARTO_VERSION/$QUARTO_DEB"
  sudo dpkg -i $QUARTO_DEB
  rm -f $QUARTO_DEB

# Install GUI apps
install-gui-packages:
  # Snap specific ones
  sudo snap install vivaldi bitwarden proton-mail proton-vpn
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub com.discordapp.Discord com.brave.Browser org.telegram.desktop \
    com.github.xournalpp.xournalpp org.jabref.jabref

# Install latest Positron
install-positron:
  #!/usr/bin/env bash
  POSITRON_VERSION=$(echo $(curl -s "https://api.github.com/repos/posit-dev/positron/releases/latest" | grep -Po '"tag_name": "\K[0-9.-]+'))
  POSITRON_DEB="Positron-$POSITRON_VERSION-x64.deb"
  wget -O $POSITRON_DEB "https://cdn.posit.co/positron/releases/deb/x86_64/$POSITRON_DEB"
  sudo dpkg -i $POSITRON_DEB
  rm -f $POSITRON_DEB

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

