prefix = require("prefix")
require("mouse_key")
require("window-management")

-- reload the config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Start screensaver
hs.hotkey.bind({"alt"}, "1", function()
    hs.caffeinate.startScreensaver()
end)

hs.alert.show("Config loaded")
