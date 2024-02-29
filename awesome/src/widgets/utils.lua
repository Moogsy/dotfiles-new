local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

local icon_dir = awful.util.getdir("config") .. "src/assets/icons/"

local function get_imagebox(image_filename)
    return {
        id = "icon_margin",
        widget = wibox.container.margin,
        top = dpi(2),
        {
            id = "icon_layout",
            widget = wibox.container.place,
            {
                id = "icon",
                widget = wibox.widget.imagebox,
                image = gears.color.recolor_image(icon_dir .. image_filename, color["Grey900"]),
                resize = false
            }
        }
    }
end

local function get_text_box(watch_script_filename, update_interval)
    return {
        id = "label",
        align = "center",
        valign = "center",
        widget = awful.widget.watch(
        "./.config/awesome/src/scripts/" .. watch_script_filename,
        update_interval
        )
    }
end

return function(args)
    return wibox.widget({
        fg = color["Grey900"],
        bg = args.bg,
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
                get_imagebox(args.image_filename),
                get_text_box(args.watch_script_filename, args.update_interval),
            },
        }
    })
end
