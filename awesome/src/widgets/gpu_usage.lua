-- Gpu usage widget
local color = require("src.theme.colors")

local utils = require("src.widgets.utils")
return utils.watch_widget{
    bg = color["Green200"],
    image_filename = "gpu.svg",
    watch_script_filename = "gpu_usage.sh",
    update_interval = 1,
    fmt_function = function(widget, stdout)
        widget:set_text(stdout)
    end
}
