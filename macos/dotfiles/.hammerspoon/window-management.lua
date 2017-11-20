-- -----------------------------------------------------------------------
--                         ** Something Global **                       --
-- -----------------------------------------------------------------------
  -- Comment out this following line if you wish to see animations
hs.window.animationDuration = 0
grid = require "hs.grid"
grid.setMargins('0, 0')

-- Set screen watcher, in case you connect a new monitor, or unplug a monitor
screens = {}
screenArr = {}
local screenwatcher = hs.screen.watcher.new(function()
  screens = hs.screen.allScreens()
end)
screenwatcher:start()

-- Construct list of screens
indexDiff = 0
for index=1,#hs.screen.allScreens() do
  local xIndex,yIndex = hs.screen.allScreens()[index]:position()
  screenArr[xIndex] = hs.screen.allScreens()[index]
end

-- Find lowest screen index, save to indexDiff if negative
hs.fnutils.each(screenArr, function(e)
  local currentIndex = hs.fnutils.indexOf(screenArr, e)
  if currentIndex < 0 and currentIndex < indexDiff then
    indexDiff = currentIndex
  end
end)

-- Set screen grid depending on resolution
  -- TODO: set grid according to pixels
for _index,screen in pairs(hs.screen.allScreens()) do
  if screen:frame().w / screen:frame().h > 2 then
    -- 10 * 4 for ultra wide screen
    grid.setGrid('10 * 4', screen)
  else
    if screen:frame().w < screen:frame().h then
      -- 4 * 8 for vertically aligned screen
      grid.setGrid('4 * 8', screen)
    else
      -- 8 * 4 for normal screen
      grid.setGrid('8 * 4', screen)
    end
  end
end

-- Some constructors, just for programming
function Cell(x, y, w, h)
  return hs.geometry(x, y, w, h)
end

-- Please leave a comment if you have any suggestions
-- I know this looks weird, but it works :C
current = {}
function init()
  current.win = hs.window.focusedWindow()
  current.scr = hs.window.focusedWindow():screen()
end

function current:new()
  init()
  o = {}
  setmetatable(o, self)
  o.window, o.screen = self.win, self.scr
  o.screenGrid = grid.getGrid(self.scr)
  o.windowGrid = grid.get(self.win)
  return o
end

-- -----------------------------------------------------------------------
--                   ** ALERT: GEEKS ONLY, GLHF  :C **                  --
--            ** Keybinding configurations locate at bottom **          --
-- -----------------------------------------------------------------------

local function maximizeWindow()
  local this = current:new()
  hs.grid.maximizeWindow(this.window)
end

local function centerOnScreen()
  local this = current:new()
  this.window:centerOnScreen(this.screen)
end

local function throwLeft()
  local this = current:new()
  this.window:moveOneScreenWest()
end

local function throwRight()
  local this = current:new()
  this.window:moveOneScreenEast()
end

local function leftHalf()
  local this = current:new()
  local cell = Cell(0, 0, 0.5 * this.screenGrid.w, this.screenGrid.h)
  grid.set(this.window, cell, this.screen)
  this.window.setShadows(true)
end

local function rightHalf()
  local this = current:new()
  local cell = Cell(0.5 * this.screenGrid.w, 0, 0.5 * this.screenGrid.w, this.screenGrid.h)
  grid.set(this.window, cell, this.screen)
end

-- Windows-like cycle left
local function cycleLeft()
  local this = current:new()
  -- Check if this window is on left or right
  if this.windowGrid.x == 0 then
    local currentIndex = hs.fnutils.indexOf(screenArr, current.scr)
    local previousScreen = screenArr[(currentIndex - indexDiff - 1) % 4 + indexDiff]
    this.window:moveToScreen(previousScreen)
    rightHalf()
  else 
    leftHalf()
  end
end

-- Windows-like cycle right
local function cycleRight()
  local this = current:new()
  -- Check if this window is on left or right
  if this.windowGrid.x == 0 then
    rightHalf()
  else
    local currentIndex = hs.fnutils.indexOf(screenArr, current.scr)
    local nextScreen = screenArr[(currentIndex - indexDiff + 1) % 4 + indexDiff]
    this.window:moveToScreen(nextScreen)
    leftHalf()
  end
end

local function topHalf()
  local this = current:new()
  local cell = Cell(0, 0, this.screenGrid.w, 0.5 * this.screenGrid.h)
  grid.set(this.window, cell, this.screen)
end

local function bottomHalf()
  local this = current:new()
  local cell = Cell(0, 0.5 * this.screenGrid.h, this.screenGrid.w, 0.5 * this.screenGrid.h)
  grid.set(this.window, cell, this.screen)
end

local function rightToLeft()
  local this = current:new()
  local cell = Cell(this.windowGrid.x, this.windowGrid.y, this.windowGrid.w - 1, this.windowGrid.h)
  if this.windowGrid.w > 1 then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Small Enough :)")
  end
end

local function rightToRight()
  local this = current:new()
  local cell = Cell(this.windowGrid.x, this.windowGrid.y, this.windowGrid.w + 1, this.windowGrid.h)
  if this.windowGrid.w < this.screenGrid.w - this.windowGrid.x then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Touching Right Edge :|")
  end
end

local function bottomUp()
  local this = current:new()
  local cell = Cell(this.windowGrid.x, this.windowGrid.y, this.windowGrid.w, this.windowGrid.h - 1)
  if this.windowGrid.h > 1 then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Small Enough :)")
  end
end

local function bottomDown()
  local this = current:new()
  local cell = Cell(this.windowGrid.x, this.windowGrid.y, this.windowGrid.w, this.windowGrid.h + 1)
  if this.windowGrid.h < this.screenGrid.h - this.windowGrid.y then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Touching Bottom Edge :|")
  end
end

local function leftToLeft()
  local this = current:new()
  local cell = Cell(this.windowGrid.x - 1, this.windowGrid.y, this.windowGrid.w + 1, this.windowGrid.h)
  if this.windowGrid.x > 0 then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Touching Left Edge :|")
  end
end

local function leftToRight()
  local this = current:new()
  local cell = Cell(this.windowGrid.x + 1, this.windowGrid.y, this.windowGrid.w - 1, this.windowGrid.h)
  if this.windowGrid.w > 1 then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Small Enough :)")
  end
end

local function topUp()
  local this = current:new()
  local cell = Cell(this.windowGrid.x, this.windowGrid.y - 1, this.windowGrid.w, this.windowGrid.h + 1)
  if this.windowGrid.y > 0 then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Touching Top Edge :|")
  end
end

local function topDown()
  local this = current:new()
  local cell = Cell(this.windowGrid.x, this.windowGrid.y + 1, this.windowGrid.w, this.windowGrid.h - 1)
  if this.windowGrid.h > 1 then
    grid.set(this.window, cell, this.screen)
  else
    hs.alert.show("Small Enough :)")
  end
end

-- -----------------------------------------------------------------------
--                           ** Key Binding **                          --
-- -----------------------------------------------------------------------
hk = require "hs.hotkey"
-- * Key Binding Utility
--- Bind hotkey for window management.
-- @function windowBind
-- @param {table} hyper - hyper key set
-- @param { ...{key=value} } keyFuncTable - multiple hotkey and function pairs
--   @key {string} hotkey
--   @value {function} callback function
local function windowBind(hyper, keyFuncTable)
  for key,fn in pairs(keyFuncTable) do
    hk.bind(hyper, key, fn)
  end
end

-- * Move window to screen
windowBind({"ctrl", "alt"}, {
  h = throwLeft,
  l = throwRight
})
-- * Set Window Position on screen
windowBind({"ctrl", "alt", "cmd"}, {
  m = maximizeWindow,    -- ⌃⌥⌘ + M
  c = centerOnScreen,    -- ⌃⌥⌘ + C
  h = leftHalf,       -- ⌃⌥⌘ + ←
  l = rightHalf,     -- ⌃⌥⌘ + →
  k = topHalf,          -- ⌃⌥⌘ + ↑
  j = bottomHalf      -- ⌃⌥⌘ + ↓
})
-- * Windows-like cycle
windowBind({"ctrl", "alt", "cmd"}, {
  u = cycleLeft,          -- ⌃⌥⌘ + u
  i = cycleRight          -- ⌃⌥⌘ + i
})
-- * Set Window Position on screen
windowBind({"ctrl", "alt", "shift"}, {
  h = rightToLeft,      -- ⌃⌥⇧ + ←
  l = rightToRight,    -- ⌃⌥⇧ + →
  k = bottomUp,           -- ⌃⌥⇧ + ↑
  j = bottomDown        -- ⌃⌥⇧ + ↓
})
-- * Set Window Position on screen
windowBind({"alt", "cmd", "shift"}, {
  h = leftToLeft,      -- ⌥⌘⇧ + ←
  l = leftToRight,    -- ⌥⌘⇧ + →
  k = topUp,             -- ⌥⌘⇧ + ↑
  j = topDown          -- ⌥⌘⇧ + ↓
})
