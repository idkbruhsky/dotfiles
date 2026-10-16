# dotfiles

Configurația mea de CachyOS (Arch) cu i3wm. Scopul repo-ului: după o reinstalare, clonez și rulez `install.sh`, și am setup-ul înapoi 1:1.

## Ce conține

| Fișier / folder | Ce e |
|---|---|
| `i3/` | config i3wm (`~/.config/i3`) |
| `kitty/` | terminalul kitty, cu `background_opacity` (`~/.config/kitty`) |
| `picom/` | compositor: transparență + animații (`~/.config/picom`) |
| `fastfetch/` | fastfetch cu logo propriu (poză) (`~/.config/fastfetch`) |
| `zshrc`, `p10k.zsh` | zsh + Powerlevel10k, fastfetch la deschiderea consolei |
| `lightdm.conf` | LightDM cu `lightdm-gtk-greeter` și sesiunea i3 (`/etc/lightdm/lightdm.conf`) |
| `Wallpapers/` | wallpaper-urile (`~/Wallpapers`) |
| `pictures/` | poza pentru logo-ul fastfetch (`~/Pictures`) |
| `packages.txt` | pachete din repo-urile oficiale |
| `packages-aur.txt` | pachete din AUR |
| `install.sh` | instalează pachetele și pune fișierele la locul lor |

## Instalare pe un sistem nou

După instalarea CachyOS, cu internet (din tty: `nmcli device wifi connect "NUME" password "PAROLA"`):

```bash
sudo pacman -S --needed git github-cli
gh auth login
gh repo clone dotfiles ~/dotfiles
~/dotfiles/install.sh
```

Pachetele din AUR se instalează separat:

```bash
yay -S --needed - < ~/dotfiles/packages-aur.txt
```

Apoi `reboot`. În ecranul de login aleg sesiunea **i3**.

## Ce face `install.sh`

- instalează pachetele din `packages.txt`
- pentru fiecare folder din `~/.config` care există deja, face backup (`nume.bak.<timestamp>`) și apoi copiază versiunea din repo
- copiază `zshrc` și `p10k.zsh` în home (suprascrie `~/.zshrc` și `~/.p10k.zsh`)
- copiază wallpaper-urile și poza de logo
- copiază `lightdm.conf` în `/etc/lightdm/` (cere `sudo`) și activează serviciul `lightdm`

## Actualizare după modificări

Configurile din `~/.config` sunt copii, nu symlink-uri, deci după ce schimb ceva trebuie să sincronizez manual:

```bash
cp -r ~/.config/{i3,kitty,picom,fastfetch} ~/dotfiles/
cp ~/.zshrc ~/dotfiles/zshrc
cp ~/.p10k.zsh ~/dotfiles/p10k.zsh
cd ~/dotfiles && git add -A && git commit -m "update" && git push
```

Lista de pachete se reface cu:

```bash
pacman -Qqen > ~/dotfiles/packages.txt
pacman -Qqem > ~/dotfiles/packages-aur.txt
```

## Note

- Folosesc X11 (i3), nu Wayland, deci clipboard-ul merge cu `xclip`, nu `wl-copy`.
- Logo-ul fastfetch e o imagine afișată prin protocolul kitty, deci merge doar în kitty.
