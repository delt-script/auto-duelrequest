-- Base GUI (Full Screen Frame)
-- Delta / Luau compatible

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.DisplayOrder = 9999999 -- stronger priority
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 100

-- Purple border
local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Parent = MainFrame
UIStrokeMain.Thickness = 2
UIStrokeMain.Color = Color3.fromRGB(170, 0, 255)

-- Toggle Button (above center)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.Size = UDim2.new(0, 220, 0, 60)
ToggleButton.Position = UDim2.new(0.5, -110, 0.35, -30)
ToggleButton.Text = "auto join duel"
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.ZIndex = 200

local isOn = false

-- Center Finding Text
local FindingText = Instance.new("TextLabel")
FindingText.Parent = MainFrame
FindingText.Size = UDim2.new(1, 0, 0.1, 0)
FindingText.Position = UDim2.new(0, 0, 0.5, -20)
FindingText.BackgroundTransparency = 1
FindingText.Text = ""
FindingText.TextScaled = true
FindingText.Font = Enum.Font.SourceSansBold
FindingText.TextColor3 = Color3.fromRGB(255,255,255)
FindingText.ZIndex = 200

-- Activity Text (subtle, below)
local ActivityText = Instance.new("TextLabel")
ActivityText.Parent = MainFrame
ActivityText.Size = UDim2.new(0, 300, 0, 20)
ActivityText.Position = UDim2.new(0.5, -150, 0.62, 20)
ActivityText.BackgroundTransparency = 1
ActivityText.TextScaled = false
ActivityText.TextSize = 14
ActivityText.Font = Enum.Font.Code
ActivityText.TextColor3 = Color3.fromRGB(120, 120, 120)
ActivityText.Text = ""
ActivityText.Visible = false
ActivityText.ZIndex = 200

ToggleButton.MouseButton1Click:Connect(function()
    isOn = not isOn

    if isOn then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        ActivityText.Visible = true
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        ActivityText.Visible = false
        ActivityText.Text = ""
        FindingText.Text = ""
    end
end)

-- Random string generator
local chars = "abcdefghijklmnopqrstuvwxyz0123456789"

local function randomString(length)
    local str = ""
    for i = 1, length do
        local rand = math.random(1, #chars)
        str = str .. string.sub(chars, rand, rand)
    end
    return str
end

-- Activity loop
spawn(function()
    while true do
        if isOn then
            ActivityText.Text = randomString(20)
        end
        task.wait(0.5)
    end
end)

-- Finding animation
spawn(function()
    while true do
        if isOn then
            for i = 1, 3 do
                FindingText.Text = "finding" .. string.rep(".", i)
                task.wait(0.4)
            end
        else
            task.wait(0.2)
        end
    end
end)

-- Loading Screen
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

spawn(function()
    local duration = 7
    local steps = 140
    local waitTime = duration / steps

    for i = 1, steps do
        LoadingBar.Size = UDim2.new(i/steps, 0, 1, 0)
        local dots = string.rep(".", (i % 3) + 1)
        LoadingText.Text = "Loading" .. dots
        task.wait(waitTime)
    end

    LoadingFrame:Destroy()
end)

print("GUI Loaded")
