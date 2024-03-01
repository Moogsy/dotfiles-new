-- Gpu usage widget
local color = require("src.theme.colors")
local wibox = require("wibox")
local utils = require("src.widgets.utils")
local awful = require("awful")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local previous_total = 0
local previous_idle = 0

return wibox.widget({
    fg = color["Grey900"],
    bg = color["Purple100"],
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 5)
    end,
    widget = wibox.container.background,
    {
        id = "container",
        left = dpi(8),
        right = dpi(8),
        widget = wibox.container.margin
        {
            id = "layout",
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(10),
            utils.get_imagebox("cpu.svg"),
            {
                id = "label",
                align = "center",
                valign = "center",
                widget = awful.widget.watch(
                    "./.config/awesome/src/scripts/cpu_usage.sh",
                    1,
                    function(widget, stdout)

                        local usr, nice, sys, idle, iowait, irq, softirq, steal, guest, guest_nice =
                            stdout:match("(%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+)")

                        local total = usr + nice + sys + idle + iowait + irq + softirq + steal + guest + guest_nice

                        local diff_idle = idle - previous_idle
                        local diff_total = total - previous_total
                        local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

                        widget:set_text(string.format("%.0f%%", diff_usage))
                    end
                ),
            }
        },
    }
})

