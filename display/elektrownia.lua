local monitor = peripheral.wrap("monitor_0")
local monX, monY = monitor.getSize()
monitor.setTextScale(1)

while true do
    monitor.clear()
    monitor.setCursorPos(2, 2)
    monitor.setTextColor(colors.yellow)
    monitor.write("Power Consumption:")

    monitor.setCursorPos(2, 4)
    monitor.setTextColor(colors.white)
    local powerUsage = math.random(50, 500) -- Replace with actual power reading
    monitor.write(tostring(powerUsage) .. " FE/t")
end