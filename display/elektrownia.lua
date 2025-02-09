function registerController(id)
    return peripheral.wrap("redrouter_" .. tostring(id))
end
function getControllerState(controller)
    return controller.getOutput("bottom")
end

local config = require("elektrownia-config")

local engineController = registerController(config.engineControllerId)
local energyGeneratorController = registerController(config.energyGeneratorControllerId)
local fuelFactoryController = registerController(config.fuelFactoryControllerId)

local monitor = peripheral.wrap("monitor_0")
local monX, monY = monitor.getSize()
monitor.setTextScale(1)

print("Uruchomiono.")

while true do
    monitor.clear()
    monitor.setCursorPos(1, 1)
    if getControllerState(engineController) then
        if getControllerState(energyGeneratorController) then
            monitor.setTextColor(colors.green)
            monitor.write("Silnik i generator aktywny")
        else
            monitor.setTextColor(colors.yellow)
            monitor.write("Silnik aktywny")
        end
    else
        monitor.setTextColor(colors.red)
        monitor.write("Silnik wylaczony")
    end
    sleep(1)
end