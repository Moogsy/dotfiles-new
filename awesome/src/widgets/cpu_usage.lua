-- Gpu usage widget
local color = require("src.theme.colors")
local utils = require("src.widgets.utils")

local previous_total = 0
local previous_idle = 0

return utils.watch_widget({
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
