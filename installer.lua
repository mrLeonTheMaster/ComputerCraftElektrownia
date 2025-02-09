print("Do you want to install:\n1) controller\n2)display")
while true do
    print("Press 1 or 2")
    local event, key = os.pullEvent("key")
    if key == keys.1 then
        local type = "controller"
        break
    elseif key == keys.2 then
        local type = "display"
        break
    end
end
local base_url = "https://github.com/mrLeonTheMaster/ComputerCraftElektrownia/raw/refs/heads/main/"
local message = ""
if (type == 1 and not fs.exists("/basalt.lua")) then
    shell.run("wget run https://basalt.madefor.cc/install.lua packed")
    message = message .. "Installed basalt. "
end
if fs.exists("/elektrownia.lua") then
    if fs.exists("/elektrownia_old") then
        fs.delete("/elektrownia_old")
    end
    fs.makeDir("/elektrownia_old")
    fs.move("/elektrownia.lua", "/elektrownia_old/elektrownia.lua")
    fs.move("/startup.lua", "/elektrownia_old/startup.lua")
    message = message .. "Updated the program, old version moved to elektrownia_old/. "
else
    shell.run("wget " .. base_url .. "/elektrownia-config.lua")
    message = message .. "Installed the program. "
end
shell.run("wget " .. base_url .. type .. "/elektrownia.lua")
if fs.exists("/startup.lua") then
    fs.move("/startup.lua", "/startup_old.lua")
    message = message .. "startup.lua already exists, moved to startup_old.lua. "
end
shell.run("wget " .. base_url .. type .. "/startup.lua")
shell.run("set motd.enable false")
print("\n\n\n\n" .. message)
print("Do you want to configure the program? (y/n)")
while true do
    local event, key = os.pullEvent("key")
    if key == keys.y then
        shell.run("edit /elektrownia-config.lua")
        break
    elseif key == keys.n then
        break
    else
        print("Press y or n")
    end
end
print("The config is in /elektrownia-config.lua")
print("Do you want to reboot? (y/n)")
while true do
    local event, key = os.pullEvent("key")
    if key == keys.y then
        os.reboot()
    elseif key == keys.n then
        break
    else
        print("Press y or n")
    end
end
