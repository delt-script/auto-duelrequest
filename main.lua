-- FULL GUI SCRIPT (OPTIMIZED FINAL)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.DisplayOrder = 9999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 100

-- 紫枠
local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Parent = MainFrame
UIStrokeMain.Thickness = 3
UIStrokeMain.Color = Color3.fromRGB(170, 0, 255)
UIStrokeMain.Transparency = 0.2

-- ボタン（中央）
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.Size = UDim2.new(0, 260, 0, 70)
ToggleButton.Position = UDim2.new(0.5, -130, 0.5, -35)
ToggleButton.Text = "auto duel joiner"
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.ZIndex = 200

-- ボタン枠
local UIStrokeBtn = Instance.new("UIStroke")
UIStrokeBtn.Parent = ToggleButton
UIStrokeBtn.Thickness = 2
UIStrokeBtn.Color = Color3.fromRGB(255,255,255)
UIStrokeBtn.Transparency = 0.5

-- ランダム文字（ボタン下）
local ActivityText = Instance.new("TextLabel")
ActivityText.Parent = MainFrame
ActivityText.Size = UDim2.new(0, 320, 0, 20)
ActivityText.Position = UDim2.new(0.5, -160, 0.5, 45)
ActivityText.BackgroundTransparency = 1
ActivityText.TextSize = 14
ActivityText.Font = Enum.Font.Code
ActivityText.TextColor3 = Color3.fromRGB(120, 120, 120)
ActivityText.TextTransparency = 0.3
ActivityText.Text = ""
ActivityText.Visible = false
ActivityText.ZIndex = 300

-- 状態
local isOn = false
local justEnabled = false

ToggleButton.MouseButton1Click:Connect(function()
	isOn = not isOn

	if isOn then
		ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		ActivityText.Visible = true
		justEnabled = true
	else
		ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		ToggleButton.Text = "auto duel joiner"
		ActivityText.Visible = false
		ActivityText.Text = ""
	end
end)

-- ランダム生成
local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

local function randomString(len)
	local result = table.create(len)
	for i = 1, len do
		local rand = math.random(1, #chars)
		result[i] = chars:sub(rand, rand)
	end
	return table.concat(result)
end

-- メインループ（軽量化）
task.spawn(function()
	local dots = 0

	while true do
		if isOn then
			-- 初回だけ loading
			if justEnabled then
				for i = 1, 4 do
					if not isOn then break end
					ActivityText.Text = "loading" .. string.rep(".", (i % 3) + 1)
					task.wait(0.4)
				end
				justEnabled = false
			end

			-- findingアニメ
			dots = (dots % 3) + 1
			local text = "finding" .. string.rep(".", dots)
			ToggleButton.Text = text

			-- ランダム文字（ランダム間隔）
			ActivityText.Text = randomString(20)

			task.wait(math.random(10, 60) / 100) -- 0.1〜0.6秒
		else
			task.wait(0.2)
		end
	end
end)

-- Loading画面（12秒）
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = ScreenGui
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LoadingFrame.ZIndex = 500

local LoadingText = Instance.new("TextLabel")
LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 0.1, 0)
LoadingText.Position = UDim2.new(0, 0, 0.4, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading"
LoadingText.TextScaled = true
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.TextColor3 = Color3.fromRGB(255,255,255)
LoadingText.ZIndex = 501

local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Parent = LoadingFrame
LoadingBarBG.Size = UDim2.new(0.6, 0, 0.03, 0)
LoadingBarBG.Position = UDim2.new(0.2, 0, 0.55, 0)
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadingBarBG.ZIndex = 501

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarBG
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoadingBar.ZIndex = 502

task.spawn(function()
	local duration = 12
	local steps = 240
	local waitTime = duration / steps

	for i = 1, steps do
		LoadingBar.Size = UDim2.new(i/steps, 0, 1, 0)

		local dots = string.rep(".", (i % 3) + 1)
		LoadingText.Text = "Loading" .. dots

		-- ほんのり脈打ち
		LoadingBar.BackgroundTransparency = math.sin(i/10) * 0.2

		task.wait(waitTime)
	end

	LoadingFrame:Destroy()
end)

print("GUI Loaded")
