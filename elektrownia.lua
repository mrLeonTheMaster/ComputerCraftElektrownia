function registerController(id)
    return peripheral.wrap("redrouter_" .. tostring(id))
end
function setControllerState(controller, state)
    controller.setOutput("bottom", state)
end
function getControllerState(controller)
    return controller.getOutput("bottom")
end

local engineController = registerController(7)
local energyGeneratorController = registerController(6)
local fuelFactoryController = registerController(9)

local basalt = require("basalt")

local main = basalt.createFrame():setTheme({FrameBG = colors.black, FrameFG = colors.lightGray})

window_x, window_y = main.getSize()

main:addLabel():setPosition(1, 1):setText("Aby wylogowac przytrzymaj CTRL+T")

local frame = main:addScrollableFrame():setDirection("vertical"):setSize("parent.w", "parent.h - 1"):setPosition(1, 2)

frame:addButton():setPosition(2, 2):setText("Scrollable")
frame:addButton():setPosition(2, 16):setText("Inside")
frame:addButton():setPosition(2, 30):setText("Outside")

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