-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
require("src.core.signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "src/assets/icons/audio/"
return function(screen)
    local function create_device(name, node, sink)

        local layout = {
            id = "device_layout",
            layout = wibox.layout.align.horizontal,
            {id = "node", widget = wibox.widget.textbox, text = name},
            {id = "icon", widget = wibox.widget.imagebox, resize = false, image = ""}
        }
        local background_margin = {
            id = "device_margin",
            margins = dpi(5),
            widget = wibox.container.margin,
            layout
        }
        local background_widget = {
            id = "background",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 4)
            end,
            widget = wibox.container.background,
            background_margin
        }
        local device = wibox.widget({
            {
                margins = dpi(5),
                widget = wibox.container.margin,
                background_widget
            }
        })

        if sink == true then
            device:connect_signal(
                "button::press",
                function()
                    awful.spawn.spawn("./.config/awesome/src/scripts/vol.sh set_sink " .. node)
                    awesome.emit_signal("update::background:vol", node)
                end
            )

            local old_wibox, old_cursor, old_bg, old_fg 
            local bg = ""
            local fg = ""

            device:connect_signal(
                "mouse::enter",
                function()
                    if bg then
                        old_bg = device.background.bg
                        device.background.bg = bg .. 'dd'
                    end
                    if fg then
                        old_fg = device.background.fg
                        device.background.fg = fg
                    end
                    local w = mouse.current_wibox
                    if w then
                        old_cursor, old_wibox = w.cursor, w
                        w.cursor = "hand1"
                    end
                end
            )
            device:connect_signal(
            "mouse::press",
            function()
                if bg then
                    if string.len(bg) == 7 then
                        device.background.bg = bg .. 'bb'
                    else
                        device.background.bg = bg
                    end
                end
                if fg then
                    device.background.fg = fg
                end
            end
            )

        end
    end
end
