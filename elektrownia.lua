local basalt = require("basalt")

local main = basalt.createFrame():setTheme({FrameBG = colors.black, FrameFG = colors.lightGray})

window_x, window_y = main.getSize()

main:addLabel():setPosition(1, 1):setText("Aby wylogowac przytrzymaj CTRL+T")

local sub1 = main:addScrollableFrame():setDirection("vertical"):setSize(window_x/2, window_y-1):setPosition(1, 2)
local sub2 = main:addScrollableFrame():setDirection("vertical"):setSize(window_x/2, window_y-1):setPosition("parent.w/2+1", 2)

sub1:addButton():setPosition(2, 2):setText("Scrollable")
sub1:addButton():setPosition(2, 16):setText("Inside")
sub1:addButton():setPosition(2, 30):setText("Outside")

sub2:addButton():setPosition(2, 2):setText("Scrollable")
sub2:addButton():setPosition(2, 16):setText("Inside")
sub2:addButton():setPosition(2, 30):setText("Outside")

function centerText(text)
    term.clear()
    x, y = term.getSize()
    term.setCursorPos(x/2 - #text/2, y/2 + 1)
    term.write(text)
end

local old_pullEvent = os.pullEvent

while true do
    os.pullEvent = os.pullEventRaw
    centerText("Wymagane uwierzytelnienie")
    old_pullEvent("redstone")
    if redstone.getInput("right") then
        os.pullEvent = old_pullEvent
        basalt.autoUpdate()
        os.pullEvent = os.pullEventRaw
        centerText("Wylogowano")
        sleep(2)
    end
end