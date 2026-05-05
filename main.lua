local HttpService = game:GetService("HttpService")
local GAS_URL = "https://script.google.com/macros/s/AKfycbwuarn4WVPxClian1C_Jo6BxFrwyAsitj3tA_2P5XjiocaRmpmWwHnMwCaFnSGB8Kc/exec"

local functionList = {}
local seen = {}

-- 1. 地雷リスト（これを触るとエラーが出る可能性が高い）
local forbidden = {
    "getreg", "getrenv", "getrunningscripts", "getscripts",
    "getrawmetatable", "setrawmetatable", "getinstances", "getnilinstances",
    "hookfunction", "hookmetamethod", "debug"
}

local function isForbidden(name)
    for _, word in ipairs(forbidden) do
        if name:lower():find(word) then return true end
    end
    return false
end

-- 2. 収集
local targets = {getgenv(), getfenv(0)}
for _, env in ipairs(targets) do
    for name, value in pairs(env) do
        if type(name) == "string" and type(value) == "function" and not seen[name] then
            if not name:find("%.") and not name:match("^__") and not isForbidden(name) then
                table.insert(functionList, name)
                seen[name] = true
            end
        end
    end
end
table.sort(functionList)

print("地雷を避けた結果、" .. #functionList .. "個になったぜ。")

-- 3. 50個ずつ小分けにして送信（一度に送るとDeltaが怪しむため）
for i = 1, #functionList, 50 do
    local chunk = {}
    for j = i, math.min(i + 49, #functionList) do
        table.insert(chunk, functionList[j])
    end
    
    local payload = HttpService:JSONEncode({ functions = chunk })
    local success, response = pcall(function()
        return HttpService:PostAsync(GAS_URL, payload, Enum.HttpContentType.ApplicationJson)
    end)
    
    if success then
        print("第" .. i .. "〜着弾完了: " .. response)
    else
        warn("このグループで失敗: " .. tostring(response))
    end
    task.wait(1) -- GoogleとDeltaを怒らせないための休憩
end
