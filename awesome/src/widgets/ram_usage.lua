local color = require("src.theme.colors")
local utils = require("src.widgets.utils")

return utils.watch_widget({
    bg = color["Red200"],
    image_filename = "ram.svg",
    watch_script_filename = "ram_usage.sh",
    update_interval = 1,
    fmt_function = function(widget, stdout)
        local total, free = stdout:match("(%d+)\n(%d+)")
        widget:set_text(string.format("%.0f%%", 100 * (total - free) / total))
    end
})

