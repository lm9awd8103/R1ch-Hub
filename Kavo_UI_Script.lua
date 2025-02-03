
local Kavo = {}
local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local Utility = {}
local Objects = {}

function Kavo:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}

local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = { Type = "Image", Image = "rbxassetid://8932053668", ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 0 },
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255, 255, 255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0, 0, 0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    },
}

local oldTheme = ""
local SettingsT = {}
local Name = "KavoConfig.JSON"
if not isfile("KavoConfig.JSON") then
    writefile(Name, "{}")
end
pcall(function()
    if not pcall(function()
        readfile(Name)
    end) then
        writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
    end
    Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

local LibName = "HubDestroyer"

function Kavo:ToggleUI()
    if game.CoreGui[LibName].Enabled then
        game.CoreGui[LibName].Enabled = false
    else
        game.CoreGui[LibName].Enabled = true
    end
end

function Kavo:BGLoader(id)
    for i, v in pairs(game.CoreGui:FindFirstChild("HubDestroyer"):GetDescendants()) do
        if v:IsA("TextButton") or v.Name == "MainHeader" or v.Name == "coverup" then
            v.BackgroundTransparency = v.BackgroundTransparency + .7
        else
            if v.Name:find("MainSide") or v.Name:find("sectionHead") or v.Name:find("sectionFrame") or v.Name == "Page" then
                v.BackgroundTransparency = .75
            end
        end
    end
    wait()
    local Fondo = Instance.new("ImageLabel", game.CoreGui:FindFirstChild("HubDestroyer").Main)
    Fondo.Image = "rbxassetid://" .. id
    Fondo.ZIndex = 0
    Fondo.Size = game.CoreGui:FindFirstChild("HubDestroyer").Main.Size
end

function Kavo.CreateLib()
    -- Add your function implementation here
end

return Kavo
