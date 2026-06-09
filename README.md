# Arch + Niri + Noctalia

A personal Arch Linux desktop rice built around **Niri**, **Noctalia Shell v5**, **SDDM**, **Zsh**, **Starship**, and **Alacritty**.

This setup focuses on a clean Wayland workflow, a modern terminal experience, Tokyo Night inspired visuals, practical keyboard shortcuts, and a development-ready Linux environment.

---

## Preview

> Screenshots coming soon.

---

## Stack

### Desktop

- **Arch Linux**
- **Niri** Wayland compositor
- **Noctalia Shell v5**
- **SDDM** login manager
- **Sugar Candy SDDM theme**
- Tokyo Night inspired visual style
- Bibata cursor theme
- Dark GTK theme

### Terminal

- **Alacritty**
- **Zsh**
- **Starship**
- **Fastfetch mini rice**
- **fzf**
- **zoxide**
- **eza**
- **bat**
- **ripgrep**
- **fd**

### Development

- Git + GitHub CLI
- VS Code
- Node.js / npm / pnpm
- Python / pipx / virtualenv
- Docker / Docker Compose
- Android Studio / Android SDK / ADB
- KVM / libvirt

---

## Repository Structure

```text
arch-niri-noctalia/
├── configs/
│   ├── alacritty/
│   ├── fastfetch/
│   ├── niri/
│   ├── sddm/
│   ├── starship/
│   └── zsh/
├── notes/
├── packages/
│   ├── aur.txt
│   └── pacman.txt
├── scripts/
│   └── install.sh
└── README.md
```

---

## Highlights

- Minimal Wayland desktop using Niri
- Noctalia Shell v5 integration
- Custom SDDM login screen
- Tokyo Night inspired color palette
- Clean Alacritty terminal without title bar
- Zsh + Starship prompt
- Mini Fastfetch on terminal launch
- Clipboard integration through Noctalia
- Shared `/data/Projects` development workspace
- Arch + Fedora dual boot workflow

---

## Keybindings

| Shortcut | Action |
|---|---|
| `Super + D` | Open Noctalia launcher |
| `Super + V` | Open Noctalia clipboard |
| `Super + B` | Toggle floating window |
| `Super + E` | Open file manager |
| `Super + Space` | Open terminal |
| `Super + Shift + S` | Screenshot region |
| `Super + Q` | Close focused window |

---

## Terminal Setup

The terminal setup uses:

```text
Alacritty + Zsh + Starship + Fastfetch
```

Features:

- Tokyo Night inspired colors
- No title bar
- Slight transparency
- Compact padding
- Nerd Font support
- Git-aware prompt
- Fast navigation with zoxide
- Fuzzy search with fzf
- Modern replacements for common commands

---

## Login Screen

The login screen uses:

```text
SDDM + Sugar Candy
```

Customizations:

- Dark theme
- Tokyo Night inspired colors
- Bibata cursor
- Custom wallpaper
- Rounded login card
- Niri session support

---

## Installation Guide

This repository is designed to apply this rice on top of an existing **Arch Linux** installation.

It is **not** a full Arch Linux installer.

The installer is intended to configure the desktop environment, terminal, shell, login manager theme, and related visual/dev tools.

---

## Requirements

Before running the installer, you need:

- Arch Linux already installed
- Internet connection
- A regular user with `sudo` access
- `pacman` working correctly
- `git`
- `base-devel`
- Basic familiarity with TTY recovery
- A Wayland-capable graphics stack

Install the minimum requirements first:

```bash
sudo pacman -Syu --needed git base-devel
```

Clone this repository:

```bash
git clone https://github.com/jonatasbarra/arch-niri-noctalia.git
cd arch-niri-noctalia
```

Run the installer:

```bash
./scripts/install.sh
```

---

## What the Installer Does

The installer will:

- Install required `pacman` packages
- Install required AUR packages
- Install `paru` if it is missing
- Back up existing configuration files
- Copy Niri, Alacritty, Starship, Fastfetch and Zsh configs
- Optionally apply SDDM theme configs
- Optionally set Zsh as the default shell
- Optionally enable SDDM
- Add the current user to useful groups when available

The installer does **not** partition disks, install Arch from scratch, configure GRUB, or modify dual boot entries.

---

## Main Packages

### Pacman packages

The installer uses `pacman` to install packages such as:

```text
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
```

### AUR packages

The installer uses AUR packages such as:

```text
noctalia-git
bibata-cursor-theme
sddm-sugar-candy-git
```

---

## Backups

Before replacing configs, the installer creates a backup directory like:

```text
~/.config-backup-arch-niri-noctalia-YYYYMMDD-HHMMSS
```

Backed up paths may include:

```text
~/.config/niri
~/.config/alacritty
~/.config/fastfetch
~/.config/starship.toml
~/.zshrc
```

SDDM configs are backed up separately before being replaced.

---

## Manual Steps After Installation

After running the installer, reboot:

```bash
sudo reboot
```

At the login screen:

1. Select the **Niri** session.
2. Log in.
3. Confirm that Noctalia starts.
4. Open Alacritty with `Super + Space`.
5. Confirm Zsh, Starship and Fastfetch are working.

Useful checks:

```bash
echo $SHELL
niri validate
systemctl --failed
systemctl --user --failed
```

---

## SDDM Notes

This setup uses **SDDM** with the **Sugar Candy** theme.

The theme is configured with:

- Tokyo Night inspired colors
- Dark background
- Custom wallpaper
- Bibata cursor
- Rounded login interface

If SDDM fails to start, switch to a TTY:

```text
Ctrl + Alt + F2
```

Then disable SDDM and return to another display manager if needed:

```bash
sudo systemctl disable sddm
sudo systemctl enable greetd
sudo reboot
```

---

## Niri Notes

The Niri config includes:

- Noctalia autostart
- XWayland Satellite autostart
- Polkit agent autostart
- Custom gaps
- Rounded corners
- Focus ring styling
- Noctalia launcher shortcut
- Noctalia clipboard shortcut
- Screenshot shortcut
- Alacritty terminal shortcut
- Nautilus file manager shortcut

Validate the Niri configuration with:

```bash
niri validate
```

---

## Safety Notes

This repository does **not** include:

- SSH keys
- Tokens
- Passwords
- Browser data
- Personal files
- Private project data

Before applying these configs on another machine, review the script and back up your existing files.

Do not blindly run scripts from public repositories without reading them first.

---

## Disclaimer

This setup is tailored to my personal workflow.

Use it as inspiration, not as a universal installation guide.
