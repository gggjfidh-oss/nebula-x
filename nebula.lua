-- Nebula X V2.5 // Ultimate Supreme + HitSound & FOV Changer
if getgenv and getgenv().LoadedCheat then
    pcall(function() getgenv().LoadedCheat:Disconnect() end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Settings = {
    ESP_Boxes = false, ESP_Chams = false, ESP_Names = false, ESP_Health = false, ESP_Distance = false, ESP_Rainbow = false, ESP_TeamCheck = true,
    Aimbot = false, AimBotNPC = false, TriggerBot = false, ShowFOV = false, HitBoxExpander = false, WallCheck = false, AimPart = "Head", 
    Smoothness = 3, FOV = 150, GameFOV = 70, HitSound = false,
    Speed = false, SpeedMultiplier = 0.6, Jump = false, InfiniteJump = false, Bhop = false,
    Fly = false, FlySpeed = 1, Noclip = false, WaterWalk = false, InfiniteZoom = false, NightVision = false, Freecam = false,
    GodMode = false, AntiVoid = false, AutoRespawn = false, AntiAFK = true, AntiRagdoll = false, TrueInvis = false, ClickTP = false, AutoClicker = false, SpinBot = false, Fullbright = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NebulaXV2_5"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Transparency = 0.7
FOVCircle.Thickness = 1.5
FOVCircle.Color = Color3.fromRGB(220, 80, 255)
FOVCircle.Filled = false

local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = obj.Position
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 390)
Main.Position = UDim2.new(0.5, -260, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(220, 80, 255)
makeDraggable(Main)

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45) ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32) ToggleBtn.Text = "N"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0) ToggleBtn.TextSize = 20
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
makeDraggable(ToggleBtn)
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local AimBtn = Instance.new("TextButton", ScreenGui)
AimBtn.Size = UDim2.new(0, 45, 0, 45) AimBtn.Position = UDim2.new(0.85, 0, 0.30, 0)
AimBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 38) AimBtn.Text = "🎯" AimBtn.TextSize = 18
Instance.new("UICorner", AimBtn).CornerRadius = UDim.new(1, 0)
local aimStroke = Instance.new("UIStroke", AimBtn) aimStroke.Color = Color3.fromRGB(0, 255, 120)
makeDraggable(AimBtn)
AimBtn.MouseButton1Click:Connect(function()
    Settings.Aimbot = not Settings.Aimbot
    AimBtn.BackgroundColor3 = Settings.Aimbot and Color3.fromRGB(30, 180, 90) or Color3.fromRGB(25, 25, 38)
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -30, 0, 32) Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1 Title.Text = "🔮 NEBULA X // V2.5 SUPREME"
Title.TextColor3 = Color3.fromRGB(240, 220, 255) Title.TextSize = 11 Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local StatsLabel = Instance.new("TextLabel", Main)
StatsLabel.Size = UDim2.new(0, 120, 0, 32) StatsLabel.Position = UDim2.new(1, -145, 0, 0)
StatsLabel.BackgroundTransparency = 1 StatsLabel.Text = "FPS: 60 | Ping: 0ms"
StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 150) StatsLabel.TextSize = 9 StatsLabel.Font = Enum.Font.GothamBold
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 24, 0, 24) Close.Position = UDim2.new(1, -28, 0, 4)
Close.BackgroundColor3 = Color3.fromRGB(220, 50, 70) Close.Text = "✕" Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, 0, 0, 38) TabBar.Position = UDim2.new(0, 0, 0, 32)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 15, 30) TabBar.BorderSizePixel = 0

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.Padding = UDim.new(0, 4)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -16, 1, -80) Container.Position = UDim2.new(0, 8, 0, 74)
Container.BackgroundTransparency = 1

local pages = {}
local function createTab(name, icon)
    local page = Instance.new("ScrollingFrame", Container)
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 1500) page.ScrollBarThickness = 3
    
    local layout = Instance.new("UIListLayout", page) layout.Padding = UDim.new(0, 6)

    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0, 70, 1, -4) btn.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    btn.Text = icon .. " " .. name btn.TextColor3 = Color3.fromRGB(240, 240, 250) btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
    pages[name] = page
    return page
end

local function addToggle(page, name, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, -4, 0, 32) btn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
    btn.Text = "  " .. name .. ": [OFF]" btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.TextSize = 10 btn.Font = Enum.Font.GothamBold btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn) stroke.Color = Color3.fromRGB(180, 100, 255)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(20, 160, 80) or Color3.fromRGB(25, 20, 40)
        btn.Text = "  " .. name .. ": " .. (state and "[ON]" or "[OFF]")
        stroke.Color = state and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(180, 100, 255)
        pcall(function() callback(state) end)
    end)
end

-- Вкладка ESP
local tabESP = createTab("ESP", "👁️")
addToggle(tabESP, "Boxes (Подсветка тел)", function(v) Settings.ESP_Boxes = v end)
addToggle(tabESP, "Chams (Рентген сквозь стены)", function(v) Settings.ESP_Chams = v end)
addToggle(tabESP, "Rainbow ESP (Радужная подсветка)", function(v) Settings.ESP_Rainbow = v end)
addToggle(tabESP, "Names (Никнеймы над головой)", function(v) Settings.ESP_Names = v end)
addToggle(tabESP, "Health (Здоровье игроков)", function(v) Settings.ESP_Health = v end)
addToggle(tabESP, "Distance (Дистанция в метрах)", function(v) Settings.ESP_Distance = v end)
addToggle(tabESP, "Team Check", function(v) Settings.ESP_TeamCheck = v end)

-- Вкладка AIM (Добавлен HitSound)
local tabAim = createTab("AIM", "🎯")
addToggle(tabAim, "Aimbot (Аим по игрокам)", function(v) Settings.Aimbot = v end)
addToggle(tabAim, "AimBot NPC (Аим по ботам)", function(v) Settings.AimBotNPC = v end)
addToggle(tabAim, "TriggerBot (Автовыстрел)", function(v) Settings.TriggerBot = v end)
addToggle(tabAim, "HitSound (Звук при попадании)", function(v) Settings.HitSound = v end)
addToggle(tabAim, "Show FOV Circle (Показывать круг FOV)", function(v) Settings.ShowFOV = v FOVCircle.Visible = v end)
addToggle(tabAim, "HitBox Expander (Увеличение целей)", function(v) Settings.HitBoxExpander = v end)
addToggle(tabAim, "WallCheck (Проверка стен)", function(v) Settings.WallCheck = v end)

local smoothBtn = Instance.new("TextButton", tabAim)
smoothBtn.Size = UDim2.new(1, -4, 0, 32) smoothBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
smoothBtn.Text = "  ⚡ Скорость аима: [Быстро]" smoothBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
smoothBtn.TextSize = 10 smoothBtn.Font = Enum.Font.GothamBold smoothBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", smoothBtn).CornerRadius = UDim.new(0, 6)
smoothBtn.MouseButton1Click:Connect(function()
    if Settings.Smoothness == 3 then
        Settings.Smoothness = 1.5 smoothBtn.Text = "  ⚡ Скорость аима: [Молниеносно]"
    elseif Settings.Smoothness == 1.5 then
        Settings.Smoothness = 6 smoothBtn.Text = "  ⚡ Скорость аима: [Плавно]"
    else
        Settings.Smoothness = 3 smoothBtn.Text = "  ⚡ Скорость аима: [Быстро]"
    end
end)

local fovBtn = Instance.new("TextButton", tabAim)
fovBtn.Size = UDim2.new(1, -4, 0, 32) fovBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
fovBtn.Text = "  ⭕ Радиус FOV: [150]" fovBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fovBtn.TextSize = 10 fovBtn.Font = Enum.Font.GothamBold fovBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", fovBtn).CornerRadius = UDim.new(0, 6)
fovBtn.MouseButton1Click:Connect(function()
    if Settings.FOV == 150 then
        Settings.FOV = 250 fovBtn.Text = "  ⭕ Радиус FOV: [250]"
        FOVCircle.Radius = 250
    elseif Settings.FOV == 250 then
        Settings.FOV = 9999 fovBtn.Text = "  ⭕ Радиус FOV: [Вся карта]"
        FOVCircle.Radius = 600
    else
        Settings.FOV = 150 fovBtn.Text = "  ⭕ Радиус FOV: [150]"
        FOVCircle.Radius = 150
    end
end)

-- Вкладка UTILS (Добавлен FOV Changer камеры)
local tabUtils = createTab("UTILS", "⚙️")
addToggle(tabUtils, "Speedhack (Ускорение бега)", function(v) Settings.Speed = v end)

local speedBtn = Instance.new("TextButton", tabUtils)
speedBtn.Size = UDim2.new(1, -4, 0, 32) speedBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
speedBtn.Text = "  👟 Скорость: [Нормальная (0.6)]" speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 10 speedBtn.Font = Enum.Font.GothamBold speedBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 6)
speedBtn.MouseButton1Click:Connect(function()
    if Settings.SpeedMultiplier == 0.6 then
        Settings.SpeedMultiplier = 1.2 speedBtn.Text = "  👟 Скорость: [Турбо (1.2)]"
    elseif Settings.SpeedMultiplier == 1.2 then
        Settings.SpeedMultiplier = 2.5 speedBtn.Text = "  👟 Скорость: [Супер (2.5)]"
    else
        Settings.SpeedMultiplier = 0.6 speedBtn.Text = "  👟 Скорость: [Нормальная (0.6)]"
    end
end)

addToggle(tabUtils, "JumpPower (Высокий прыжок)", function(v) Settings.Jump = v end)
addToggle(tabUtils, "Infinite Jump (Беск. прыжки)", function(v) Settings.InfiniteJump = v end)
addToggle(tabUtils, "Bhop (Авто-распрыжка)", function(v) Settings.Bhop = v end)
addToggle(tabUtils, "Fly (Полет)", function(v) Settings.Fly = v end)

local flySpeedBtn = Instance.new("TextButton", tabUtils)
flySpeedBtn.Size = UDim2.new(1, -4, 0, 32) flySpeedBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
flySpeedBtn.Text = "  ✈️ Скорость полета: [1x]" flySpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedBtn.TextSize = 10 flySpeedBtn.Font = Enum.Font.GothamBold flySpeedBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", flySpeedBtn).CornerRadius = UDim.new(0, 6)
flySpeedBtn.MouseButton1Click:Connect(function()
    if Settings.FlySpeed == 1 then
        Settings.FlySpeed = 2.5 flySpeedBtn.Text = "  ✈️ Скорость полета: [2.5x]"
    elseif Settings.FlySpeed == 2.5 then
        Settings.FlySpeed = 5 flySpeedBtn.Text = "  ✈️ Скорость полета: [5x]"
    else
        Settings.FlySpeed = 1 flySpeedBtn.Text = "  ✈️ Скорость полета: [1x]"
    end
end)

addToggle(tabUtils, "Noclip (Сквозь стены)", function(v) Settings.Noclip = v end)

local gameFovBtn = Instance.new("TextButton", tabUtils)
gameFovBtn.Size = UDim2.new(1, -4, 0, 32) gameFovBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
gameFovBtn.Text = "  🔭 Обзор камеры (Game FOV): [70]" gameFovBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
gameFovBtn.TextSize = 10 gameFovBtn.Font = Enum.Font.GothamBold gameFovBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", gameFovBtn).CornerRadius = UDim.new(0, 6)
gameFovBtn.MouseButton1Click:Connect(function()
    if Settings.GameFOV == 70 then
        Settings.GameFOV = 95 gameFovBtn.Text = "  🔭 Обзор камеры: [95 (Широкий)]"
    elseif Settings.GameFOV == 95 then
        Settings.GameFOV = 120 gameFovBtn.Text = "  🔭 Обзор камеры: [120 (Максимум)]"
    else
        Settings.GameFOV = 70 gameFovBtn.Text = "  🔭 Обзор камеры: [70]"
    end
end)

addToggle(tabUtils, "Freecam (Свободная камера)", function(v) 
    Settings.Freecam = v 
    Camera.CameraType = v and Enum.CameraType.Scriptable or Enum.CameraType.Custom
end)
addToggle(tabUtils, "WaterWalk (Хождение по воде)", function(v) Settings.WaterWalk = v end)
addToggle(tabUtils, "Infinite Zoom (Бесконечная камера)", function(v) Settings.InfiniteZoom = v if v then LocalPlayer.CameraMaxZoomDistance = 99999 else LocalPlayer.CameraMaxZoomDistance = 400 end end)
addToggle(tabUtils, "NightVision (Ночное видение)", function(v) Settings.NightVision = v end)
addToggle(tabUtils, "Fullbright (Яркий свет)", function(v) Settings.Fullbright = v if not v then Lighting.Brightness = 1 Lighting.GlobalShadows = true end end)

-- Вкладка EXTRA (Добавлен Anti-Ragdoll)
local tabExtra = createTab("EXTRA", "📦")
addToggle(tabExtra, "GodMode (Бессмертие)", function(v) Settings.GodMode = v end)
addToggle(tabExtra, "Anti-Ragdoll (Защита от падений/сбитий)", function(v) Settings.AntiRagdoll = v end)
addToggle(tabExtra, "Anti-AFK (Защита от кика за афк)", function(v) Settings.AntiAFK = v end)
addToggle(tabExtra, "True Invisibility (Настоящая невидимость)", function(v) 
    Settings.TrueInvis = v 
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = v and 1 or 0
                elseif part:IsA("Accessory") or part:IsA("Clothing") then
                    part.Parent = v and nil or char
                end
            end
        end
    end)
end)
addToggle(tabExtra, "Auto-Respawn (Мгновенный респавн)", function(v) Settings.AutoRespawn = v end)
addToggle(tabExtra, "Anti-Void (Защита от падения)", function(v) Settings.AntiVoid = v end)
addToggle(tabExtra, "Click TP (Телепорт кликом)", function(v) Settings.ClickTP = v end)
addToggle(tabExtra, "Auto-Clicker (Автокликер)", function(v) Settings.AutoClicker = v end)
addToggle(tabExtra, "SpinBot (Быстрое вращение)", function(v) Settings.SpinBot = v end)

-- Вкладка TP к игрокам
local tabTP = createTab("TP", "📍")
local tpScroll = Instance.new("ScrollingFrame", tabTP)
tpScroll.Size = UDim2.new(1, 0, 1, 0) tpScroll.BackgroundTransparency = 1 tpScroll.CanvasSize = UDim2.new(0, 0, 0, 500) tpScroll.ScrollBarThickness = 3
local tpLayout = Instance.new("UIListLayout", tpScroll) tpLayout.Padding = UDim.new(0, 4)

local function refreshTPList()
    for _, c in ipairs(tpScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", tpScroll)
            b.Size = UDim2.new(1, -4, 0, 32) b.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
            b.Text = "  ➔ TP к игроку: " .. p.Name b.TextColor3 = Color3.fromRGB(255, 255, 255) b.TextSize = 10
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function()
                pcall(function()
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                end)
            end)
        end
    end
end
local refBtn = Instance.new("TextButton", tpScroll)
refBtn.Size = UDim2.new(1, -4, 0, 32) refBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
refBtn.Text = "  🔄 Обновить список игроков" refBtn.TextColor3 = Color3.fromRGB(255, 255, 255) refBtn.TextSize = 10
Instance.new("UICorner", refBtn).CornerRadius = UDim.new(0, 6)
refBtn.MouseButton1Click:Connect(refreshTPList)
refreshTPList()

for _, p in pairs(pages) do p.Visible = false end
pages["ESP"].Visible = true

local vu = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if Settings.AntiAFK then
        vu:Button2Down(Vector2.new(0,0), Camera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), Camera.CFrame)
    end
end)

local mouse = LocalPlayer:GetMouse()
mouse.Button1Down:Connect(function()
    pcall(function()
        if Settings.ClickTP and mouse.Target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end)
end)

UserInputService.JumpRequest:Connect(function()
    pcall(function()
        if Settings.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

local function getClosestPlayer()
    local target, shortest = nil, Settings.FOV
    for _, p in ipairs(Players:GetPlayers()) do
        pcall(function()
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                if Settings.ESP_TeamCheck and p.Team and LocalPlayer.Team and p.Team == LocalPlayer.Team then return end
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortest then shortest = dist target = p end
                end
            end
        end)
    end
    return target
end

local espCache = {}
local textCache = {}

RunService.RenderStepped:Connect(function()
    pcall(function()
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        FOVCircle.Radius = Settings.FOV
        Camera.FieldOfView = Settings.GameFOV

        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        StatsLabel.Text = "FPS: " .. fps .. " | Ping: " .. ping .. "ms"

        if Settings.Aimbot then
            local t = getClosestPlayer()
            if t and t.Character and t.Character:FindFirstChild("Head") then
    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Character.Head.Position), 1 / Settings.Smoothness)
    if Settings.HitSound then
        pcall(function()
            local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://9069176472"
            sound.Volume = 1
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 1)
        end)
    end
                    end
                            if Settings.TriggerBot then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
            raycastParams.IgnoreWater = true
            
            local rayResult = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 1000, raycastParams)
            if rayResult and rayResult.Instance then
                local hitModel = rayResult.Instance.Parent
                local hum = hitModel:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local p = Players:GetPlayerFromCharacter(hitModel)
                    if not p or (p ~= LocalPlayer and not (Settings.ESP_TeamCheck and p.Team == LocalPlayer.Team)) then
                        vu:Button1Down(Vector2.new(0,0))
                        task.wait(0.02)
                        vu:Button1Up(Vector2.new(0,0))
                        if Settings.HitSound then
                            pcall(function()
                                local sound = Instance.new("Sound", workspace)
                                sound.SoundId = "rbxassetid://9069176472"
                                sound.Volume = 1
                                sound:Play()
                                game:GetService("Debris"):AddItem(sound, 1)
                            end)
                        end
                    end
                end
            end
                    end
                    )
        game:GetService("Debris"):AddItem(sound, 1)
                            end)
                        end
                    end
                end
            end
        end

        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            
            if Settings.Speed and hum and root and hum.MoveDirection.Magnitude > 0 then
                root.CFrame = root.CFrame + (hum.MoveDirection * Settings.SpeedMultiplier)
            end
            if Settings.Jump and hum then hum.JumpPower = 130 end
            if Settings.GodMode and hum then hum.Health = math.huge end
            
            if Settings.AntiRagdoll and hum then
                pcall(function()
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                end)
            end

            if Settings.AutoRespawn and hum and hum.Health <= 0 then
                LocalPlayer.CharacterAdded:Wait()
            end

            if Settings.Bhop and hum and hum.MoveDirection.Magnitude > 0 then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end

            if Settings.WaterWalk and root then
                local ray = workspace:Raycast(root.Position, Vector3.new(0, -10, 0))
                if ray then
                    root.CFrame = root.CFrame + Vector3.new(0, (ray.Position.Y + 3) - root.Position.Y, 0)
                    root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
                end
            end

            if Settings.AntiVoid and root and root.Position.Y < -50 then root.CFrame = root.CFrame + Vector3.new(0, 100, 0) end
            if Settings.Noclip then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
            if Settings.Fly and root then
                root.Velocity = Vector3.new(0, Settings.FlySpeed * 2, 0)
            end
            if Settings.SpinBot and root then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(35), 0)
            end
        end

        if Settings.AutoClicker then
            vu:Button1Down(Vector2.new(0,0))
            task.wait(0.05)
            vu:Button1Up(Vector2.new(0,0))
        end

        if Settings.Fullbright or Settings.NightVision then
            Lighting.Brightness = 3 Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
        end

        local rainbowColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pChar = p.Character
                
                local hl = espCache[p]
                if Settings.ESP_Boxes or Settings.ESP_Chams then
                    if not hl then
                        hl = Instance.new("Highlight", pChar)
                        hl.FillTransparency = Settings.ESP_Chams and 0.2 or 0.5 
                        espCache[p] = hl
                    else
                        hl.FillTransparency = Settings.ESP_Chams and 0.2 or 0.5
                    end
                    hl.OutlineColor = Settings.ESP_Rainbow and rainbowColor or Color3.fromRGB(220, 80, 255)
                    hl.FillColor = Settings.ESP_Chams and (Settings.ESP_Rainbow and rainbowColor or Color3.fromRGB(220, 80, 255)) or Color3.fromRGB(255, 255, 255)
                else
                    if hl then hl:Destroy() espCache[p] = nil end
                end

                local tag = textCache[p]
                if Settings.ESP_Names or Settings.ESP_Health or Settings.ESP_Distance then
                    if not tag then
                        tag = Instance.new("BillboardGui", pChar)
                        tag.Size = UDim2.new(0, 200, 0, 50) tag.StudsOffset = Vector3.new(0, 2.5, 0) tag.AlwaysOnTop = true
                        local lbl = Instance.new("TextLabel", tag)
                        lbl.Size = UDim2.new(1, 0, 1, 0) lbl.BackgroundTransparency = 1
                        lbl.TextColor3 = Color3.fromRGB(255, 255, 255) lbl.TextStrokeTransparency = 0 lbl.TextSize = 11
                        textCache[p] = lbl
                    else
                        local lbl = tag:FindFirstChildOfClass("TextLabel")
                        if lbl then
                            local txt = ""
                            if Settings.ESP_Names then txt = txt .. p.Name .. "\n" end
                            if Settings.ESP_Health and pChar:FindFirstChildOfClass("Humanoid") then 
                                txt = txt .. "HP: " .. math.floor(pChar.Humanoid.Health) .. "\n" 
                            end
                            if Settings.ESP_Distance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - pChar.Head.Position).Magnitude)
                                txt = txt .. "[" .. dist .. "m]"
                            end
                            lbl.Text = txt
                        end
                    end
                else
                    if tag then tag:Destroy() textCache[p] = nil end
                end
            end
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local rp = p.Character.HumanoidRootPart
                if Settings.HitBoxExpander then
                    rp.Size = Vector3.new(5, 5, 5) rp.Transparency = 0.5
                    rp.Color = Color3.fromRGB(255, 0, 0)
                else
                    rp.Size = Vector3.new(2, 2, 1) rp.Transparency = 1
                end
            end
        end
    end)
end)

print("Nebula X V2.5: Всё загружено и работает!")
