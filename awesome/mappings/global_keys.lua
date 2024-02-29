-- Awesome Libs
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local modkey = user_vars.modkey
local altkey = "Mod1"
local ctrlkey = "Control"
local shiftkey = "Shift"



return gears.table.join(
  awful.key(
    { modkey, ctrlkey },
    "i",
    hotkeys_popup.show_help,
    { description = "Cheat sheet", group = "Awesome" }
  ),
  -- Tag browsing
  awful.key(
    { modkey, altkey },
    "h",
    awful.tag.viewprev,
    { description = "View previous tag", group = "Tag" }
  ),
  awful.key(
    { modkey, altkey },
    "l",
    awful.tag.viewnext,
    { description = "View next tag", group = "Tag" }
  ),
  -- Screen browsing
  awful.key(
    { modkey, altkey },
    "k",
    function()
      awful.screen.focus_relative(1)
    end,
    { description = "View next screen", group = "Screen" }
  ),
  awful.key(
    { modkey, altkey },
    "j",
    function()
      awful.screen.focus_relative(-1)
    end,
    { description = "Focus the previous screen", group = "Screen" }
  ),

  -- Applications
  awful.key(
    { modkey },
    "#36", -- Enter
    function()
      awful.spawn(user_vars.terminal)

    end,
    { description = "Teminal", group = "Applications" }
  ),
  awful.key(
    { modkey },
    "c",
    function()
        awful.spawn(user_vars.browser .. " --new-tab")
    end,
    { description = "Web browser", group = "Applications" }
  ),

 -- Rofi 
  awful.key(
    { modkey },
    "#40",
    function()
      awful.spawn("rofi -show drun -theme ~/.config/rofi/rofi.rasi")
    end,
    { description = "Application launcher", group = "Launchers" }
  ),
  awful.key(
    { modkey },
    "#23",
    function()
      awful.spawn("rofi -show window -theme ~/.config/rofi/window.rasi")
    end,
    { description = "Client switcher (alt+tab)", group = "Launchers" }
  ),
  awful.key(
    { modkey, shiftkey },
    "a",
    function ()
        local clients = awful.screen.focused().clients
        for _, c in pairs(clients) do
            c:kill()
        end
    end,
    {description = "Kill all clients", group = "Client"}
    ),

  -- Layout switcher
  -- Layout switcher
  awful.key(
    { modkey },
    "#65",
    function()
      awful.layout.inc(1)
    end,
    { description = "Next layout", group = "Layout" }
  ),
  awful.key(
    { modkey, shiftkey },
    "#65",
    function()
      awful.layout.inc(-1)
    end,
    { description = "Previous layout", group = "Layout" }
  ),

  -- Focus windows

  awful.key(
    { modkey },
    "h",
    function()
        awful.client.focus.bydirection("left")
    end,
    { description = "Focus left", group = "Focus" }
  ),
  awful.key(
    { modkey },
    "j",
    function()
        awful.client.focus.bydirection("down")
    end,
    { description = "Focus down", group = "Focus" }
  ),
  awful.key(
    { modkey },
    "k",
    function()
        awful.client.focus.bydirection("up")
    end,
    { description = "Focus up", group = "Focus" }
  ),
  awful.key(
    { modkey },
    "l",
    function()
        awful.client.focus.bydirection("right")
    end,
    { description = "Focus right", group = "Focus" }
  ),

  -- System apps
  awful.key(
    { modkey, "Shift" },
    "r",
    awesome.restart,
    { description = "Reload awesome", group = "System" }
  ),
  awful.key(
    { modkey },
    "#26",
    function()
      awful.spawn(user_vars.file_manager)
    end,
    { description = "Open file manager", group = "System" }
  ),
  awful.key(
    { modkey, shiftkey },
    "p",
    function()
      awesome.emit_signal("module::powermenu:show")
    end,
    { description = "Power menu", group = "System" }
  ),
  awful.key(
    {},
    "#107",
    function()
      awful.spawn(user_vars.screenshot_program)
    end,
    { description = "Screenshot", group = "Buttons" }
  ),

  -- Audio
  awful.key(
    {},
    "XF86AudioLowerVolume",
    function(_)
      awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%", function()
        awesome.emit_signal("module::volume_osd:show", true)
        awesome.emit_signal("module::slider:update")
        awesome.emit_signal("widget::volume_osd:rerun")
      end)
    end,
    { description = "Control volume", group = "Audio" }
  ),
  awful.key(
    {},
    "XF86AudioRaiseVolume",
    function(_)
      awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%", 
      function()
        awesome.emit_signal("module::volume_osd:show", true)
        awesome.emit_signal("module::slider:update")
        awesome.emit_signal("widget::volume_osd:rerun")
      end)
    end,
    { description = "Control volume", group = "Audio" }
  ),
  awful.key(
    {},
    "XF86AudioMute",
    function(_)
      awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
      awesome.emit_signal("module::volume_osd:show", true)
      awesome.emit_signal("module::slider:update")
      awesome.emit_signal("widget::volume_osd:rerun")
    end,
    { description = "Control volume", group = "Audio" }
  ),
  -- Brightness
  awful.key(
    {},
    "XF86MonBrightnessUp",
    function(_)
      --awful.spawn("xbacklight -time 100 -inc 10%+")
      awful.spawn.easy_async_with_shell(
        "pkexec xfpm-power-backlight-helper --get-brightness",
        function(stdout)
          local num = tonumber(stdout) + BACKLIGHT_SEPS

          awful.spawn.easy_async_with_shell(
            "pkexec xfpm-power-backlight-helper --set-brightness " .. tostring(num),
            function(_) end
          )
          awesome.emit_signal("module::brightness_osd:show", true)
          awesome.emit_signal("module::brightness_slider:update")
          awesome.emit_signal("widget::brightness_osd:rerun")
        end
      )
    end,
    { description = "Adjust backlight brightness", group = "Brightness" }
  ),
  awful.key(
    {},
    "XF86MonBrightnessDown",
    function(c)
      awful.spawn.easy_async_with_shell(
        "pkexec xfpm-power-backlight-helper --get-brightness",
        function(stdout)
          awful.spawn.easy_async_with_shell(
          "pkexec xfpm-power-backlight-helper --set-brightness " 
          .. tostring(tonumber(stdout) - BACKLIGHT_SEPS), function(stdout2)
          end)

          awesome.emit_signal("module::brightness_osd:show", true)
          awesome.emit_signal("module::brightness_slider:update")
          awesome.emit_signal("widget::brightness_osd:rerun")
        end
      )
    end,
    { description = "Adjust backlight brightness", group = "Brightness" }
  ),
  -- Medias 
  awful.key(
    {},
    "XF86AudioPrev",
    function(_)
      awful.spawn("playerctl previous")
    end,
    { description = "Control media", group = "Media" }
  ),
  awful.key(
    {},
    "XF86AudioPlay",
    function(_)
      awful.spawn("playerctl play-pause")
    end,
    { description = "Control media", group = "Media" }
  ),
  awful.key(
    {},
    "XF86AudioNext",
    function(_)
      awful.spawn("playerctl next")
    end,
    { description = "Control media", group = "Media" }
  )
)

