# My Current Hyprland Dotfiles
---

> [!IMPORTANT]  
> No guarantee it will work on your machine — works on mine, but should work on yours too.
> [!IMPORTANT]
> This repository is not intended for out-of-the-box use. It is public so that others may use it as a reference.
---

> [!NOTE]
> I use paru (AUR helper) so if you'll use yay then remove the ``alias yay="paru"`` line in ``/.config/fish/config.fish``

> [!NOTE]
> If you are not using nvidia gpu you should delete the nvidia fix env's in ``/.config/hypr/hyprland.conf``

---

# Used packages
Can be found on pacman and aur.

## Dotfiles Related

```
hyprland
hyprlock
hyprpicker
hyprshot
kitty
waybar
pulsemixer
dunst
xwaylandvideobridge
rofi-wayland
rofi-emoji
cliphist
wl-clip-persist
swww
waypaper
swappy
yazi
fish
fastfetch
eza
ffmpeg
expac
fisher
qt6ct-kde
darkly-bin
xcursor-breeze
matugen
python-pywal16
nemo
nemo-fileroller
mission-center
spicetify-cli
```
### Fisher packages
**for prompt configration**
```
ilancosman/tide@v6
```
use ``fisher install ilancosman/tide@v6`` to install it. ``tide configure`` to configure the prompt.

## My Other Personal Preferences
#### Browser
```
zen-browser
```
### Music Player
```
spotify-launcher
```
### Disk Utility
```
gnome-disk-utility
```
### Text Editor
```
code
```
### Discord Client
```
vesktop
```
> [!NOTE]
> Matugen (the color generation tool) is configured to work with vesktop.
### Note Taking App
```
obsidian
```
### App Entry Editor
```
libre-menu-editor
```

----

### Guide to apply spicetify matugen theme

1. Install and apply spicetify correctly.

2. Download my dotfiles and put spicetify files to the correct location.

3. Run these commands

```
spicetify config current_theme Ziro
spicetify config color_scheme blue-dark
spicetify config custom_apps marketplace
```

4. Done! You have to type ``spicetify apply`` to reload Spotify when you change your wallpaper. (I don't want to automate this via scripts since it can behave badly. Manually reloading it generally works better)

> [!NOTE]
> You can't (and shouldn't) change your theme through marketplace with this config but you can use extensions and other stuff.

> If you want to change your theme through marketplace (matugen won't work) run ``spicetify config current_theme marketplace``
