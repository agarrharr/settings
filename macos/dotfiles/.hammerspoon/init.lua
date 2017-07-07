prefix = require("prefix")
require("mouse_key")
require("mouse-highlight")
require("window-management")


-- mouse highlight
hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)

-- reload the config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Start screensaver
hs.hotkey.bind({"alt"}, "1", function()
    hs.caffeinate.startScreensaver()
end)

hs.alert.show("Config loaded")
