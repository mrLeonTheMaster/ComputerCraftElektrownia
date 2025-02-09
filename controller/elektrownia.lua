function registerController(id)
    return peripheral.wrap("redrouter_" .. tostring(id))
end
function setControllerState(controller, state)
    controller.setOutput("bottom", state)
end
function getControllerState(controller)
    return controller.getOutput("bottom")
end
function toggleControllerState(controller)
    controller.setOutput("bottom", not controller.getOutput("bottom"))
end

local config = require("elektrownia-config")

local engineController = registerController(config.engineControllerId)
local energyGeneratorController = registerController(config.energyGeneratorControllerId)
local fuelFactoryController = registerController(config.fuelFactoryControllerId)

local basalt = require("basalt")

local main = basalt.createFrame():setTheme({FrameBG = colors.black, FrameFG = colors.lightGray})

window_x, window_y = main.getSize()

main:addLabel():setPosition(1, 1):setText("Aby wylogowac przytrzymaj CTRL+T")

local frame = main:addScrollableFrame():setDirection("vertical"):setSize("parent.w", "parent.h - 1"):setPosition(1, 2)

button1 = frame:addButton():setPosition(1, 1):setText("Silnik")
button2 = frame:addButton():setPosition(1, 2):setText("Generator")

button1:onClick(function(self,event,button,x,y)
    if(event=="mouse_click")and(button==1)then
      setControllerState(engineController)
    end
  end)

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