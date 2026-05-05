local HttpService = game:GetService("HttpService")
local GAS_URL = "https://script.google.com/macros/s/AKfycbx-h41M4Pi9uRRvqCfWQlqJjNuYfiG_IpkOwsoZdngOd1nf6ZyIakt7BZL9vXwh-zBl/exec"

local functionList = {}
local seen = {}

-- 193個に絞り込む厳選ロジック
local targets = {getgenv(), getfenv(0)}
for _, env in ipairs(targets) do
    for name, value in pairs(env) do
        if type(name) == "string" and type(value) == "function" and not seen[name] then
            if not name:find("%.") and not name:match("^__") then
                table.insert(functionList, name)
                seen[name] = true
            end
        end
    end
end
table.sort(functionList)

local payload = HttpService:JSONEncode({ functions = functionList })

-- 送信（第3引数にApplicationJsonを指定してPOSTを安定させる）
local success, response = pcall(function()
    return HttpService:PostAsync(GAS_URL, payload, Enum.HttpContentType.ApplicationJson)
end)

if success then
    print("【成功】 " .. #functionList .. " 個着弾！応答: " .. response)
else
    warn("【失敗】 " .. tostring(response))
end
