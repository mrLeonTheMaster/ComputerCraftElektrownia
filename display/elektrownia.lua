function registerController(id)
    return peripheral.wrap("redrouter_" .. tostring(id))
end
function getControllerState(controller)
    return controller.getOutput("bottom")
end

local config = require("elektrownia-config")

local engineController = registerController(config.engineControllerId)
local generatorController = registerController(config.generatorControllerId)
local fuelFactoryController = registerController(config.fuelFactoryControllerId)

local monitor = peripheral.wrap("monitor_0")
local monX, monY = monitor.getSize()
monitor.setTextScale(1)

print("Uruchomiono.")

while true do
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.setTextColor(colors.white)
    monitor.write("Silnik: ")
    if getControllerState(engineController) then
        monitor.setTextColor(colors.green)
        monitor.write("aktywny")
    else
        monitor.setTextColor(colors.red)
        monitor.write("wylaczony")
    end
    monitor.setCursorPos(1, 2)
    monitor.setTextColor(colors.white)
    monitor.write("Generator pradu: ")
    if getControllerState(generatorController) then
        monitor.setTextColor(colors.green)
        monitor.write("aktywny")
    else
        monitor.setTextColor(colors.red)
        monitor.write("wylaczony")
    end
    sleep(0.5)
end