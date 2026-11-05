-- Nebula X Hub v49.4 Elite (Top Bar Icon Menu & Dual Aim)
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
    ESP_Boxes = false, ESP_BoxFill = false, ESP_Names = false,
    ESP_Health = false, ESP_Distance = false, ESP_Weapon = false, ESP_Ammo = false,
    ESP_Tracers = false, ESP_Offscreen = false, ESP_Skeleton = false, ESP_HeadDot = false, ESP_Chams = false, ESP_RainbowChams = false, ESP_ViewAngle = false, ESP_TeamCheck = true,
    Aimbot = false, AimBotNPC = false, TriggerBot = false, HitBoxExpander = false, HitBoxSize = 4, WallCheck = false, Prediction = false, SilentAim = false, AimPart = "Head", Smoothness = 3,
    ShowFOV = false, FOV = 130, SpeedEnabled = false, SpeedValue = 28, JumpPowerEnabled = false, JumpPowerValue = 70,
    FlyEnabled = false, FlySpeed = 50, InfiniteJump = false, SuperJump = false, Bhop = false, Noclip = false,
    Freecam = false, SpinBot = false, KillAura = false, AutoEquip = false, AutoRespawn = false, AutoHeal = false, GhostMode = false, 
    GodMode = false, AntiVoid = false, ClickTP = false, 
    AntiAFK = true, FOVChanger = false, FOVValue = 70, CustomZoomEnabled = false, CustomZoomValue = 400, Fullbright = false, RGBMenu = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NebulaXElite"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 540, 0, 360)
MainFrame.Position = UDim2.new(0.5, -270, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(220, 80, 255)

task.spawn(function()
    while true do
        pcall(function()
            if Settings.RGBMenu then
                for i = 0, 1, 0.005 do
                    if not Settings.RGBMenu then break end
                    MainStroke.Color = Color3.fromHSV(i, 1, 1)
                    task.wait(0.03)
                end
            else
                MainStroke.Color = Color3.fromRGB(220, 80, 255)
                task.wait(0.5)
            end
        end)
        task.wait(0.5)
    end
end)

-- Плавающая кнопка открытия/скрытия скрипта ("N")
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
tStroke.Color = Color3.fromRGB(220, 80, 255)
tStroke.Thickness = 1.5

local tDragging, tDragInput, tDragStart, tStartPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tDragging = true tDragStart = input.Position tStartPos = ToggleBtn.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then tDragging = false end end)
    end
end)
ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then tDragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == tDragInput and tDragging then
        local delta = input.Position - tDragStart
        ToggleBtn.Position = UDim2.new(tStartPos.X.Scale, tStartPos.X.Offset + delta.X, tStartPos.Y.Scale, tStartPos.Y.Offset + delta.Y)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Плавающая кнопка Аима по Игрокам (🎯)
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
aimBtnStroke.Color = Color3.fromRGB(0, 255, 120)
aimBtnStroke.Thickness = 1.5

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

-- Плавающая кнопка Аима по Ботам/NPC (🤖)
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
aimNPCStroke.Color = Color3.fromRGB(255, 140, 0)
aimNPCStroke.Thickness = 1.5

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

-- Верхняя панель перетаскивания
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 18, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0) Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1 Title.Text = "🔮  NEBULA X v49.4 // ELITE"
Title.TextColor3 = Color3.fromRGB(240, 220, 255) Title.TextSize = 11 Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24) CloseBtn.Position = UDim2.new(1, -30, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70) CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) CloseBtn.TextSize, CloseBtn.Font = 11, Enum.Font.GothamBold
CloseBtn.Parent = TopBar Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Верхнее горизонтальное меню с иконками (как на скриншоте)
local TopMenu = Instance.new("Frame")
TopMenu.Size = UDim2.new(1, 0, 0, 50) TopMenu.Position = UDim2.new(0, 0, 0, 32)
TopMenu.BackgroundColor3 = Color3.fromRGB(20, 15, 30) TopMenu.BorderSizePixel = 0 TopMenu.Parent = MainFrame

local MenuLayout = Instance.new("UIListLayout", TopMenu)
MenuLayout.FillDirection = Enum.FillDirection.Horizontal
MenuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuLayout.Padding = UDim.new(0, 6)

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -16, 1, -92) Container.Position = UDim2.new(0, 8, 0, 88)
Container.BackgroundTransparency = 1 Container.Parent = MainFrame

local pages = {}

local function createTab(name, iconText, tabColor)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 1500) page.ScrollBarThickness = 3 page.Parent = Container
    
    local listLayout = Instance.new("UIListLayout", page)
    listLayout.Padding = UDim.new(0, 6)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 82, 1, -6) tabBtn.BackgroundColor3 = tabColor
    tabBtn.Text = iconText .. "\n" .. name tabBtn.TextColor3 = Color3.fromRGB(240, 240, 250)
    tabBtn.TextSize, tabBtn.Font = 9, Enum.Font.GothamBold tabBtn.Parent = TopMenu
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 8)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
    pages[name] = page
    return page
end

-- Создание вкладок с иконками
local tabHome = Instance.new("ScrollingFrame")
tabHome.Size = UDim2.new(1, 0, 1, 0) tabHome.BackgroundTransparency = 1 tabHome.Visible = true
tabHome.CanvasSize = UDim2.new(0, 0, 0, 450) tabHome.ScrollBarThickness = 3 tabHome.Parent = Container

local homeBtn = Instance.new("TextButton")
homeBtn.Size = UDim2.new(0, 82, 1, -6) homeBtn.BackgroundColor3 = Color3.fromRGB(70, 20, 110)
homeBtn.Text = "🏠\nГЛАВНАЯ" homeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
homeBtn.TextSize, homeBtn.Font = 9, Enum.Font.GothamBold homeBtn.Parent = TopMenu
Instance.new("UICorner", homeBtn).CornerRadius = UDim.new(0, 8)
homeBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(pages) do p.Visible = false end
    tabHome.Visible = true
end)
pages["HOME"] = tabHome

-- Новостной блок на вкладке ГЛАВНАЯ
local NewsBox = Instance.new("Frame")
NewsBox.Size = UDim2.new(1, -4, 0, 230) NewsBox.Position = UDim2.new(0, 0, 0, 5)
NewsBox.BackgroundColor3 = Color3.fromRGB(22, 18, 35) NewsBox.Parent = tabHome
Instance.new("UICorner", NewsBox).CornerRadius = UDim.new(0, 8)
local nStroke = Instance.new("UIStroke", NewsBox) nStroke.Color = Color3.fromRGB(220, 80, 255) nStroke.Thickness = 1.5

local NewsTitle = Instance.new("TextLabel")
NewsTitle.Size = UDim2.new(1, 0, 0, 28) NewsTitle.Position = UDim2.new(0, 0, 0, 5)
NewsTitle.BackgroundTransparency = 1 NewsTitle.Text = "🔥 NEWS & UPDATES"
NewsTitle.TextColor3 = Color3.fromRGB(255, 215, 0) NewsTitle.TextSize = 11 NewsTitle.Font = Enum.Font.GothamBold
NewsTitle.Parent = NewsBox

local NewsText = Instance.new("TextLabel")
NewsText.Size = UDim2.new(1, -16, 1, -35) NewsText.Position = UDim2.new(0, 8, 0, 32)
NewsText.BackgroundTransparency = 1 
NewsText.Text = "• [v49.4 Elite] Новый дизайн меню с верхними иконками!\n• [v49.4 Elite] Дуальный аим: 🎯 для Игроков, 🤖 для Ботов\n• ESP Fix: Жесткий Clamp никнеймов и стабильный бокс\n• Трассеры: Обновленная подсветка линий\n• Статус: Стабильный обход античита"
NewsText.TextColor3 = Color3.fromRGB(210, 210, 240) NewsText.TextSize = 9.5 NewsText.Font = Enum.Font.GothamMedium
NewsText.TextXAlignment = Enum.TextXAlignment.Left NewsText.TextYAlignment = Enum.TextYAlignment.Top
NewsText.TextWrapped = true NewsText.Parent = NewsBox

local uniqueColors = {
    Color3.fromRGB(25, 45, 80), Color3.fromRGB(70, 25, 90),
    Color3.fromRGB(20, 80, 50), Color3.fromRGB(90, 50, 20),
    Color3.fromRGB(80, 20, 50), Color3.fromRGB(20, 70, 80)
}
local uIndex = 1

local function createToggle(page, name, callback)
    local btnColor = uniqueColors[uIndex]
    uIndex = uIndex % #uniqueColors + 1

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 32) btn.BackgroundColor3 = btnColor
    btn.Text = "  " .. name .. ": [OFF]" btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.TextSize, btn.Font = 10, Enum.Font.GothamBold btn.TextXAlignment = Enum.TextXAlignment.Left btn.Parent = page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(180, 100, 255) stroke.Thickness = 1.2

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then 
            btn.BackgroundColor3 = Color3.fromRGB(20, 160, 80) 
            btn.TextColor3 = Color3.fromRGB(255, 255, 255) 
            btn.Text = "  " .. name .. ": [ON]" 
            stroke.Color = Color3.fromRGB(0, 255, 120)
        else 
            btn.BackgroundColor3 = btnColor 
            btn.TextColor3 = Color3.fromRGB(240, 240, 255) 
            btn.Text = "  " .. name .. ": [OFF]" 
            stroke.Color = Color3.fromRGB(180, 100, 255)
        end
        pcall(function() callback(state) end)
    end)
end

local function createValueAdjuster(page, name, min, max, step, default, callback)
    local frame = Instance.new("Frame") frame.Size = UDim2.new(1, -4, 0, 32) frame.BackgroundTransparency = 1 frame.Parent = page
    local lbl = Instance.new("TextLabel") lbl.Size = UDim2.new(0.58, 0, 1, 0) lbl.BackgroundColor3 = Color3.fromRGB(35, 25, 65)
    lbl.Text = "  " .. name .. ": " .. default lbl.TextColor3 = Color3.fromRGB(230, 230, 255)
    lbl.TextSize, lbl.Font = 10, Enum.Font.GothamBold lbl.TextXAlignment = Enum.TextXAlignment.Left lbl.Parent = frame
    Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 6)
    
    local val = default
    local minusBtn = Instance.new("TextButton") minusBtn.Size = UDim2.new(0.19, 0, 1, 0) minusBtn.Position = UDim2.new(0.60, 0, 0, 0)
    minusBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 55) minusBtn.Text = "-" minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.TextSize, minusBtn.Font = 12, Enum.Font.GothamBold minusBtn.Parent = frame Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 6)
    
    local plusBtn = Instance.new("TextButton") plusBtn.Size = UDim2.new(0.19, 0, 1, 0) plusBtn.Position = UDim2.new(0.81, 0, 0, 0)
    plusBtn.BackgroundColor3 = Color3.fromRGB(20, 100, 55) plusBtn.Text = "+" plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.TextSize, plusBtn.Font = 12, Enum.Font.GothamBold plusBtn.Parent = frame Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 6)
    
    minusBtn.MouseButton1Click:Connect(function() if val > min then val = val - step lbl.Text = "  " .. name .. ": " .. val pcall(function() callback(val) end) end end)
    plusBtn.MouseButton1Click:Connect(function() if val < max then val = val + step lbl.Text = "  " .. name .. ": " .. val pcall(function() callback(val) end) end end)
end

local tabESP = createTab("ESP", "👁️", Color3.fromRGB(15, 75, 45))
createToggle(tabESP, "Boxes (Боксы)", function(v) Settings.ESP_Boxes = v end)
createToggle(tabESP, "Box Fill (Заливка)", function(v) Settings.ESP_BoxFill = v end)
createToggle(tabESP, "Names (Имена)", function(v) Settings.ESP_Names = v end)
createToggle(tabESP, "Health (Здоровье)", function(v) Settings.ESP_Health = v end)
createToggle(tabESP, "Distance (Дистанция)", function(v) Settings.ESP_Distance = v end)
createToggle(tabESP, "Weapon & Ammo (Оружие/Патроны)", function(v) Settings.ESP_Ammo = v end)
createToggle(tabESP, "Head Dot (Точка на голове)", function(v) Settings.ESP_HeadDot = v end)
createToggle(tabESP, "Tracers (Линии)", function(v) Settings.ESP_Tracers = v end)
createToggle(tabESP, "Offscreen Arrows (Стрелки)", function(v) Settings.ESP_Offscreen = v end)
createToggle(tabESP, "Skeleton (Скелет)", function(v) Settings.ESP_Skeleton = v end)
createToggle(tabESP, "Chams (Подсветка)", function(v) Settings.ESP_Chams = v end)
createToggle(tabESP, "Rainbow Chams", function(v) Settings.ESP_RainbowChams = v end)
createToggle(tabESP, "ViewAngle (Взгляд)", function(v) Settings.ESP_ViewAngle = v end)
createToggle(tabESP, "Team Check", function(v) Settings.ESP_TeamCheck = v end)

local tabAim = createTab("AIM", "🎯", Color3.fromRGB(90, 20, 45))
createToggle(tabAim, "Aimbot (Аимбот)", function(v) Settings.Aimbot = v end)
createToggle(tabAim, "Silent Aim", function(v) Settings.SilentAim = v end)
createToggle(tabAim, "TriggerBot", function(v) Settings.TriggerBot = v end)
createToggle(tabAim, "HitBox Expander", function(v) Settings.HitBoxExpander = v end)
createValueAdjuster(tabAim, "HitBox Size", 2, 12, 1, 4, function(v) Settings.HitBoxSize = v end)
createToggle(tabAim, "WallCheck", function(v) Settings.WallCheck = v end)
createToggle(tabAim, "Prediction", function(v) Settings.Prediction = v end)
createToggle(tabAim, "Show FOV", function(v) Settings.ShowFOV = v end)
createValueAdjuster(tabAim, "FOV Size", 30, 300, 10, 130, function(v) Settings.FOV = v end)
createValueAdjuster(tabAim, "Smoothness", 1, 10, 1, 3, function(v) Settings.Smoothness = v end)

local aimPartBtn = Instance.new("TextButton")
aimPartBtn.Size = UDim2.new(1, -4, 0, 32) aimPartBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 90)
aimPartBtn.Text = "  Target: [ Head ]" aimPartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimPartBtn.TextSize, aimPartBtn.Font = 10, Enum.Font.GothamBold aimPartBtn.TextXAlignment = Enum.TextXAlignment.Left aimPartBtn.Parent = tabAim
Instance.new("UICorner", aimPartBtn).CornerRadius = UDim.new(0, 6)
aimPartBtn.MouseButton1Click:Connect(function()
    if Settings.AimPart == "Head" then Settings.AimPart = "UpperTorso" aimPartBtn.Text = "  Target: [ Torso ]"
    else Settings.AimPart = "Head" aimPartBtn.Text = "  Target: [ Head ]" end
end)

local tabTeleport = createTab("ТЕЛЕПОРТ", "📍", Color3.fromRGB(40, 80, 110))
local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1, 0, 1, 0) tpScroll.BackgroundTransparency = 1 tpScroll.CanvasSize = UDim2.new(0, 0, 0, 600) tpScroll.ScrollBarThickness = 3 tpScroll.Parent = tabTeleport

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
                        LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                end
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

local tabUtils = createTab("UTILS", "⚙️", Color3.fromRGB(20, 40, 90))
createToggle(tabUtils, "RGB Menu Glow", function(v) Settings.RGBMenu = v end)
createToggle(tabUtils, "Speed (Bypass)", function(v) Settings.SpeedEnabled = v end)
createValueAdjuster(tabUtils, "Speed Val", 16, 120, 4, 28, function(v) Settings.SpeedValue = v end)
createToggle(tabUtils, "Jump (Bypass)", function(v) Settings.JumpPowerEnabled = v end)
createValueAdjuster(tabUtils, "Jump Val", 50, 200, 10, 70, function(v) Settings.JumpPowerValue = v end)
createToggle(tabUtils, "Fly", function(v) Settings.FlyEnabled = v end)
createValueAdjuster(tabUtils, "Fly Spd", 20, 200, 10, 50, function(v) Settings.FlySpeed = v end)
createToggle(tabUtils, "Infinite Jump", function(v) Settings.InfiniteJump = v end)
createToggle(tabUtils, "Super Jump", function(v) Settings.SuperJump = v end)
createToggle(tabUtils, "Bhop", function(v) Settings.Bhop = v end)
createToggle(tabUtils, "Noclip", function(v) Settings.Noclip = v end)
createToggle(tabUtils, "Freecam (Fixed)", function(v) Settings.Freecam = v end)
createToggle(tabUtils, "Ghost Mode (Невидимка)", function(v) Settings.GhostMode = v end)
createToggle(tabUtils, "SpinBot", function(v) Settings.SpinBot = v end)
createToggle(tabUtils, "Kill Aura", function(v) Settings.KillAura = v end)
createToggle(tabUtils, "Auto-Equip", function(v) Settings.AutoEquip = v end)
createToggle(tabUtils, "Auto-Respawn", function(v) Settings.AutoRespawn = v end)
createToggle(tabUtils, "Auto-Heal", function(v) Settings.AutoHeal = v end)
createToggle(tabUtils, "Anti-AFK", function(v) Settings.AntiAFK = v end)
createToggle(tabUtils, "FOV Changer", function(v) Settings.FOVChanger = v end)
createValueAdjuster(tabUtils, "FOV Val", 50, 120, 5, 70, function(v) Settings.FOVValue = v end)
createToggle(tabUtils, "Custom Zoom", function(v) Settings.CustomZoomEnabled = v end)
createValueAdjuster(tabUtils, "Zoom Max", 100, 2000, 100, 400, function(v) Settings.CustomZoomValue = v end)
createToggle(tabUtils, "Fullbright", function(v) Settings.Fullbright = v if not v then pcall(function() Lighting.Brightness = 1 Lighting.ClockTime = 12 end) end end)

local tabExtra = createTab("EXTRA", "📦", Color3.fromRGB(100, 45, 15))
createToggle(tabExtra, "God Mode (Бессмертие)", function(v) Settings.GodMode = v end)
createToggle(tabExtra, "Anti-Void", function(v) Settings.AntiVoid = v end)
createToggle(tabExtra, "Click TP", function(v) Settings.ClickTP = v end)

for _, p in pairs(pages) do p.Visible = false end
tabHome.Visible = true
    -- Nebula X Hub v49.4 Elite (Part 2 of 2)
UserInputService.JumpRequest:Connect(function()
    pcall(function()
        if Settings and Settings.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

local mouse = LocalPlayer:GetMouse()
mouse.Button1Down:Connect(function()
    pcall(function()
        if Settings and Settings.ClickTP and mouse.Target then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end
    end)
end)

task.spawn(function()
    while task.wait(50) do
        pcall(function()
            if Settings and Settings.AntiAFK then
                local vu = game:GetService("VirtualUser")
                vu:Button2Down(Vector2.new(0,0), Camera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), Camera.CFrame)
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")

            if Settings and hum and root then
                if Settings.SpeedEnabled then
                    local moveVector = hum.MoveDirection
                    if moveVector.Magnitude > 0 then
                        root.CFrame = root.CFrame + (moveVector * (Settings.SpeedValue / 140))
                    end
                end
                if Settings.JumpPowerEnabled and hum.FloorMaterial ~= Enum.Material.Air then
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) or hum:GetState() == Enum.HumanoidStateType.Jumping then
                        root.Velocity = Vector3.new(root.Velocity.X, Settings.JumpPowerValue, root.Velocity.Z)
                    end
                end
                if Settings.SuperJump then hum.JumpPower = 100 end

                if Settings.GodMode then
                    hum.MaxHealth = math.huge
                    hum.Health = math.huge
                end
                if Settings.AutoHeal then hum.Health = hum.MaxHealth end
            end

            if Settings and root and Settings.AntiVoid and root.Position.Y < -50 then
                root.CFrame = root.CFrame + Vector3.new(0, 100, 0)
            end

            if Settings and Settings.AutoEquip and LocalPlayer.Backpack then
                for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                    if tool:IsA("Tool") then tool.Parent = char break end
                end
            end

            if Settings and hum and Settings.AutoRespawn and hum.Health <= 0 then hum.Health = 100 end

            if Settings and Settings.GhostMode and char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then 
                        part.Transparency = 0.9
                        part.LocalTransparencyModifier = 0.9
                    end
                end
            elseif char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then 
                        part.Transparency = 0
                        part.LocalTransparencyModifier = 0
                    end
                end
            end

            if Settings and hum and Settings.Bhop and hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end

            if Settings and root and Settings.KillAura then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") then
                        if p.Character.Humanoid.Health > 0 then
                            local dist = (root.Position - p.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 15 then mouse1click() end
                        end
                    end
                end
            end

            if Settings and Settings.Noclip then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = p.Character.HumanoidRootPart
                    if Settings.HitBoxExpander then
                        rootPart.Size = Vector3.new(Settings.HitBoxSize, Settings.HitBoxSize, Settings.HitBoxSize)
                        rootPart.Transparency = 0.65
                        rootPart.BrickColor = BrickColor.new("Royal purple")
                    else
                        rootPart.Size = Vector3.new(2, 2, 1)
                        rootPart.Transparency = 1
                    end
                end
            end
        end)
    end
end)

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false fovCircle.Radius = 130 fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 1.5 fovCircle.Filled = false fovCircle.Transparency = 0.8

local espCache = {}

local function removeESP(p)
    pcall(function()
        if espCache[p] then
            if espCache[p].box then espCache[p].box:Remove() end
            if espCache[p].boxFill then espCache[p].boxFill:Remove() end
            if espCache[p].name then espCache[p].name:Remove() end
            if espCache[p].healthBar then espCache[p].healthBar:Remove() end
            if espCache[p].tracer then espCache[p].tracer:Remove() end
            if espCache[p].offscreen then espCache[p].offscreen:Remove() end
            if espCache[p].headDot then espCache[p].headDot:Remove() end
            if espCache[p].viewAngle then espCache[p].viewAngle:Remove() end
            if espCache[p].highlight then espCache[p].highlight:Destroy() end
            if espCache[p].skeleton then for _, l in pairs(espCache[p].skeleton) do l:Remove() end end
            espCache[p] = nil
        end
    end)
end

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

RunService.RenderStepped:Connect(function()
    pcall(function()
        fovCircle.Visible = Settings.ShowFOV and (Settings.Aimbot or Settings.AimBotNPC or Settings.SilentAim)
        fovCircle.Radius = Settings.FOV
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

        if Settings.Aimbot then
            local t = getClosestPlayer()
            if t and t.Character and t.Character:FindFirstChild(Settings.AimPart) then
                local targetPart = t.Character[Settings.AimPart]
                local targetPos = targetPart.Position
                if Settings.Prediction and targetPart.Parent:FindFirstChild("HumanoidRootPart") then
                    targetPos = targetPos + (targetPart.Parent.HumanoidRootPart.AssemblyLinearVelocity * 0.05)
                end
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), 1 / Settings.Smoothness)
            end
        end

        if Settings.AimBotNPC then
            local npcPart = getClosestNPC()
            if npcPart then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, npcPart.Position), 1 / Settings.Smoothness)
            end
        end

        if Settings.SilentAim then
            local t = getClosestPlayer()
            if t and t.Character and t.Character:FindFirstChild(Settings.AimPart) then
                local targetPart = t.Character[Settings.AimPart]
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
            end
        end

        if Settings.TriggerBot then
            local mouseTarget = LocalPlayer:GetMouse().Target
            if mouseTarget and mouseTarget.Parent and Players:GetPlayerFromCharacter(mouseTarget.Parent) then
                local p = Players:GetPlayerFromCharacter(mouseTarget.Parent)
                if p ~= LocalPlayer and not isTeammate(p) then mouse1click() end
            end
        end

        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            local root = char:FindFirstChild("HumanoidRootPart")
            if Settings.FOVChanger then Camera.FieldOfView = Settings.FOVValue else Camera.FieldOfView = 70 end
            if Settings.CustomZoomEnabled then LocalPlayer.CameraMaxZoomDistance = Settings.CustomZoomValue else LocalPlayer.CameraMaxZoomDistance = 400 end

            if Settings.FlyEnabled and root then
                local camC = Camera.CFrame local moveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camC.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camC.LookVector end
                root.Velocity = moveDir * Settings.FlySpeed + Vector3.new(0, 2, 0)
            end
            
            if Settings.Freecam then
                if Camera.CameraType ~= Enum.CameraType.Scriptable then
                    Camera.CameraType = Enum.CameraType.Scriptable
                end
                local camSpeed = 1.2
                local moveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then moveDir = moveDir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then moveDir = moveDir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then moveDir = moveDir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then moveDir = moveDir + Camera.CFrame.RightVector end
                Camera.CFrame = Camera.CFrame + (moveDir * camSpeed)
            elseif not Settings.Freecam and Camera.CameraType == Enum.CameraType.Scriptable then
                Camera.CameraType = Enum.CameraType.Custom
            end

            if Settings.SpinBot and root then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(35), 0)
            end
        end

        if Settings.Fullbright then Lighting.Brightness = 2 Lighting.ClockTime = 14 Lighting.GlobalShadows = false end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not isTeammate(p) then
                if not espCache[p] then
                    espCache[p] = {
                        box = Drawing.new("Square"), boxFill = Drawing.new("Square"), name = Drawing.new("Text"), healthBar = Drawing.new("Square"),
                        tracer = Drawing.new("Line"), offscreen = Drawing.new("Triangle"), headDot = Drawing.new("Circle"), viewAngle = Drawing.new("Line"),
                        skeleton = { Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line") }
                    }
                    espCache[p].box.Thickness = 1.5 espCache[p].box.Filled = false
                    espCache[p].boxFill.Thickness = 0 espCache[p].boxFill.Filled = true espCache[p].boxFill.Color = Color3.fromRGB(220, 80, 255) espCache[p].boxFill.Transparency = 0.15
                    espCache[p].name.Size = 13 espCache[p].name.Center = true espCache[p].name.Outline = true
                    espCache[p].healthBar.Filled = true espCache[p].healthBar.Thickness = 1
                    espCache[p].tracer.Thickness = 1.5 espCache[p].tracer.Color = Color3.fromRGB(200, 150, 255)
                    espCache[p].offscreen.Filled = true espCache[p].offscreen.Color = Color3.fromRGB(255, 60, 120) espCache[p].offscreen.Transparency = 1
                    espCache[p].headDot.Radius = 4.5 espCache[p].headDot.Filled = true espCache[p].headDot.Color = Color3.fromRGB(255, 50, 100)
                    espCache[p].viewAngle.Thickness = 1.5 espCache[p].viewAngle.Color = Color3.fromRGB(0, 255, 255)
                    for _, l in pairs(espCache[p].skeleton) do l.Thickness = 1.5 l.Color = Color3.fromRGB(200, 200, 255) end
                end
                
                local cache = espCache[p] local char = p.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") and char.Humanoid.Health > 0 then
                    if Settings.ESP_Chams or Settings.ESP_RainbowChams then
                        if not cache.highlight then
                            cache.highlight = Instance.new("Highlight")
                            cache.highlight.Adornee = char
                            cache.highlight.FillTransparency = 0.4
                            cache.highlight.Parent = char
                        end
                        if Settings.ESP_RainbowChams then
                            cache.highlight.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                        else
                            cache.highlight.FillColor = Color3.fromRGB(220, 80, 255)
                        end
                    elseif cache.highlight then
                        cache.highlight:Destroy()
                        cache.highlight = nil
                    end

                    local rootPart = char.HumanoidRootPart local hum = char.Humanoid
                    local headPos = rootPart.Position + Vector3.new(0, 2.3, 0) local legPos = rootPart.Position - Vector3.new(0, 3, 0)
                    local headVector, headOnScreen = Camera:WorldToViewportPoint(headPos)
                    local legVector, legOnScreen = Camera:WorldToViewportPoint(legPos)
                    
                    if headOnScreen or legOnScreen then
                        local height = math.abs(headVector.Y - legVector.Y) local width = height / 2
                        local pos = Vector2.new(headVector.X - width / 2, headVector.Y)
                        
                        cache.box.Size = Vector2.new(width, height) cache.box.Position = pos cache.box.Visible = Settings.ESP_Boxes
                        cache.boxFill.Size = Vector2.new(width, height) cache.boxFill.Position = pos cache.boxFill.Visible = Settings.ESP_BoxFill
                        
                        if Settings.ESP_Names or Settings.ESP_Distance or Settings.ESP_Weapon or Settings.ESP_Ammo then
                            local infoText = p.Name
                            if Settings.ESP_Distance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude)
                                infoText = infoText .. " [" .. dist .. "m]"
                            end
                            
                            local heldTool = char:FindFirstChildOfClass("Tool")
                            if Settings.ESP_Weapon and heldTool then
                                infoText = infoText .. " (" .. heldTool.Name .. ")"
                            end
                            if Settings.ESP_Ammo and heldTool then
                                local ammoVal = heldTool:FindFirstChild("Ammo") or heldTool:FindFirstChild("Clip") or heldTool:FindFirstChild("Bullets")
                                if ammoVal and (ammoVal:IsA("IntValue") or ammoVal:IsA("NumberValue")) then
                                    infoText = infoText .. " [" .. ammoVal.Value .. "r]"
                                end
                            end

                            cache.name.Text = infoText 
                            cache.name.Position = Vector2.new(headVector.X, math.clamp(pos.Y - 18, 20, Camera.ViewportSize.Y - 40)) 
                            cache.name.Visible = true
                        else 
                            cache.name.Visible = false 
                        end
                        
                        if Settings.ESP_Health then
                            local hpPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1) local barHeight = height * hpPercent
                            cache.healthBar.Size = Vector2.new(2, barHeight)
                            cache.healthBar.Position = Vector2.new(pos.X - 5, pos.Y + (height - barHeight))
                            cache.healthBar.Color = Color3.fromRGB(0, 255, 120) cache.healthBar.Visible = true
                        else cache.healthBar.Visible = false end

                        if Settings.ESP_HeadDot and char:FindFirstChild("Head") then
                            local headV, headScreen = Camera:WorldToViewportPoint(char.Head.Position)
                            cache.headDot.Position = Vector2.new(headV.X, headV.Y) cache.headDot.Visible = headScreen
                        else se cache.headDot.Visible = false end

                        if Settings.ESP_ViewAngle and char:FindFirstChild("Head") then
                            local headV = char.Head.Position
                            local lookV = headV + (char.Head.CFrame.LookVector * 5)
                            local p1, on1 = Camera:WorldToViewportPoint(headV)
                            local p2, on2 = Camera:WorldToViewportPoint(lookV)
                            if on1 then
                                cache.viewAngle.From = Vector2.new(p1.X, p1.Y)
                                cache.viewAngle.To = Vector2.new(p2.X, p2.Y)
                                cache.viewAngle.Visible = true
                            else cache.viewAngle.Visible = false end
                        else cache.viewAngle.Visible = false end

                        cache.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        cache.tracer.To = Vector2.new(headVector.X, pos.Y + height) cache.tracer.Visible = Settings.ESP_Tracers

                        if Settings.ESP_Skeleton and char:FindFirstChild("Head") and char:FindFirstChild("UpperTorso") then
                            local function to2D(part) local v, on = Camera:WorldToViewportPoint(part.Position) return Vector2.new(v.X, v.Y), on end
                            cache.skeleton[1].From = to2D(char.Head) cache.skeleton[1].To = to2D(char.UpperTorso) cache.skeleton[1].Visible = true
                        else for _, l in pairs(cache.skeleton) do l.Visible = false end end
                        cache.offscreen.Visible = false
                    else
                        cache.box.Visible = false cache.boxFill.Visible = false cache.name.Visible = false cache.healthBar.Visible = false cache.tracer.Visible = false cache.headDot.Visible = false cache.viewAngle.Visible = false
                        for _, l in pairs(cache.skeleton) do l.Visible = false end

                        if Settings.ESP_Offscreen then
                            local camCFrame = Camera.CFrame
                            local relPos = camCFrame:VectorToObjectSpace(rootPart.Position - camCFrame.Position)
                            local angle = math.atan2(relPos.X, relPos.Z)
                            local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                            local radius = 130
                            local arrowPos = center + Vector2.new(math.cos(angle - math.pi/2), math.sin(angle - math.pi/2)) * radius
                            
                            cache.offscreen.PointA = arrowPos + Vector2.new(12, 12)
                            cache.offscreen.PointB = arrowPos - Vector2.new(12, 12)
                            cache.offscreen.PointC = arrowPos + Vector2.new(0, -6)
                            cache.offscreen.Visible = true
                        else cache.offscreen.Visible = false end
                    end
                else
                    if cache.highlight then cache.highlight:Destroy() cache.highlight = nil end
                    cache.box.Visible = false cache.boxFill.Visible = false cache.name.Visible = false cache.healthBar.Visible = false cache.tracer.Visible = false cache.offscreen.Visible = false cache.headDot.Visible = false cache.viewAngle.Visible = false
                    for _, l in pairs(cache.skeleton) do l.Visible = false end
                end
            end
        end
    end)
end)

Players.PlayerRemoving:Connect(removeESP)
print("Nebula X v49.4 Elite: Верхнее меню с иконками и весь функционал активированы!")
    
