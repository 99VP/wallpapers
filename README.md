# wallpapers

Маленький менеджер **статичных обоев** для Hyprland / Wayland (работает и на X11 через `feh`).
Выбор, случайные, листание и сортировка папки по яркости — с автоопределением бэкенда.

## Что делает
- Ставит обои из папки через **hyprpaper / swww+awww / swaybg / feh** (что найдёт в системе).
- `pick` — выбор через **fuzzel / rofi / wofi**, а также `random`, `next`/`prev`.
- `list --bright` — сортировка от тёмных к светлым (нужен ImageMagick).
- Запоминает последние обои — `restore` для автозапуска сессии.

## Установка
```sh
git clone https://github.com/<ВАШ_НИК>/wallpapers
cd wallpapers
./install.sh            # положит команду `wallpaper` в ~/.local/bin
```
Нужен `bash` и `find`. Бэкенд — любой один из: `hyprpaper`, `swww`/`awww`, `swaybg`, `feh`.
Опционально: `fuzzel`/`rofi`/`wofi` (меню выбора) и `imagemagick` (сортировка по яркости).

> Для **hyprpaper 0.8+** (у него убрали старый `hyprctl`-IPC) утилита держит свой
> конфиг `~/.cache/wallpaper/hyprpaper.conf` и перезапускает `hyprpaper -c` с ним.
> Старые версии (≤ 0.7) работают через обычный IPC.

## Быстрый старт
```sh
# положите картинки в ~/Pictures/Wallpapers (или задайте WALLPAPER_DIR)
wallpaper pick       # выбрать из списка
wallpaper random     # случайные
wallpaper next       # следующие / prev — предыдущие
```

Необязательный конфиг `~/.config/wallpaper/config`:
```sh
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER_BACKEND=auto      # auto|awww|swww|hyprpaper|swaybg|feh
```

## Hyprland (новый Lua-конфиг, 0.5x+)
```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("wallpaper restore")
end)
hl.bind("SUPER + W", hl.dsp.exec_cmd("wallpaper pick"), { description = "Wallpaper" })
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("wallpaper random"))
```

## Демоны
Своих демонов утилита **не держит**. Постоянно работает только бэкенд, и **ровно один**:

- `hyprpaper` или `swww`/`awww` — это демон в памяти;
- `swaybg` — один фоновый процесс;
- `feh` — разовая установка, процесса не держит вообще.

Без `WALLPAPER_BACKEND` утилита сама выбирает **первый найденный** бэкенд и использует только его.

## Команды
```
wallpaper set <file> [monitor]     wallpaper random [monitor]
wallpaper next | prev [monitor]    wallpaper pick [monitor]
wallpaper list [--bright]          wallpaper restore
wallpaper dir                      wallpaper backend
```

## Лицензия
MIT
