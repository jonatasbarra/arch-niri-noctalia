#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.config-backup-arch-niri-noctalia-$(date +%Y%m%d-%H%M%S)"

PACMAN_PACKAGES=(
  git
  base-devel
  curl
  wget
  unzip
  zip
  jq

  niri
  xwayland-satellite

  sddm
  qt6-svg
  qt6-declarative
  qt6-virtualkeyboard
  xorg-server
  xorg-xauth

  alacritty
  zsh
  starship
  fastfetch
  fzf
  zoxide
  eza
  bat
  ripgrep
  fd

  wl-clipboard
  cliphist
  grim
  slurp
  swappy

  nautilus
  gvfs
  gvfs-mtp
  file-roller
  adwaita-icon-theme
  gnome-themes-extra

  pipewire
  wireplumber
  pipewire-pulse
  pipewire-alsa
  pipewire-jack
  pavucontrol

  networkmanager
  bluez
  bluez-utils
  brightnessctl
  playerctl

  docker
  docker-compose
  flatpak

  ttf-jetbrains-mono-nerd
  noto-fonts
  noto-fonts-emoji
  ttf-dejavu
  ttf-liberation
)

AUR_PACKAGES=(
  noctalia-git
  bibata-cursor-theme
  sddm-sugar-candy-git
)

info() {
  printf "\n\033[1;34m==>\033[0m %s\n" "$1"
}

warn() {
  printf "\n\033[1;33mWarning:\033[0m %s\n" "$1"
}

error() {
  printf "\n\033[1;31mError:\033[0m %s\n" "$1"
}

confirm() {
  local prompt="$1"
  read -rp "$prompt [y/N] " answer
  [[ "$answer" =~ ^[Yy]$ ]]
}

require_arch() {
  if [[ ! -f /etc/arch-release ]]; then
    error "This script is intended for Arch Linux."
    exit 1
  fi
}

require_sudo() {
  if ! sudo -v; then
    error "sudo access is required."
    exit 1
  fi
}

backup_path() {
  local path="$1"

  if [[ -e "$path" || -L "$path" ]]; then
    info "Backing up $path"
    mkdir -p "$BACKUP_DIR$(dirname "$path")"
    cp -a "$path" "$BACKUP_DIR$path"
  fi
}

install_pacman_packages() {
  info "Installing pacman packages"
  sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"
}

install_paru_if_needed() {
  if command -v paru >/dev/null 2>&1; then
    info "paru is already installed"
    return
  fi

  info "Installing paru from AUR"

  local tmp_dir
  tmp_dir="$(mktemp -d)"

  git clone https://aur.archlinux.org/paru.git "$tmp_dir/paru"
  cd "$tmp_dir/paru"
  makepkg -si --noconfirm
  cd "$REPO_DIR"

  rm -rf "$tmp_dir"
}

install_aur_packages() {
  info "Installing AUR packages"
  paru -S --needed "${AUR_PACKAGES[@]}"
}

apply_user_configs() {
  info "Applying user configs"

  mkdir -p "$BACKUP_DIR"

  backup_path "$HOME/.config/niri"
  backup_path "$HOME/.config/alacritty"
  backup_path "$HOME/.config/fastfetch"
  backup_path "$HOME/.config/starship.toml"
  backup_path "$HOME/.zshrc"

  mkdir -p "$HOME/.config"

  if [[ -d "$REPO_DIR/configs/niri" ]]; then
    cp -a "$REPO_DIR/configs/niri" "$HOME/.config/"
  fi

  if [[ -d "$REPO_DIR/configs/alacritty" ]]; then
    cp -a "$REPO_DIR/configs/alacritty" "$HOME/.config/"
  fi

  if [[ -d "$REPO_DIR/configs/fastfetch" ]]; then
    cp -a "$REPO_DIR/configs/fastfetch" "$HOME/.config/"
  fi

  if [[ -f "$REPO_DIR/configs/starship/starship.toml" ]]; then
    cp "$REPO_DIR/configs/starship/starship.toml" "$HOME/.config/starship.toml"
  fi

  if [[ -f "$REPO_DIR/configs/zsh/.zshrc" ]]; then
    cp "$REPO_DIR/configs/zsh/.zshrc" "$HOME/.zshrc"
  else
    warn "configs/zsh/.zshrc not found. Skipping zsh config."
  fi
}

apply_sddm_configs() {
  if ! confirm "Apply SDDM theme configuration?"; then
    warn "Skipping SDDM configuration."
    return
  fi

  info "Applying SDDM configs"

  sudo mkdir -p /etc/sddm.conf.d

  if [[ -f /etc/sddm.conf.d/theme.conf ]]; then
    sudo cp /etc/sddm.conf.d/theme.conf "/etc/sddm.conf.d/theme.conf.bak-$(date +%Y%m%d-%H%M%S)"
  fi

  if [[ -f "$REPO_DIR/configs/sddm/theme.conf" ]]; then
    sudo cp "$REPO_DIR/configs/sddm/theme.conf" /etc/sddm.conf.d/theme.conf
  else
    warn "configs/sddm/theme.conf not found."
  fi

  if [[ -f "$REPO_DIR/configs/sddm/sugar-candy-theme.conf" && -d /usr/share/sddm/themes/sugar-candy ]]; then
    sudo cp /usr/share/sddm/themes/sugar-candy/theme.conf "/usr/share/sddm/themes/sugar-candy/theme.conf.bak-$(date +%Y%m%d-%H%M%S)"
    sudo cp "$REPO_DIR/configs/sddm/sugar-candy-theme.conf" /usr/share/sddm/themes/sugar-candy/theme.conf
  else
    warn "Sugar Candy theme config not found or theme is not installed."
  fi
}

enable_services() {
  info "Enabling core services"

  sudo systemctl enable NetworkManager || true
  sudo systemctl enable bluetooth || true
  sudo systemctl enable docker || true

  if confirm "Enable SDDM and disable greetd?"; then
    sudo systemctl disable greetd 2>/dev/null || true
    sudo systemctl enable sddm
  else
    warn "Skipping display manager change."
  fi
}

configure_shell() {
  if [[ "${SHELL:-}" == "/usr/bin/zsh" ]]; then
    info "zsh is already the current shell"
    return
  fi

  if confirm "Set zsh as the default shell for $USER?"; then
    if ! grep -qxF "/usr/bin/zsh" /etc/shells; then
      echo /usr/bin/zsh | sudo tee -a /etc/shells >/dev/null
    fi

    chsh -s /usr/bin/zsh || sudo usermod -s /usr/bin/zsh "$USER"
  else
    warn "Skipping shell change."
  fi
}

configure_user_groups() {
  info "Configuring user groups"

  sudo usermod -aG docker "$USER" 2>/dev/null || true

  if getent group adbusers >/dev/null; then
    sudo usermod -aG adbusers "$USER" || true
  fi

  if getent group kvm >/dev/null; then
    sudo usermod -aG kvm "$USER" || true
  fi

  if getent group libvirt >/dev/null; then
    sudo usermod -aG libvirt "$USER" || true
  fi
}

final_message() {
  info "Installation finished"

  echo
  echo "Backup directory:"
  echo "  $BACKUP_DIR"
  echo
  echo "Recommended next steps:"
  echo "  1. Review copied configs"
  echo "  2. Reboot the system"
  echo "  3. Select Niri session in SDDM"
  echo "  4. Verify Noctalia starts correctly"
  echo
  echo "Important:"
  echo "  Some changes require logout/login or reboot."
}

main() {
  clear

  echo "Arch + Niri + Noctalia rice installer"
  echo "Repository: $REPO_DIR"
  echo

  warn "This script is intended for an existing Arch Linux installation."
  warn "It will install packages and copy configuration files."
  warn "Existing configs will be backed up to: $BACKUP_DIR"

  echo

  require_arch
  require_sudo

  if ! confirm "Continue?"; then
    echo "Aborted."
    exit 0
  fi

  install_pacman_packages
  install_paru_if_needed
  install_aur_packages
  apply_user_configs
  apply_sddm_configs
  configure_user_groups
  configure_shell
  enable_services
  final_message
}

main "$@"
