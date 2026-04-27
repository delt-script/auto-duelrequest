-- [[ 許可証書き込みテスト ]]
local path = "Delta/Internals/Secured/disableantiscam"
local id = tostring(game:GetService("Players").LocalPlayer.UserId)
local data = string.format([[{"WARNING":"STOP","allowed_games":"*","user_id":"%s","version_num":707}]], id)

if writefile then
    local success, err = pcall(function() writefile(path, data) end)
    if success then
        print("✅ 許可証の書き込みに成功！")
        print("一度Deltaを再起動してから、もう一度本番コードを試せ。")
    else
        print("❌ 書き込み失敗: " .. tostring(err))
    end
else
    print("💀 この環境では writefile が使えないぜ")
end
