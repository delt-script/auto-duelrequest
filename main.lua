-- Base GUI (Adjusted Frame + Improvements)
        else
            task.wait(0.2)
        end
    end
end)

-- Loading Screen (12 seconds)
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
    local duration = 12
    local steps = 240
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
