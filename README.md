# wallpapers

Простой менеджер статичных обоев для Hyprland и Wayland. Работает и на X11 через feh.
Умеет ставить обои, выбирать из списка, листать папку и сортировать по яркости.

## Что умеет
- Ставит картинку из папки. Бэкенд находит сам: hyprpaper, swww, awww, swaybg или feh.
- pick: выбор через fuzzel, rofi или wofi.
- random: случайная картинка.
- next и prev: листать папку.
- list --bright: сортировка от тёмных к светлым (нужен ImageMagick).
- restore: вернуть последние обои. Удобно для автозапуска.

## Установка
```sh
git clone https://github.com/ВАШ_НИК/wallpapers
cd wallpapers
./install.sh
```
install.sh кладёт команду `wallpaper` в ~/.local/bin.

Что нужно:
- bash и find (почти всегда есть).
- один бэкенд: hyprpaper, swww, awww, swaybg или feh.
- по желанию: fuzzel, rofi или wofi для меню выбора.
- по желанию: ImageMagick для сортировки по яркости.

Про hyprpaper 0.8 и новее: там убрали старый hyprctl. Утилита держит свой конфиг
(~/.cache/wallpaper/hyprpaper.conf) и перезапускает `hyprpaper -c` с ним. На версии
0.7 и старше работает обычный IPC.

## Быстрый старт
Положите картинки в ~/Pictures/Wallpapers. Или укажите свою папку в WALLPAPER_DIR.
```sh
wallpaper pick     # выбрать из списка
wallpaper random   # случайная
wallpaper next     # следующая (prev: предыдущая)
```

Конфиг (необязательно), файл ~/.config/wallpaper/config:
```sh
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER_BACKEND=auto
```

## Hyprland (новый Lua-конфиг, 0.5x и новее)
```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("wallpaper restore")
end)
hl.bind("SUPER + W", hl.dsp.exec_cmd("wallpaper pick"), { description = "Wallpaper" })
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("wallpaper random"))
```

## Демоны
Своих демонов утилита не держит. Постоянно работает только бэкенд, и только один:
- hyprpaper или swww/awww это демон в памяти;
- swaybg это один фоновый процесс;
- feh это разовая установка, процесса не держит.

Если не задать WALLPAPER_BACKEND, утилита берёт первый найденный бэкенд.

## Команды
```
wallpaper set <файл> [монитор]
wallpaper random [монитор]
wallpaper next | prev [монитор]
wallpaper pick [монитор]
wallpaper list [--bright]
wallpaper restore
wallpaper dir
wallpaper backend
```

## Лицензия
MIT
