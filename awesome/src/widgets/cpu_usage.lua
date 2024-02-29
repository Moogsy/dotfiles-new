-- Gpu usage widget
local color = require("src.theme.colors")

local watch_widget_factory = require("src.widgets.utils")
return watch_widget_factory{
    bg = color["Green200"],
    image_filename = "cpu.svg",
    watch_script_filename = "cpu_usage.sh",
    update_interval = 1
}
