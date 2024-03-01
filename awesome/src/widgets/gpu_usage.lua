-- Gpu usage widget
local color = require("src.theme.colors")

local utils = require("src.widgets.utils")
return utils.watch_widget_factory{
    bg = color["Green200"],
    image_filename = "gpu.svg",
    watch_script_filename = "gpu_usage.sh",
    update_interval = 1
}
