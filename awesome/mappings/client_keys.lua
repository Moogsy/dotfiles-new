-- Awesome Libs
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

local function move_client_dwim(client, direction)
    if direction == "up " or direction == "left" then
        awful.client.swap.byidx(-1, client)
    elseif direction == "down" or direction == "right" then
        awful.client.swap.byidx(1, client)
    end
end

return gears.table.join(
    awful.key(
        { modkey },
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "Toggle fullscreen", group = "Client" }
    ),
    awful.key(
        { modkey },
        "a",
        function(c)
            c:kill()
        end,
        { description = "Kill focused client", group = "Client" }
    ),
    awful.key(
        { modkey },
        "b",
        awful.client.floating.toggle,
        { description = "Toggle floating window", group = "Client" }
    ),
    awful.key(
        { modkey, "Shift" },
        "j",
        function(c)
            c:move_to_screen(c.screen.index - 1)
        end,
        { description = "Move focused client to previous screen", group = "Control" }
    ),
    awful.key(
        { modkey, "Shift" },
        "k",
        function(c)
            c:move_to_screen(c.screen.index + 1)
        end,
        { description = "Move focused client to next screen", group = "Control" }
    ),
    awful.key(
        { modkey, "Control" },
        "h",
        function(c)
            awful.client.swap.byidx(-1, c)
        end,
        { description = "Move focused client", group = "Layout" }
    ),
    awful.key(
        { modkey, "Control" },
        "j",
        function(c)
            awful.client.swap.byidx(1, c)
        end,
        { description = "Move focused client", group = "Layout" }
    ),
    awful.key(
        { modkey, "Control" },
        "k",
        function(c)
            awful.client.swap.byidx(-1, c)
        end,
        { description = "Move focused client", group = "Layout" }
    ),
    awful.key(
        { modkey, "Control" },
        "l",
        function(c)
            awful.client.swap.byidx(1, c)
        end,
        { description = "Move focused client", group = "Layout" }
    )
)
