-- Gpu usage widget
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local utils = require("src.widgets.utils")

local cpu_widget_bg = color["Purple100"]

local previous_total = 0
local previous_idle = 0

local cpu_widget = utils.watch_widget({
    bg = color["Purple100"],
    image_filename = "cpu.svg",
    watch_script_filename = "cpu_usage.sh",
    update_interval = 1,
    fmt_function = function(widget, stdout)
        local usr, nice, sys, idle, iowait, irq, softirq, steal, guest, guest_nice =
            stdout:match("(%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+)")

        local total = usr + nice + sys + idle + iowait + irq + softirq + steal + guest + guest_nice

        local diff_idle = idle - previous_idle
        local diff_total = total - previous_total
        local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

        widget:set_text(string.format("%.0f%%", diff_usage))
    end
})

local cpu_tooltip = awful.tooltip{
    objects = { cpu_widget },
    text = "",
    mode = "inside",
    preferred_alignements = "middle",
    margins = dpi(10)
}

cpu_widget:connect_signal(
    "mouse::enter",
    function()
        cpu_widget.bg = color["Purple200"]

        awful.spawn.easy_async_with_shell(
            'lscpu | grep -i "model name:" | sed "s/Model name:[[:space:]]*//"',
            function(stdout)
                cpu_tooltip:set_text(stdout)
            end
        )
    end
)

cpu_widget:connect_signal(
    "mouse::leave",
    function()
        cpu_widget.bg = cpu_widget_bg
    end
)

return cpu_widget
