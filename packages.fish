#!/usr/bin/fish
# script which installs my essential packages (pacman with chaotic-aur)

# chaotic-aur
pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key FBA220DFC880C036
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
" >> /etc/pacman.conf

pacman -Suy yay
yay -Suy \
  albert-git \
  blueman \
  chaotic-mirrorlist chaotic-keyring \
  choosenim \
  cmake \
  clang \
  cups \
  d-feet \
  dconf-editor \
  discord \
  downgrade \
  dunst \
  electron \
  eog \
  evince \
  fastfetch-git \
  file-roller \
  firefox-nightly \
  fragments \
  garuda-wayfire-settings \
  gcc \
  gcolor3 \
  gedit \
  gedit-plugins \
  gimp-devel \
  git \
  glade \
  glfw-wayland-minecraft \
  gnome-disk-utility \
  gnome-font-viewer \
  gnome-keyring \
  gnome-maps \
  gnome-nettool \
  gnome-photos \
  gnome-system-monitor \
  gnome-tweaks \
  gnome-usage \
  gnome-weather \
  godot \
  grub-btrfs \
  grub-garuda \
  grub-theme-garuda-dr460nized \
  gscreenshot \
  htop \
  hunspell-en_us \
  hunspell-ru \
  hyphen-en \
  hyphen-ru \
  inkscape \
  intellij-idea-community-edition \
  ipython \
  kanshi \
  kdeconnect \
  kitty \
  kvantum-theme-sweet-git \
  libreoffice-fresh \
  linux-zen \
  make \
  man-db \
  meld \
  meson \
  nautilus \
  nautilus-admin-git \
  nautilus-bluetooth \
  nautilus-image-converter \
  neovim \
  neovim-plug \
  network-manager \
  ninja \
  nm-connection-editor \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  pace \
  pamac-aur \
  pavucontrol \
  playerctl \
  plymouth-git \
  plymouth-theme-dr460nized \
  polkit-gnome \
  pycharm-community-edition \
  python-lsp \
  python-pip \
  qt5ct \
  qt6ct \
  qtcreator \
  reflector \
  seahorse \
  slurp \
  spicetify-cli \
  spotify \
  steam \
  sudo \
  swayidle \
  swaylock-effects \
  system-config-printer \
  telegram-desktop \
  totem \
  ttf-jetbrains-mono \
  twine \
  wayfire \
  wayfire-plugins-extra \
  wf-osk-git \
  wf-recorder \
  wf-shell \
  wireplumber \
  wl-clipboard \
  wlogout \
  xdg-portal-gtk \
  xdg-portal-wlr \
  xord-xwayland \
  xorg-xwininfo
  
