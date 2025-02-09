local message = ""
if not fs.exists("/basalt.lua") then
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
end
shell.run("wget https://github.com/mrLeonTheMaster/ComputerCraftElektrownia/raw/refs/heads/main/elektrownia.lua")
if fs.exists("/startup.lua") then
    fs.move("/startup.lua", "/startup_old.lua")
    message = message .. "startup.lua already exists, moved to startup_old.lua. "
end
shell.run("wget https://github.com/mrLeonTheMaster/ComputerCraftElektrownia/raw/refs/heads/main/startup.lua")
shell.run("set motd.enable false")
print("\n\n\n\n" .. message)
print("Do you want to reboot? (y/n)")
while true do
    local event, key = os.pullEvent("key")
    if key == keys.y then
        os.reboot()
    elseif key == keys.n then
        break
    else:
        print("Press y or n")
    end
end
