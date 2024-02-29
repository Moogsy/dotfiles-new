--------------------------------------------------
--  ██████╗██████╗ ██╗   ██╗██╗     ██╗ █████╗  --
-- ██╔════╝██╔══██╗╚██╗ ██╔╝██║     ██║██╔══██╗ --
-- ██║     ██████╔╝ ╚████╔╝ ██║     ██║███████║ --
-- ██║     ██╔══██╗  ╚██╔╝  ██║     ██║██╔══██║ --
-- ╚██████╗██║  ██║   ██║   ███████╗██║██║  ██║ --
--  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝╚═╝  ╚═╝ --
--------------------------------------------------
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

Theme_path = awful.util.getdir("config") .. "/src/theme/"
Theme = {}

dofile(Theme_path .. "theme_variables.lua")

-- Wallpaper
beautiful.wallpaper = user_vars.wallpaper

screen.connect_signal(
    'request::wallpaper',
    function(s)
        if beautiful.wallpaper then
            if type(beautiful.wallpaper) == 'string' then
                gears.wallpaper.maximized(beautiful.wallpaper, s)
            else
                beautiful.wallpaper(s)
            end
        end
    end
)

beautiful.init(Theme)
