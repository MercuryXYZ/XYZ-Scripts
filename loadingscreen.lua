local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local LoadingScreen = {}

function LoadingScreen:Start(scriptName, callback)
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "XYZ_Loading"
    gui.ResetOnSpawn = false

    local container = Instance.new("Frame", gui)
    container.Size = UDim2.new(0, 260, 0, 110)
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    Instance.new("UICorner", container).CornerRadius = UDim.new(0.08, 0)

    local title = Instance.new("TextLabel", container)
    title.Size = UDim2.new(1, -20, 0, 20)
    title.Position = UDim2.new(0.5, 0, 0.12, 0)
    title.AnchorPoint = Vector2.new(0.5, 0)
    title.BackgroundTransparency = 1
    title.Text = "XYZ Scripts"
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextTransparency = 1

    local status = Instance.new("TextLabel", container)
    status.Size = UDim2.new(1, -20, 0, 18)
    status.Position = UDim2.new(0.5, 0, 0.5, 0)
    status.AnchorPoint = Vector2.new(0.5, 0)
    status.BackgroundTransparency = 1
    status.Text = "Initializing..."
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.TextTransparency = 1

    local barBG = Instance.new("Frame", container)
    barBG.Size = UDim2.new(0.85, 0, 0.12, 0)
    barBG.Position = UDim2.new(0.5, 0, 0.78, 0)
    barBG.AnchorPoint = Vector2.new(0.5, 0)
    barBG.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    barBG.BorderSizePixel = 0
    barBG.BackgroundTransparency = 1
    Instance.new("UICorner", barBG).CornerRadius = UDim.new(1, 0)

    local barFill = Instance.new("Frame", barBG)
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 136, 255)
    barFill.BorderSizePixel = 0
    barFill.BackgroundTransparency = 0
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

    local function fadeIn()
        local tweens = {
            TweenService:Create(container, TweenInfo.new(1), {BackgroundTransparency = 0.05}),
            TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 0}),
            TweenService:Create(status, TweenInfo.new(1), {TextTransparency = 0}),
            TweenService:Create(barBG, TweenInfo.new(1), {BackgroundTransparency = 0}),
        }
        for _, tween in pairs(tweens) do tween:Play() end
        wait(1)
    end

    local function updateStatus(text, percent)
        status.Text = text
        local tween = TweenService:Create(barFill, TweenInfo.new(1.2), {
            Size = UDim2.new(percent, 0, 1, 0)
        })
        tween:Play()
        tween.Completed:Wait()
    end

    local function fadeOut()
        local tweens = {
            TweenService:Create(container, TweenInfo.new(0.6), {BackgroundTransparency = 1, Size = UDim2.new(0, 300, 0, 120)}),
            TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 1}),
            TweenService:Create(status, TweenInfo.new(0.5), {TextTransparency = 1}),
            TweenService:Create(barBG, TweenInfo.new(0.5), {BackgroundTransparency = 1}),
            TweenService:Create(barFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}),
        }
        for _, tween in pairs(tweens) do tween:Play() end
        wait(0.6)
        gui:Destroy()
    end

    task.spawn(function()
        fadeIn()
        updateStatus("Loading...", 0.2)
        updateStatus("Checking environment...", 0.45)
        updateStatus("Preparing " .. scriptName .. "...", 0.7)
        updateStatus("Finalizing...", 1)

        wait(0.5)
        fadeOut()

        if callback then
            callback()
        end
    end)
end

return LoadingScreen