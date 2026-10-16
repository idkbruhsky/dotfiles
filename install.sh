#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"

sudo pacman -S --needed - < "$DIR/packages.txt"

mkdir -p ~/.config ~/Pictures
for d in i3 kitty picom fastfetch; do
  if [ -e ~/.config/$d ]; then
    mv ~/.config/$d ~/.config/$d.bak.$(date +%s)
  fi
  cp -r "$DIR/$d" ~/.config/$d
done

cp "$DIR/zshrc" ~/.zshrc
cp "$DIR/p10k.zsh" ~/.p10k.zsh
cp -r "$DIR/pictures/." ~/Pictures/

sudo cp "$DIR/lightdm.conf" /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm

echo "Gata. Dă reboot."
