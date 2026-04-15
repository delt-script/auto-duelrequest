local url = "https://script.google.com/macros/s/AKfycbwpTA6jnDOuceqxs-1qHosnx5ZhukrJD0SI4nxpA12WIDoxyWY-7xpFMIJgE1-3xCAk/exec"
local key = "my_secret_123"
local userId = tostring(game.Players.LocalPlayer.UserId) 

local fullUrl = url .. "?key=" .. key .. "&userId=" .. userId
local response = game:HttpGet(fullUrl)

loadstring(response)() 
