-- Floating labels at the buttom right corner of screen

local module = {}

local drawing = hs.drawing

local screenMargin = { x = 10, y = 10 }
local textPadding = { x = 4, y = 0 }
local bgMargin = { x = 7, y = 5 }

local textStyle = {
    size = 17,
    color = { white = 0.2, alpha = 1 },
    klignment = "center",
    lineBreak = "truncateTail",
}

local bgStyle = {
    fillColor = { white = 1, alpha = 0.7 },
}

local Label = {}
Label.__index = Label

function Label.new(message)
    local label = {}
    setmetatable(label, Label)
    label.message = message
    label.textFrame = drawing.getTextDrawingSize(message, textStyle)
    label.textFrame.w = label.textFrame.w + textPadding.x
    label.textFrame.h = label.textFrame.h + textPadding.y
    return label
end

function Label:show(duration)
    if self.textObj then
        return
    end
    local screen = hs.screen.mainScreen()
    local screenFrame = screen:fullFrame()

    local right = screenFrame.w - screenMargin.x
    local bottom = screenFrame.h - screenMargin.y

    local bgDisplayFrame = {
        x = right - self.textFrame.w - bgMargin.x * 2,
        y = bottom - self.textFrame.h - bgMargin.y * 2,
        w = self.textFrame.w + bgMargin.x * 2,
        h = self.textFrame.h + bgMargin.y * 2,
    }
    local textDisplayFrame = {
        x = right - self.textFrame.w - bgMargin.x,
        y = bottom - self.textFrame.h - bgMargin.y,
        w = self.textFrame.w,
        h = self.textFrame.h,
    }

    self.bgObj = drawing.rectangle(bgDisplayFrame)
            :setStroke(false)
            :setFill(true)
            :setFillColor(bgStyle.fillColor)
            :setRoundedRectRadii(5, 5)
            :show(0.15)
    self.textObj = drawing.text(textDisplayFrame, self.message)
            :setTextStyle(textStyle)
            :show(0.15)

    if duration then
        hs.timer.doAfter(duration, function() self:hide() end)
    end
end

function Label:hide()
    if self.bgObj then
        self.bgObj:delete()
        self.bgObj = nil
    end
    if self.textObj then
        self.textObj:delete()
        self.textObj = nil
    end
end

module.new = function(message, duration)
    return Label.new(message, duration)
end

return module
