-------------------------------------------
-- Uservariables are stored in this file --
-------------------------------------------
local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local home = os.getenv("HOME")

-- If you want different default programs, wallpaper path or modkey; edit this file.
user_vars = {

  -- Autotiling layouts
  layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
  },

  -- Icon theme from /usr/share/icons
  icon_theme = "Papirus-Dark",

  -- Write the terminal command to start anything here
  autostart = {
    "picom --config " .. home .. "/.config/picom.conf"
  },

  -- Type 'ip a' and check your wlan and ethernet name
  network = {
    wlan = "wlan0",
    ethernet = "enp2s0"
  },

  -- Set your font with this format:
  font = {
    regular = "Victor Mono Nerd Font, 14",
    bold = "Victor Mono Nerd Font, bold 14",
    extrabold = "Victor Mono Nerd Font, ExtraBold 14",
    specify = "Victor Mono Nerd Font"
  },

  -- This is your default Terminal
  terminal = "kitty",

  -- This is your default browser
  browser = "chromium",

  -- This is the modkey 'mod4' = Super/Mod/WindowsKey, 'mod3' = alt...
  modkey = "Mod4",

  -- place your wallpaper at this path with this name, you could also try to change the path
  wallpaper = home .. "/.config/awesome/src/assets/fuji.jpg",

  -- Naming scheme for the powermenu, userhost = "user@hostname", fullname = "Firstname Surname", something else ...
  namestyle = "userhost",

  -- List every Keyboard layout you use here comma seperated. (run localectl list-keymaps to list all averiable keymaps)
  kblayout = { "fr" },

  -- Your filemanager that opens with super+e
  file_manager = "thunar",

  -- Screenshot program to make a screenshot when print is hit
  screenshot_program = "flameshot gui",

  -- If you use the dock here is how you control its size
  dock_icon_size = dpi(50),

  -- Add your programs exactly like in this example.
  -- First entry has to be how you would start the program in the terminal (just try it if you dont know yahoo it)
  -- Second can be what ever the fuck you want it to be (will be the displayed name if you hover over it)
  -- For steam games please use this format (look in .local/share/applications for the .desktop file, that will contain the number you need)
  -- {"394360", "Name", true} true will tell the func that it's a steam game
  -- Use xprop | grep WM_CLASS and use the *SECOND* string
  -- { WM_CLASS, program, name, user_icon, isSteam }
  dock_programs = {
    { "Kitty", "kitty", "Kitty" },
    { "Chromium", "chromium", "Chromium" },
    { "discord", "discord", "Discord" },
    { "Spotify", "spotify", "Spotify" },
    { "Blender", "blender", "Blender" },
    -- { "Windows", "virsh start Windows_11", "Windows 11", "/home/crylia/Bilder/windows.png", false, 50 }
  }
}