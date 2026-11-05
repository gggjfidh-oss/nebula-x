-- Nebula X v49.4 Elite (Ultimate Expanded Full Features & Draggable UI)
if getgenv and getgenv().LoadedCheat then
    pcall(function() getgenv().LoadedCheat:Disconnect() end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Settings = {
    ESP_Boxes = false, ESP_Names = false, ESP_Health = false, ESP_Distance = false, ESP_TeamCheck = true,
    Aimbot = false, AimBotNPC = false, HitBoxExpander = false, HitBoxSize = 4, WallCheck = false, AimPart = "Head", Smoothness = 3, FOV = 130,
    SpeedEnabled = false, SpeedValue = 28, JumpPowerEnabled = false, JumpPowerValue = 70,
    FlyEnabled = false, FlySpeed = 50, InfiniteJump = false, Noclip = false,
    GodMode = false, AntiVoid = false, ClickTP = false, Fullbright = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NebulaXElite"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Функция перетаскивания (меню и кнопки)
local function makeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(220, 80, 255)
makeDraggable(MainFrame)

-- Кнопка "N" (Скрытие меню)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 44, 0, 44)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
ToggleBtn.Text = "N"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.TextSize, ToggleBtn.Font = 20, Enum.Font.GothamBold
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", ToggleBtn)
tStroke.Color = Color3.fromRGB(220, 80, 255) tStroke.Thickness = 1.5
makeDraggable(ToggleBtn)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Кнопка Аима по игрокам (🎯)
local AimMobileBtn = Instance.new("TextButton")
AimMobileBtn.Size = UDim2.new(0, 44, 0, 44)
AimMobileBtn.Position = UDim2.new(0.85, 0, 0.30, 0)
AimMobileBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
AimMobileBtn.Text = "🎯"
AimMobileBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimMobileBtn.TextSize = 18
AimMobileBtn.Parent = ScreenGui
Instance.new("UICorner", AimMobileBtn).CornerRadius = UDim.new(1, 0)
local aimBtnStroke = Instance.new("UIStroke", AimMobileBtn)
aimBtnStroke.Color = Color3.fromRGB(0, 255, 120) aimBtnStroke.Thickness = 1.5
makeDraggable(AimMobileBtn)
AimMobileBtn.MouseButton1Click:Connect(function()
    Settings.Aimbot = not Settings.Aimbot
    if Settings.Aimbot then
        AimMobileBtn.BackgroundColor3 = Color3.fromRGB(30, 180, 90)
        aimBtnStroke.Color = Color3.fromRGB(0, 255, 120)
    else
        AimMobileBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
        aimBtnStroke.Color = Color3.fromRGB(220, 80, 255)
    end
end)

-- Кнопка Аима по ботам (🤖)
local AimNPCBtn = Instance.new("TextButton")
AimNPCBtn.Size = UDim2.new(0, 44, 0, 44)
AimNPCBtn.Position = UDim2.new(0.85, 0, 0.45, 0)
AimNPCBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 20)
AimNPCBtn.Text = "🤖"
AimNPCBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimNPCBtn.TextSize = 18
AimNPCBtn.Parent = ScreenGui
Instance.new("UICorner", AimNPCBtn).CornerRadius = UDim.new(0, 10)
local aimNPCStroke = Instance.new("UIStroke", AimNPCBtn)
aimNPCStroke.Color = Color3.fromRGB(255, 140, 0) aimNPCStroke.Thickness = 1.5
makeDraggable(AimNPCBtn)
AimNPCBtn.MouseButton1Click:Connect(function()
    Settings.AimBotNPC = not Settings.AimBotNPC
    if Settings.AimBotNPC then
        AimNPCBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        aimNPCStroke.Color = Color3.fromRGB(255, 200, 0)
    else
        AimNPCBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 20)
        aimNPCStroke.Color = Color3.fromRGB(255, 140, 0)
    end
end)

-- Шапка меню
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 18, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0) Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1 Title.Text = "🔮  NEBULA X // ULTIMATE COMPLETE"
Title.TextColor3 = Color3.fromRGB(240, 220, 255) Title.TextSize = 11 Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24) CloseBtn.Position = UDim2.new(1, -30, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70) CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) CloseBtn.TextSize, CloseBtn.Font = 11, Enum.Font.GothamBold
CloseBtn.Parent = TopBar Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Верхние вкладки
local TopMenu = Instance.new("Frame")
TopMenu.Size = UDim2.new(1, 0, 0, 42) TopMenu.Position = UDim2.new(0, 0, 0, 32)
TopMenu.BackgroundColor3 = Color3.fromRGB(20, 15, 30) TopMenu.BorderSizePixel = 0 TopMenu.Parent = MainFrame

local MenuLayout = Instance.new("UIListLayout", TopMenu)
MenuLayout.FillDirection = Enum.FillDirection.Horizontal
MenuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuLayout.Padding = UDim.new(0, 4)

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -16, 1, -84) Container.Position = UDim2.new(0, 8, 0, 78)
Container.BackgroundTransparency = 1 Container.Parent = MainFrame

local pages = {}

local function createTab(name, iconText, tabColor)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 950) page.ScrollBarThickness = 3 page.Parent = Container
    
    local listLayout = Instance.new("UIListLayout", page)
    listLayout.Padding = UDim.new(0, 6)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 70, 1, -4) tabBtn.BackgroundColor3 = tabColor
    tabBtn.Text = iconText .. " " .. name tabBtn.TextColor3 = Color3.fromRGB(240, 240, 250)
    tabBtn.TextSize, tabBtn.Font = 9, Enum.Font.GothamBold tabBtn.Parent = TopMenu
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
    pages[name] = page
    return page
end

-- Вкладка ГЛАВНАЯ
local tabHome = Instance.new("ScrollingFrame")
tabHome.Size = UDim2.new(1, 0, 1, 0) tabHome.BackgroundTransparency = 1 tabHome.Visible = true
tabHome.CanvasSize = UDim2.new(0, 0, 0, 300) tabHome.ScrollBarThickness = 3 tabHome.Parent = Container

local homeBtn = Instance.new("TextButton")
homeBtn.Size = UDim2.new(0, 70, 1, -4) homeBtn.BackgroundColor3 = Color3.fromRGB(70, 20, 110)
homeBtn.Text = "🏠 ГЛАВ" homeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
homeBtn.TextSize, homeBtn.Font = 9, Enum.Font.GothamBold homeBtn.Parent = TopMenu
Instance.new("UICorner", homeBtn).CornerRadius = UDim.new(0, 6)
homeBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(pages) do p.Visible = false end
    tabHome.Visible = true
end)
pages["HOME"] = tabHome

local NewsBox = Instance.new("Frame")
NewsBox.Size = UDim2.new(1, -4, 0, 220) NewsBox.Position = UDim2.new(0, 0, 0, 5)
NewsBox.BackgroundColor3 = Color3.fromRGB(22, 18, 35) NewsBox.Parent = tabHome
Instance.new("UICorner", NewsBox).CornerRadius = UDim.new(0, 8)
local nStroke = Instance.new("UIStroke", NewsBox) nStroke.Color = Color3.fromRGB(220, 80, 255) nStroke.Thickness = 1.5

local NewsText = Instance.new("TextLabel")
NewsText.Size = UDim2.new(1, -16, 1, -16) NewsText.Position = UDim2.new(0, 8, 0, 8)
NewsText.BackgroundTransparency = 1 
NewsText.Text = "• [v49.4 Ultimate] Полный набор функций возвращен!\n• Вкладки AIM, ESP, UTILS, EXTRA настроены полностью.\n• Интерфейс и кнопки аима полностью перетаскиваются."
NewsText.TextColor3 = Color3.fromRGB(210, 210, 240) NewsText.TextSize = 10.5 NewsText.Font = Enum.Font.GothamMedium
NewsText.TextXAlignment = Enum.TextXAlignment.Left NewsText.TextYAlignment = Enum.TextYAlignment.Top
NewsText.TextWrapped = true NewsText.Parent = NewsBox

local function createToggle(page, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
    btn.Text = "  " .. name .. ": [OFF]"
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.TextSize, btn.Font = 10, Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(180, 100, 255) stroke.Thickness = 1.2

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then 
            btn.BackgroundColor3 = Color3.fromRGB(20, 160, 80) 
            btn.Text = "  " .. name .. ": [ON]" 
            stroke.Color = Color3.fromRGB(0, 255, 120)
        else 
            btn.BackgroundColor3 = Color3.fromRGB(25, 20, 40) 
            btn.Text = "  " .. name .. ": [OFF]" 
            stroke.Color = Color3.fromRGB(180, 100, 255)
        end
        pcall(function() callback(state) end)
    end)
end

-- Вкладка ESP
local tabESP = createTab("ESP", "👁️", Color3.fromRGB(15, 75, 45))
createToggle(tabESP, "Boxes (Рамки ESP)", function(v) Settings.ESP_Boxes = v end)
createToggle(tabESP, "Names (Имена игроков)", function(v) Settings.ESP_Names = v end)
createToggle(tabESP, "Health (Здоровье)", function(v) Settings.ESP_Health = v end)
createToggle(tabESP, "Distance (Дистанция)", function(v) Settings.ESP_Distance = v end)
createToggle(tabESP, "Team Check", function(v) Settings.ESP_TeamCheck = v end)

-- Вкладка AIM
local tabAim = createTab("AIM", "🎯", Color3.fromRGB(90, 20, 45))
createToggle(tabAim, "Aimbot (Аимбот)", function(v) Settings.Aimbot = v end)
createToggle(tabAim, "HitBox Expander", function(v) Settings.HitBoxExpander = v end)
createToggle(tabAim, "WallCheck (Проверка стен)", function(v) Settings.WallCheck = v end)

local aimPartBtn = Instance.new("TextButton")
aimPartBtn.Size = UDim2.new(1, -4, 0, 32) aimPartBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
aimPartBtn.Text = "  🎯 Цель аима: [Голова (Head)]" aimPartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimPartBtn.TextSize, aimPartBtn.Font = 10, Enum.Font.GothamBold aimPartBtn.TextXAlignment = Enum.TextXAlignment.Left aimPartBtn.Parent = tabAim
Instance.new("UICorner", aimPartBtn).CornerRadius = UDim.new(0, 6)
aimPartBtn.MouseButton1Click:Connect(function()
    if Settings.AimPart == "Head" then
        Settings.AimPart = "HumanoidRootPart"
        aimPartBtn.Text = "  🎯 Цель аима: [Торс (RootPart)]"
    else
        Settings.AimPart = "Head"
        aimPartBtn.Text = "  🎯 Цель аима: [Голова (Head)]"
    end
end)

-- Вкладка ТЕЛЕПОРТ
local tabTeleport = createTab("TP", "📍", Color3.fromRGB(40, 80, 110))
local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1, 0, 1, 0) tpScroll.BackgroundTransparency = 1 tpScroll.CanvasSize = UDim2.new(0, 0, 0, 400) tpScroll.ScrollBarThickness = 3 tpScroll.Parent = tabTeleport

local function refreshPlayerList()
    for _, child in ipairs(tpScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local yPos = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local tpBtn = Instance.new("TextButton")
            tpBtn.Size = UDim2.new(1, -4, 0, 32) tpBtn.Position = UDim2.new(0, 0, 0, yPos)
            tpBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
            tpBtn.Text = "  ➔ TP к: " .. p.Name tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.TextSize, tpBtn.Font = 10, Enum.Font.GothamBold tpBtn.TextXAlignment = Enum.TextXAlignment.Left tpBtn.Parent = tpScroll
            Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)
            
            tpBtn.MouseButton1Click:Connect(function()
                pcall(function()
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                end)
            end)
            yPos = yPos + 38
        end
    end
end

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, -4, 0, 32) refreshBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
refreshBtn.Text = "  🔄 Обновить список игроков" refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.TextSize, refreshBtn.Font = 10, Enum.Font.GothamBold refreshBtn.TextXAlignment = Enum.TextXAlignment.Left refreshBtn.Parent = tabTeleport
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 6)
refreshBtn.MouseButton1Click:Connect(refreshPlayerList)
refreshPlayerList()

-- Вкладка UTILS (Полная)
local tabUtils = createTab("UTILS", "⚙️", Color3.fromRGB(20, 40, 90))
createToggle(tabUtils, "Speedhack (Ускорение)", function(v) Settings.SpeedEnabled = v end)
createToggle(tabUtils, "JumpPower (Высокий прыжок)", function(v) Settings.JumpPowerEnabled = v end)
createToggle(tabUtils, "Fly (Полет)", function(v) Settings.FlyEnabled = v end)
createToggle(tabUtils, "Infinite Jump (Беск. прыжки)", function(v) Settings.InfiniteJump = v end)
createToggle(tabUtils, "Noclip (Сквозь стены)", function(v) Settings.Noclip = v end)
createToggle(tabUtils, "Fullbright (Яркий свет)", function(v) Settings.Fullbright = v if not v then Lighting.Brightness = 1 Lighting.GlobalShadows = true end end)

-- Вкладка EXTRA
local tabExtra = createTab("EXTRA", "📦", Color3.fromRGB(100, 45, 15))
createToggle(tabExtra, "GodMode (Бессмертие)", function(v) Settings.GodMode = v end)
createToggle(tabExtra, "Anti-Void (Защита от падения)", function(v) Settings.AntiVoid = v end)
createToggle(tabExtra, "Click TP (Телепорт кликом)", function(v) Settings.ClickTP = v end)

for _, p in pairs(pages) do p.Visible = false end
tabHome.Visible = true

-- Логика функционала
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

local function isTeammate(p)
    if not Settings.ESP_TeamCheck then return false end
    if p.Team and LocalPlayer.Team and p.Team == LocalPlayer.Team then return true end
    return false
end

local function isVisible(part, targetChar)
    if not Settings.WallCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = (part.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetChar}
    raycastParams.IgnoreWater = true
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

local function getClosestPlayer()
    local target, shortest = nil, Settings.FOV
    for _, p in ipairs(Players:GetPlayers()) do
        pcall(function()
            if p ~= LocalPlayer and not isTeammate(p) and p.Character and p.Character:FindFirstChild(Settings.AimPart) then
                local part = p.Character[Settings.AimPart]
                if not isVisible(part, p.Character) then return end
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortest then shortest = dist target = p end
                end
            end
        end)
    end
    return target
end

local function getClosestNPC()
    local target, shortest = nil, Settings.FOV
    for _, model in ipairs(workspace:GetDescendants()) do
        pcall(function()
            if model:IsA("Model") and model ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(model) then
                local hum = model:FindFirstChildOfClass("Humanoid")
                local head = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart")
                if hum and head and hum.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if dist < shortest then shortest = dist target = head end
                    end
                end
            end
        end)
    end
    return target
end

local espCache = {}

RunService.RenderStepped:Connect(function()
    pcall(function()
        if Settings.Aimbot then
            local t = getClosestPlayer()
            if t and t.Character and t.Character:FindFirstChild(Settings.AimPart) then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Character[Settings.AimPart].Position), 1 / Settings.Smoothness)
            end
        end

        if Settings.AimBotNPC then
            local npcPart = getClosestNPC()
            if npcPart then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Character[Settings.AimPart].Position), 1 / Settings.Smoothness)
            end
        end

        if Settings.AimBotNPC then
            local npcPart = getClosestNPC()
            if npcPart then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, npcPart.Position), 1 / Settings.Smoothness)
            end
        end

        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            
            if Settings.SpeedEnabled and hum and root and hum.MoveDirection.Magnitude > 0 then
                root.CFrame = root.CFrame + (hum.MoveDirection * (Settings.SpeedValue / 50))
            end
            if Settings.JumpPowerEnabled and hum then hum.JumpPower = Settings.JumpPowerValue end
            if Settings.GodMode and hum then hum.MaxHealth = math.huge hum.Health = math.huge end
            if Settings.AntiVoid and root and root.Position.Y < -50 then root.CFrame = root.CFrame + Vector3.new(0, 100, 0) end
            if Settings.Noclip then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end

        if Settings.Fullbright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local pChar = p.Character
                if Settings.ESP_Boxes or Settings.ESP_Names or Settings.ESP_Health or Settings.ESP_Distance then
                    if not espCache[p] then
                        local hl = Instance.new("Highlight")
                        hl.Adornee = pChar
                        hl.FillTransparency = 0.6
                        hl.OutlineColor = Color3.fromRGB(220, 80, 255)
                        hl.Parent = pChar
                        espCache[p] = hl
                    end
                else
                    if espCache[p] then
                        espCache[p]:Destroy()
                        espCache[p] = nil
                    end
                end
            end
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local rp = p.Character.HumanoidRootPart
                if Settings.HitBoxExpander then
                    rp.Size = Vector3.new(Settings.HitBoxSize, Settings.HitBoxSize, Settings.HitBoxSize)
                    rp.Transparency = 0.6
                else
                    rp.Size = Vector3.new(2, 2, 1)
                    rp.Transparency = 1
                end
            end
        end
    end)
end)

print("Nebula X Elite: Полная расширенная версия со всеми вкладками активна!")
