-- Gpu usage widget
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local utils = require("src.widgets.utils")

local gpu_widget_bg = color["Green100"]

local gpu_widget = utils.watch_widget{
    bg = gpu_widget_bg,
    image_filename = "gpu.svg",
    watch_script_filename = "gpu_usage.sh",
    update_interval = 1,
    fmt_function = function(widget, stdout)
        widget:set_text(stdout)
    end
}

local gpu_tooltip = awful.tooltip{
    objects = { gpu_widget },
    text = "",
    mode = "inside",
    preferred_alignements = "middle",
    margins = dpi(10)
}

gpu_widget:connect_signal(
    "mouse::enter",
    function()
        gpu_widget.bg = color["Green200"]

        awful.spawn.easy_async_with_shell(
            [[lspci | grep -i vga | cut -d ' ' -f5- | sed 's/^/- /']],
            function(stdout)
                gpu_tooltip:set_text("Detected GPUs:\n" .. stdout)
            end
        )
    end
)
gpu_widget:connect_signal(
    "mouse::leave",
    function()
        gpu_widget.bg = gpu_widget_bg
    end
)

return gpu_widget
