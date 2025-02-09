local old_pullEvent = os.pullEvent
os.pullEvent = os.pullEventRaw
if redstone.getInput("right") then
    os.pullEvent = old_pullEvent
else
    shell.run("elektrownia")
end
