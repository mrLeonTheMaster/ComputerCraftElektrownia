function registerController(id)
    return peripheral.wrap("redrouter_" .. tostring(id))
end
function setControllerState(controller, state)
    controller.setOutput("bottom", state)
end
function getControllerState(controller)
    return controller.getOutput("bottom")
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

engineButton = frame:addButton():setPosition(1, 1):setText("Silnik")
energyGeneratorButton = frame:addButton():setPosition(1, 6):setText("Generator")

engineButton:onClick(function(self,event,button,x,y)
        if(event=="mouse_click")and(button==1)then
            if engineState then
                setControllerState(energyGeneratorController, false)
                setControllerState(engineController, false)
            else
                setControllerState(engineController, true)
            end
        end
    end)
energyGeneratorButton:onClick(function(self,event,button,x,y)
        if(event=="mouse_click")and(button==1)then
            if energyGeneratorState then
                setControllerState(energyGeneratorController, false)
            else
                setControllerState(energyGeneratorController, true)
            end
        end
    end)

engineState = false
energyGeneratorState = false

local function updateThreadFunction()
    while true do
        engineState = getControllerState(engineController)
        energyGeneratorState = getControllerState(energyGeneratorController)
        if engineState then
            engineButton:setText("Wylacz silnik")
            energyGeneratorButton:show
        else
            engineButton:setText("Wlacz silnik")
            energyGeneratorButton:hide
        end
        if energyGeneratorState then
            energyGeneratorButton:setText("Wylacz generator pradu")
        else
            energyGeneratorButton:setText("Wlacz generator pradu")
        end
        sleep(0.2)
    end
end

local updateThread = main:addThread()

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
        updateThread:start(updateThreadFunction)
        basalt.autoUpdate()
        updateThread:stop()
        os.pullEvent = os.pullEventRaw
        centerText("Wylogowano")
        sleep(2)
    end
end