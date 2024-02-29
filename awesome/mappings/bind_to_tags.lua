-- Awesome Libs
local awful = require("awful")
local gears = require("gears")
local globalkeys = require("../mappings/global_keys")
local modkey = user_vars.modkey

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,

    -- View tag only
    awful.key(
    { modkey },
    "#" .. i + 9,
    function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
        client.emit_signal("tag::switched")
    end,
    { description = "View Tag" , group = "Tag" }
    ),
   -- Brings the window over without chaning the tag, reverts automatically on tag change
    awful.key(
    { modkey, "Shift" },
    "#" .. i + 9,
    function()
        local screen = awful.screen.focused()
        if client.focus then
            local tag = screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    { desc = "Move focused client to tag", group = "Tag" }
    )
    )
end
root.keys(globalkeys)