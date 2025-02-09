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
local generatorController = registerController(config.generatorControllerId)
local fuelFactoryController = registerController(config.fuelFactoryControllerId)

local basalt = require("basalt")

local main = basalt.createFrame():setTheme({FrameBG = colors.black, FrameFG = colors.lightGray})

window_x, window_y = main.getSize()

main:addLabel():setPosition(1, 1):setText("Aby wylogowac przytrzymaj CTRL+T")

local frame = main:addScrollableFrame():setDirection("vertical"):setSize("parent.w", "parent.h - 1"):setPosition(1, 2)

frame:addLabel():setPosition(1, 2):setText("Silnik:"):setForeground(colors.white):show()
frame:addLabel():setPosition(1, 6):setText("Generator:"):setForeground(colors.white):show()

engineStateLabel = frame:addLabel():setPosition(13, 2)
generatorStateLabel = frame:addLabel():setPosition(13, 6)

engineButton = frame:addButton():setPosition(24, 1)
generatorButton = frame:addButton():setPosition(24, 5)

engineButton:onClick(function(self,event,button,x,y)
        if(event=="mouse_click")and(button==1)then
            if engineState then
                setControllerState(generatorController, false)
                setControllerState(engineController, false)
            else
                setControllerState(engineController, true)
            end
        end
    end)
generatorButton:onClick(function(self,event,button,x,y)
        if(event=="mouse_click")and(button==1)then
            if generatorState then
                setControllerState(generatorController, false)
            else
                setControllerState(generatorController, true)
            end
        end
    end)

engineState = false
generatorState = false

local function updateThreadFunction()
    while true do
        engineState = getControllerState(engineController)
        generatorState = getControllerState(generatorController)
        if engineState then
            engineButton:setText("Wylacz")
            generatorButton:show()
            engineStateLabel:setText("Aktywny"):setForeground(colors.green)
        else
            engineButton:setText("Wlacz")
            generatorButton:hide()
            engineStateLabel:setText("Wylaczony"):setForeground(colors.red)
        end
        if generatorState then
            generatorButton:setText("Wylacz")
            generatorStateLabel:setText("Aktywny"):setForeground(colors.green)
        else
            generatorButton:setText("Wlacz")
            generatorStateLabel:setText("Wylaczony"):setForeground(colors.red)
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