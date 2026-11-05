local P = game:GetService("Players")
local R = game:GetService("RunService")
local U = game:GetService("UserInputService")
local L = game:GetService("Lighting")
local C = workspace.CurrentCamera
local LP = P.LocalPlayer
local V = game:GetService("VirtualUser")
local D = game:GetService("Debris")
local Stats = game:GetService("Stats")
local TS = game:GetService("TeleportService")

local Settings = {
    ESP_Boxes = false, ESP_CornerBox = false, ESP_Chams = false, 
    ESP_ChamsFill = 0.5, ESP_Names = false, ESP_Health = false, 
    ESP_Distance = false, ESP_Rainbow = false, ESP_TeamCheck = true, 
    ESP_Tracers = false, ESP_HeadDot = false, ESP_Tools = false,
    Aimbot = false, AimAssist = false, AimBotNPC = false, 
    TriggerBot = false, ShowFOV = false, FOVRainbow = false, 
    HitBoxExpander = false, WallCheck = false, AimPart = "Head", 
    Smoothness = 3, FOV = 150, GameFOV = 70, HitSound = false, 
    AimHold = false, Prediction = false, AutoShoot = false, 
    LockTarget = false, InvisCheck = false, Crosshair = false, 
    TriggerDelay = 0.05, FireRange = 500, IgnoreDead = true,
    Speed = false, SpeedValue = 16, Jump = false, JumpValue = 50, 
    InfiniteJump = false, Fly = false, FlySpeed = 1, Noclip = false, 
    Freecam = false, GodMode = false, AntiVoid = false, 
    AutoRespawn = false, AntiAFK = true, AntiRagdoll = false, 
    TrueInvis = false, ClickTP = false, AutoClicker = false, 
    SpinBot = false, Fullbright = false, AntiFling = false, 
    SpamChat = false, SpamText = "Nebula X", FPSUnlock = false
}

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    return obj
end

local FOVC = Drawing.new("Circle")
FOVC.Visible = false FOVC.Transparency = 0.8 FOVC.Thickness = 1.5 FOVC.Filled = false

local CrossDrawing = Drawing.new("Line")
local CrossDrawing2 = Drawing.new("Line")
CrossDrawing.Thickness = 1 CrossDrawing2.Thickness = 1
CrossDrawing.Color = Color3.fromRGB(0, 255, 120) CrossDrawing2.Color = Color3.fromRGB(0, 255, 120)
CrossDrawing.Visible = false CrossDrawing2.Visible = false

local function Drag(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = obj.Position
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    U.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    obj.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false dragInput = nil
        end
    end)
end

local ScreenGui = Create("ScreenGui", {Name = "NebulaXPro", Parent = LP:WaitForChild("PlayerGui")})
local MainFrame = Create("Frame", {Parent = ScreenGui, Size = UDim2.new(0, 540, 0, 420), Position = UDim2.new(0.5, -270, 0.5, -210), BackgroundColor3 = Color3.fromRGB(18, 18, 24), BorderSizePixel = 0})
Create("UICorner", {Parent = MainFrame, CornerRadius = UDim.new(0, 10)})
Create("UIStroke", {Parent = MainFrame, Color = Color3.fromRGB(147, 112, 219), Thickness = 1.5})
Drag(MainFrame)

local TopBar = Create("Frame", {Parent = MainFrame, Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = Color3.fromRGB(25, 25, 35), BorderSizePixel = 0})
Create("UICorner", {Parent = TopBar, CornerRadius = UDim.new(0, 10)})
Create("Frame", {Parent = TopBar, Size = UDim2.new(1, 0, 0, 15), Position = UDim2.new(0, 0, 1, -15), BackgroundColor3 = Color3.fromRGB(25, 25, 35), BorderSizePixel = 0})
Create("TextLabel", {Parent = TopBar, Size = UDim2.new(1, -100, 1, 0), Position = UDim2.new(0, 15, 0, 0), BackgroundTransparency = 1, Text = "🔮 NEBULA X // V3.5", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left})

local StatusLabel = Create("TextLabel", {Parent = TopBar, Size = UDim2.new(0, 150, 1, 0), Position = UDim2.new(1, -170, 0, 0), BackgroundTransparency = 1, Text = "FPS: 60 | Ping: 0ms", TextColor3 = Color3.fromRGB(0, 255, 120), TextSize = 10, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Right})
local CloseBtn = Create("TextButton", {Parent = TopBar, Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, -35, 0, 5), BackgroundColor3 = Color3.fromRGB(255, 60, 80), Text = "✕", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Font = Enum.Font.GothamBold})
Create("UICorner", {Parent = CloseBtn, CornerRadius = UDim.new(0, 6)})
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local ToggleBtn = Create("TextButton", {Parent = ScreenGui, Size = UDim2.new(0, 45, 0, 45), Position = UDim2.new(0, 20, 0, 100), BackgroundColor3 = Color3.fromRGB(25, 25, 35), Text = "N", TextColor3 = Color3.fromRGB(147, 112, 219), TextSize = 18, Font = Enum.Font.GothamBold})
Create("UICorner", {Parent = ToggleBtn, CornerRadius = UDim.new(1, 0)})
Create("UIStroke", {Parent = ToggleBtn, Color = Color3.fromRGB(147, 112, 219), Thickness = 1.5})
Drag(ToggleBtn)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local AimBtn = Create("TextButton", {Parent = ScreenGui, Size = UDim2.new(0, 45, 0, 45), Position = UDim2.new(0.85, 0, 0.30, 0), BackgroundColor3 = Color3.fromRGB(25, 25, 35), Text = "🎯", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, Font = Enum.Font.GothamBold})
Create("UICorner", {Parent = AimBtn, CornerRadius = UDim.new(1, 0)})
local AimStroke = Create("UIStroke", {Parent = AimBtn, Color = Color3.fromRGB(255, 60, 80), Thickness = 1.5})
Drag(AimBtn)
AimBtn.MouseButton1Click:Connect(function() Settings.Aimbot = not Settings.Aimbot if Settings.Aimbot then AimStroke.Color = Color3.fromRGB(0, 255, 120) else AimStroke.Color = Color3.fromRGB(255, 60, 80) end end)

local TabBar = Create("Frame", {Parent = MainFrame, Size = UDim2.new(1, -20, 0, 35), Position = UDim2.new(0, 10, 0, 45), BackgroundTransparency = 1})
Create("UIListLayout", {Parent = TabBar, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5)})
local ContentArea = Create("Frame", {Parent = MainFrame, Size = UDim2.new(1, -20, 1, -90), Position = UDim2.new(0, 10, 0, 85), BackgroundTransparency = 1})
local Pages = {}

local function MakeTab(name)
    local page = Create("ScrollingFrame", {Parent = ContentArea, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = false, CanvasSize = UDim2.new(0, 0, 0, 1500), ScrollBarThickness = 2, ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219)})
    Create("UIListLayout", {Parent = page, Padding = UDim.new(0, 6)})
    local btn = Create("TextButton", {Parent = TabBar, Size = UDim2.new(0.19, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(30, 30, 45), Text = name, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 10, Font = Enum.Font.GothamBold})
    Create("UICorner", {Parent = btn, CornerRadius = UDim.new(0, 6)})
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        page.Visible = true
        for _, b in pairs(TabBar:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(200, 200, 200) b.BackgroundColor3 = Color3.fromRGB(30, 30, 45) end end
        btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    end)
    Pages[name] = page return page
end

local function AddToggle(page, name, key, cb)
    local btn = Create("TextButton", {Parent = page, Size = UDim2.new(1, -5, 0, 35), BackgroundColor3 = Color3.fromRGB(28, 28, 38), Text = "", AutoButtonColor = false})
    Create("UICorner", {Parent = btn, CornerRadius = UDim.new(0, 6)})
    Create("UIStroke", {Parent = btn, Color = Color3.fromRGB(45, 45, 60), Thickness = 1})
    Create("TextLabel", {Parent = btn, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = name, TextColor3 = Color3.fromRGB(220, 220, 230), TextSize = 11, Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Left})
    local switch = Create("Frame", {Parent = btn, Size = UDim2.new(0, 35, 0, 18), Position = UDim2.new(1, -45, 0.5, -9), BackgroundColor3 = Color3.fromRGB(50, 50, 65)})
    Create("UICorner", {Parent = switch, CornerRadius = UDim.new(1, 0)})
    local circle = Create("Frame", {Parent = switch, Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(150, 150, 160)})
    Create("UICorner", {Parent = circle, CornerRadius = UDim.new(1, 0)})
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state Settings[key] = state
        if state then
            switch.BackgroundColor3 = Color3.fromRGB(147, 112, 219) circle.Position = UDim2.new(1, -16, 0.5, -7) circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            switch.BackgroundColor3 = Color3.fromRGB(50, 50, 65) circle.Position = UDim2.new(0, 2, 0.5, -7) circle.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
        end
        if key == "Aimbot" then if state then AimStroke.Color = Color3.fromRGB(0, 255, 120) else AimStroke.Color = Color3.fromRGB(255, 60, 80) end end
        if cb then cb(state) end
    end)
end

local function AddCounter(page, name, initialValue, min, max, step, cb)
    local frame = Create("Frame", {Parent = page, Size = UDim2.new(1, -5, 0, 35), BackgroundColor3 = Color3.fromRGB(28, 28, 38)})
    Create("UICorner", {Parent = frame, CornerRadius = UDim.new(0, 6)})
    Create("UIStroke", {Parent = frame, Color = Color3.fromRGB(45, 45, 60), Thickness = 1})
    local label = Create("TextLabel", {Parent = frame, Size = UDim2.new(1, -80, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = name .. ": " .. initialValue, TextColor3 = Color3.fromRGB(220, 220, 230), TextSize = 11, Font = Enum.Font.GothamSemibold, TextXAlignment = Enum.TextXAlignment.Left})
    local minus = Create("TextButton", {Parent = frame, Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new(1, -60, 0.5, -12.5), BackgroundColor3 = Color3.fromRGB(45, 45, 60), Text = "-", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Font = Enum.Font.GothamBold})
    Create("UICorner", {Parent = minus, CornerRadius = UDim.new(0, 4)})
    local plus = Create("TextButton", {Parent = frame, Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new(1, -30, 0.5, -12.5), BackgroundColor3 = Color3.fromRGB(147, 112, 219), Text = "+", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Font = Enum.Font.GothamBold})
    Create("UICorner", {Parent = plus, CornerRadius = UDim.new(0, 4)})
    local current = initialValue
    local function update(val)
        current = math.clamp(current + val, min, max)
        label.Text = name .. ": " .. current
        if cb then cb(current) end
    end
    minus.MouseButton1Click:Connect(function() update(-step) end)
    plus.MouseButton1Click:Connect(function() update(step) end)
end

local function AddButton(page, text, cb)
    local btn = Create("TextButton", {Parent = page, Size = UDim2.new(1, -5, 0, 35), BackgroundColor3 = Color3.fromRGB(35, 30, 50), Text = text, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 11, Font = Enum.Font.GothamBold})
    Create("UICorner", {Parent = btn, CornerRadius = UDim.new(0, 6)})
    Create("UIStroke", {Parent = btn, Color = Color3.fromRGB(80, 60, 130), Thickness = 1})
    btn.MouseButton1Click:Connect(cb)
end

local ESPTab = MakeTab("ESP")
AddToggle(ESPTab, "Boxes", "ESP_Boxes")
AddToggle(ESPTab, "Corner Box", "ESP_CornerBox")
AddToggle(ESPTab, "Chams", "ESP_Chams")
AddCounter(ESPTab, "Chams Fill", Settings.ESP_ChamsFill, 0, 1, 0.1, function(v) Settings.ESP_ChamsFill = v end)
AddToggle(ESPTab, "Rainbow", "ESP_Rainbow")
AddToggle(ESPTab, "Names", "ESP_Names")
AddToggle(ESPTab, "Health", "ESP_Health")
AddToggle(ESPTab, "Distance", "ESP_Distance")
AddToggle(ESPTab, "Tool ESP", "ESP_Tools")
AddToggle(ESPTab, "Tracers", "ESP_Tracers")
AddToggle(ESPTab, "Head Dot", "ESP_HeadDot")
AddToggle(ESPTab, "Team Check", "ESP_TeamCheck")

local AIMTab = MakeTab("AIM")
AddToggle(AIMTab, "Aimbot", "Aimbot")
AddToggle(AIMTab, "Aim Assist", "AimAssist")
AddToggle(AIMTab, "Aim NPC", "AimBotNPC")
AddToggle(AIMTab, "TriggerBot", "TriggerBot")
AddCounter(AIMTab, "Trigger Delay", Settings.TriggerDelay, 0.01, 0.5, 0.01, function(v) Settings.TriggerDelay = v end)
AddToggle(AIMTab, "WallCheck", "WallCheck")
AddToggle(AIMTab, "Prediction", "Prediction")
AddToggle(AIMTab, "Auto-Shoot", "AutoShoot")
AddCounter(AIMTab, "Fire Range", Settings.FireRange, 50, 2000, 50, function(v) Settings.FireRange = v end)
AddToggle(AIMTab, "Lock Target", "LockTarget")
AddToggle(AIMTab, "Ignore Dead", "IgnoreDead")
AddToggle(AIMTab, "Ignore Invis", "InvisCheck")
AddToggle(AIMTab, "Show FOV", "ShowFOV")
AddToggle(AIMTab, "FOV Rainbow", "FOVRainbow")
AddToggle(AIMTab, "Crosshair", "Crosshair")
AddToggle(AIMTab, "HitBox", "HitBoxExpander")
AddCounter(AIMTab, "FOV Radius", Settings.FOV, 10, 800, 10, function(v) Settings.FOV = v end)
AddCounter(AIMTab, "Smooth", Settings.Smoothness, 0.5, 15, 0.5, function(v) Settings.Smoothness = v end)

local UtilTab = MakeTab("UTILS")
AddToggle(UtilTab, "Speedhack", "Speed")
AddCounter(UtilTab, "Speed Val", Settings.SpeedValue, 16, 200, 4, function(v) Settings.SpeedValue = v end)
AddToggle(UtilTab, "JumpPower", "Jump")
AddCounter(UtilTab, "Jump Val", Settings.JumpValue, 50, 500, 10, function(v) Settings.JumpValue = v end)
AddToggle(UtilTab, "Inf Jump", "InfiniteJump")
AddToggle(UtilTab, "Fly", "Fly")
AddCounter(UtilTab, "Fly Speed", Settings.FlySpeed, 1, 10, 1, function(v) Settings.FlySpeed = v end)
AddToggle(UtilTab, "Noclip", "Noclip")
AddToggle(UtilTab, "Freecam", "Freecam")
AddToggle(UtilTab, "Fullbright", "Fullbright")
AddToggle(UtilTab, "Anti-Fling", "AntiFling")
AddToggle(UtilTab, "Spam Chat", "SpamChat")
AddButton(UtilTab, "🔄 Rejoin Server", function() TS:Teleport(game.PlaceId, LP) end)
AddButton(UtilTab, "🚀 FPS Boost", function() for _, v in pairs(workspace:GetDescendants()) do if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then v.Enabled = false end end L.GlobalShadows = false end)

local ExtraTab = MakeTab("EXTRA")
AddToggle(ExtraTab, "GodMode", "GodMode")
AddToggle(ExtraTab, "Anti-Void", "AntiVoid")
AddToggle(ExtraTab, "Anti-Ragdoll", "AntiRagdoll")
AddToggle(ExtraTab, "Auto-Respawn", "AutoRespawn")
AddToggle(ExtraTab, "True Invis", "TrueInvis")
AddToggle(ExtraTab, "Click TP", "ClickTP")
AddToggle(ExtraTab, "Auto-Clicker", "AutoClicker")
AddToggle(ExtraTab, "SpinBot", "SpinBot")
AddToggle(ExtraTab, "Anti-AFK", "AntiAFK")

local TPTab = MakeTab("TP")
local TPScroll = Create("ScrollingFrame", {Parent = TPTab, Size = UDim2.new(1, 0, 0, 300), BackgroundTransparency = 1, CanvasSize = UDim2.new(0, 0, 0, 500), ScrollBarThickness = 2})
Create("UIListLayout", {Parent = TPScroll, Padding = UDim.new(0, 4)})
local function RefreshTP()
    for _, v in pairs(TPScroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, plr in pairs(P:GetPlayers()) do
        if plr ~= LP then
            local b = Create("TextButton", {Parent = TPScroll, Size = UDim2.new(1, -5, 0, 30), BackgroundColor3 = Color3.fromRGB(35, 30, 50), Text = "➔ " .. plr.Name, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 10, Font = Enum.Font.GothamSemibold})
            Create("UICorner", {Parent = b, CornerRadius = UDim.new(0, 6)})
            b.MouseButton1Click:Connect(function() if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LP.Character then LP.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0) end end)
        end
    end
end
AddButton(TPTab, "🔄 Обновить список", RefreshTP)
RefreshTP()

ESPTab.Visible = true
for _, b in pairs(TabBar:GetChildren()) do if b:IsA("TextButton") and b.Text == "ESP" then b.TextColor3 = Color3.fromRGB(255, 255, 255) b.BackgroundColor3 = Color3.fromRGB(147, 112, 219) end end
local FC, FRx, FRy
local BV, NPC, NT, lastHit, LockedTarget
local I_C = {}
local E_C, B_C, T_C = {}, {}, {}
local Tracers, HeadDots, CornerBoxes = {}, {}, {}
local SpamC = 0
local Fps, FpE = 0, 0

LP.Idled:Connect(function()
    if Settings.AntiAFK then V:Button2Down(Vector2.new(0,0), C.CFrame) task.wait(1) V:Button2Up(Vector2.new(0,0), C.CFrame) end
end)

U.InputChanged:Connect(function(i)
    if Settings.Freecam and FC and i.UserInputType == Enum.UserInputType.MouseMovement then
        if U:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            FRy = FRy - i.Delta.X * 0.005 FRx = math.clamp(FRx - i.Delta.Y * 0.005, -math.pi/2 + 0.01, math.pi/2 - 0.01)
            FC = CFrame.new(FC.Position) * CFrame.Angles(0, FRy, 0) * CFrame.Angles(FRx, 0, 0)
        end
    end
end)

local Mouse = LP:GetMouse()
Mouse.Button1Down:Connect(function()
    if Settings.ClickTP and Mouse.Target and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end
end)

U.JumpRequest:Connect(function()
    if Settings.InfiniteJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

P.PlayerRemoving:Connect(function(p)
    if E_C[p] then E_C[p]:Destroy() E_C[p] = nil end
    if B_C[p] then B_C[p]:Destroy() B_C[p] = nil end
    if Tracers[p] then Tracers[p]:Remove() Tracers[p] = nil end
    if HeadDots[p] then HeadDots[p]:Remove() HeadDots[p] = nil end
    if CornerBoxes[p] then for _, line in pairs(CornerBoxes[p]) do line:Remove() end CornerBoxes[p] = nil end
    T_C[p] = nil
end)

R.RenderStepped:Connect(function(dt)
    pcall(function()
        Fps = Fps + 1 FpE = FpE + dt
        if FpE >= 0.5 then
            local p = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            StatusLabel.Text = "FPS: " .. math.floor(Fps / FpE) .. " | Ping: " .. p .. "ms" Fps, FpE = 0, 0
        end
        
        local RC = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        FOVC.Position = Vector2.new(C.ViewportSize.X / 2, C.ViewportSize.Y / 2)
        FOVC.Radius = Settings.FOV FOVC.Visible = Settings.ShowFOV
        if Settings.FOVRainbow then FOVC.Color = RC else FOVC.Color = Color3.fromRGB(147, 112, 219) end
        
        C.FieldOfView = Settings.GameFOV
        if Settings.Crosshair then
            CrossDrawing.From = Vector2.new(C.ViewportSize.X / 2 - 5, C.ViewportSize.Y / 2) CrossDrawing.To = Vector2.new(C.ViewportSize.X / 2 + 5, C.ViewportSize.Y / 2)
            CrossDrawing2.From = Vector2.new(C.ViewportSize.X / 2, C.ViewportSize.Y / 2 - 5) CrossDrawing2.To = Vector2.new(C.ViewportSize.X / 2, C.ViewportSize.Y / 2 + 5)
            CrossDrawing.Visible = true CrossDrawing2.Visible = true
        else CrossDrawing.Visible = false CrossDrawing2.Visible = false end

        if Settings.SpamChat and tick() - SpamC > 2 then SpamC = tick() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Settings.SpamText, "All") end

        if Settings.Freecam then
            if not FC then FC = C.CFrame FRy = math.atan2(-FC.LookVector.X, -FC.LookVector.Z) FRx = math.asin(math.clamp(FC.LookVector.Y, -1, 1)) C.CameraType = Enum.CameraType.Scriptable end
            local mv = Vector3.zero
            if U:IsKeyDown(Enum.KeyCode.W) then mv = mv + FC.LookVector end
            if U:IsKeyDown(Enum.KeyCode.S) then mv = mv - FC.LookVector end
            if U:IsKeyDown(Enum.KeyCode.A) then mv = mv - FC.RightVector end
            if U:IsKeyDown(Enum.KeyCode.D) then mv = mv + FC.RightVector end
            if U:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.yAxis end
            if U:IsKeyDown(Enum.KeyCode.LeftControl) then mv = mv - Vector3.yAxis end
            if mv.Magnitude > 0 then mv = mv.Unit end
            FC = FC + mv * (Settings.FlySpeed * 50 * dt) C.CFrame = FC
        elseif FC then FC = nil C.CameraType = Enum.CameraType.Custom end

        if Settings.Aimbot or Settings.AimBotNPC then
            local tg, ap, sd = nil, nil, Settings.FOV
            if Settings.LockTarget and LockedTarget and LockedTarget.Parent and LockedTarget:FindFirstChild("Humanoid") and LockedTarget.Humanoid.Health > 0 then
                local a = LockedTarget:FindFirstChild(Settings.AimPart) or LockedTarget:FindFirstChild("Head")
                if a then
                    local ps, os = C:WorldToViewportPoint(a.Position)
                    if os then
                        local d = (Vector2.new(ps.X, ps.Y) - Vector2.new(C.ViewportSize.X / 2, C.ViewportSize.Y / 2)).Magnitude
                        if d < sd then tg = LockedTarget ap = a else LockedTarget = nil end
                    else LockedTarget = nil end
                end
            else
                LockedTarget = nil
                for _, p in ipairs(P:GetPlayers()) do
                    if p ~= LP and p.Character then
                        local a = p.Character:FindFirstChild(Settings.AimPart) or p.Character:FindFirstChild("Head")
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if a and hum and (not Settings.IgnoreDead or hum.Health > 0) then
                            if not Settings.InvisCheck or a.Transparency < 0.5 then
                                local predictPos = a.Position
                                if Settings.Prediction and p.Character:FindFirstChild("HumanoidRootPart") then
                                    local vel = p.Character.HumanoidRootPart.Velocity
                                    local dist = (a.Position - C.CFrame.Position).Magnitude
                                    predictPos = a.Position + (vel * (dist / 1000))
                                end
                                local ps, os = C:WorldToViewportPoint(predictPos)
                                if os then
                                    local d = (Vector2.new(ps.X, ps.Y) - Vector2.new(C.ViewportSize.X / 2, C.ViewportSize.Y / 2)).Magnitude
                                    if d < sd then
                                        if not Settings.ESP_TeamCheck or not p.Team or p.Team ~= LP.Team then
                                            local ok = true
                                            if Settings.WallCheck then
                                                local rp = RaycastParams.new() rp.FilterDescendantsInstances = {LP.Character, p.Character}
                                                if workspace:Raycast(C.CFrame.Position, a.Position - C.CFrame.Position, rp) then ok = false end
                                            end
                                            if ok then sd = d tg = p.Character ap = {Position = predictPos} end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if ap then
                if Settings.LockTarget and not LockedTarget then LockedTarget = tg end
                if not Settings.AimHold or U:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, ap.Position), 1 / Settings.Smoothness) end
                if Settings.AutoShoot and (C.CFrame.Position - ap.Position).Magnitude <= Settings.FireRange then V:Button1Down(Vector2.new(0, 0)) task.wait(0.01) V:Button1Up(Vector2.new(0, 0)) end
            else LockedTarget = nil end
        end

        if Settings.TriggerBot then
            local rp = RaycastParams.new() rp.FilterDescendantsInstances = {LP.Character}
            local rs = workspace:Raycast(C.CFrame.Position, C.CFrame.LookVector * 1000, rp)
            if rs and rs.Instance then
                local m = rs.Instance.Parent
                local hm = m and m:FindFirstChildOfClass("Humanoid")
                if hm and hm.Health > 0 then
                    local p = P:GetPlayerFromCharacter(m)
                    if not p or (p ~= LP and not (Settings.ESP_TeamCheck and p.Team == LP.Team)) then
                        V:Button1Down(Vector2.new(0, 0)) task.wait(Settings.TriggerDelay) V:Button1Up(Vector2.new(0, 0))
                        if Settings.HitSound and tick() - (lastHit or 0) > 0.3 then lastHit = tick() local s = Instance.new("Sound", workspace) s.SoundId = "rbxassetid://9069176472" s:Play() D:AddItem(s, 1) end
                    end
                end
            end
        end

        local ch = LP.Character
        if ch then
            local hm = ch:FindFirstChildOfClass("Humanoid")
            local rt = ch:FindFirstChild("HumanoidRootPart")
            if hm and rt then
                if Settings.Speed then hm.WalkSpeed = Settings.SpeedValue end
                if Settings.Jump then hm.JumpPower = Settings.JumpValue end
                if Settings.GodMode then hm.Health = math.huge end
                if Settings.AntiFling then rt.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1) end
                if Settings.AntiVoid and rt.Position.Y < -50 then rt.CFrame = rt.CFrame + Vector3.new(0, 100, 0) end
                if Settings.Noclip then for _, p in pairs(ch:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
                
                if Settings.Fly and rt then
                    if not BV or BV.Parent ~= rt then
                        if BV then BV:Destroy() end
                        BV = Instance.new("BodyVelocity") BV.MaxForce = Vector3.new(1e5, 1e5, 1e5) BV.Parent = rt
                    end
                    local mv = Vector3.zero
                    if U:IsKeyDown(Enum.KeyCode.W) then mv = mv + C.CFrame.LookVector end
                    if U:IsKeyDown(Enum.KeyCode.S) then mv = mv - C.CFrame.LookVector end
                    if U:IsKeyDown(Enum.KeyCode.A) then mv = mv - C.CFrame.RightVector end
                    if U:IsKeyDown(Enum.KeyCode.D) then mv = mv + C.CFrame.RightVector end
                    if U:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.yAxis end
                    if U:IsKeyDown(Enum.KeyCode.LeftControl) then mv = mv - Vector3.yAxis end
                    if mv.Magnitude > 0 then mv = mv.Unit end
                    BV.Velocity = mv * Settings.FlySpeed * 50
                elseif BV then BV:Destroy() BV = nil end
            end
        end

        for _, p in ipairs(P:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
                local pc = p.Character
                local head = pc:FindFirstChild("Head")
                local hrp = pc:FindFirstChild("HumanoidRootPart")
                
                local hl = E_C[p]
                if Settings.ESP_Boxes or Settings.ESP_Chams then
                    if not hl or hl.Parent ~= pc then
                        if hl then hl:Destroy() end
                        hl = Instance.new("Highlight") hl.Parent = pc E_C[p] = hl
                    end
                    hl.FillTransparency = 1 - Settings.ESP_ChamsFill
                    hl.OutlineColor = Settings.ESP_Rainbow and RC or Color3.fromRGB(220, 80, 255)
                    hl.FillColor = Settings.ESP_Rainbow and RC or Color3.fromRGB(220, 80, 255)
                elseif hl then hl:Destroy() E_C[p] = nil end

                local bb = B_C[p]
                if Settings.ESP_Names or Settings.ESP_Health or Settings.ESP_Distance or Settings.ESP_Tools then
                    if not bb or bb.Parent ~= pc then
                        if bb then bb:Destroy() end
                        bb = Instance.new("BillboardGui", pc) bb.Size = UDim2.new(0, 200, 0, 50) bb.StudsOffset = Vector3.new(0, 2.5, 0) bb.AlwaysOnTop = true
                        local tx = Instance.new("TextLabel", bb) tx.Size = UDim2.new(1, 0, 1, 0) tx.BackgroundTransparency = 1 tx.TextColor3 = Color3.fromRGB(255, 255, 255) tx.TextStrokeTransparency = 0 tx.TextSize = 11
                        B_C[p] = bb T_C[p] = tx
                    end
                    local tx = T_C[p]
                    if tx then
                        local t = ""
                        if Settings.ESP_Names then t = t .. p.Name .. "\n" end
                        local hm = pc:FindFirstChildOfClass("Humanoid")
                        if Settings.ESP_Health and hm then t = t .. "HP: " .. math.floor(hm.Health) .. "\n" end
                        if Settings.ESP_Tools and pc:FindFirstChildOfClass("Tool") then t = t .. "🔫 " .. pc:FindFirstChildOfClass("Tool").Name .. "\n" end
                        if Settings.ESP_Distance and hrp then t = t .. "[" .. math.floor((LP.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) .. "m]" end
                        tx.Text = t
                    end
                elseif bb then bb:Destroy() B_C[p] = nil T_C[p] = nil end
                
                if Settings.ESP_CornerBox and hrp then
                    if not CornerBoxes[p] then
                        CornerBoxes[p] = {}
                        for i = 1, 8 do CornerBoxes[p][i] = Drawing.new("Line") CornerBoxes[p][i].Thickness = 1 end
                    end
                    local pos, onScreen = C:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local size = Vector2.new(50, 50)
                        local topLeft = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
                        local botRight = Vector2.new(pos.X + size.X/2, pos.Y + size.Y/2)
                        local len = 10
                        local lines = CornerBoxes[p]
                        lines[1].From = topLeft lines[1].To = topLeft + Vector2.new(len, 0)
                        lines[2].From = topLeft lines[2].To = topLeft + Vector2.new(0, len)
                        lines[3].From = Vector2.new(botRight.X, topLeft.Y) lines[3].To = Vector2.new(botRight.X - len, topLeft.Y)
                        lines[4].From = Vector2.new(botRight.X, topLeft.Y) lines[4].To = Vector2.new(botRight.X, topLeft.Y + len)
                        lines[5].From = Vector2.new(topLeft.X, botRight.Y) lines[5].To = Vector2.new(topLeft.X + len, botRight.Y)
                        lines[6].From = Vector2.new(topLeft.X, botRight.Y) lines[6].To = Vector2.new(topLeft.X, botRight.Y - len)
                        lines[7].From = botRight lines[7].To = botRight - Vector2.new(len, 0)
                        lines[8].From = botRight lines[8].To = botRight - Vector2.new(0, len)
                        for _, l in pairs(lines) do l.Color = Settings.ESP_Rainbow and RC or Color3.fromRGB(255, 60, 80) l.Visible = true end
                    else for _, l in pairs(CornerBoxes[p]) do l.Visible = false end end
                elseif CornerBoxes[p] then for _, l in pairs(CornerBoxes[p]) do l:Remove() end CornerBoxes[p] = nil end

                if Settings.ESP_Tracers then
                    if not Tracers[p] then Tracers[p] = Drawing.new("Line") Tracers[p].Thickness = 1 end
                    local ps, os = C:WorldToViewportPoint(hrp.Position)
                    if os then
                        Tracers[p].From = Vector2.new(C.ViewportSize.X / 2, C.ViewportSize.Y)
                        Tracers[p].To = Vector2.new(ps.X, ps.Y)
                        Tracers[p].Color = Settings.ESP_Rainbow and RC or Color3.fromRGB(220, 80, 255)
                        Tracers[p].Visible = true
                    else Tracers[p].Visible = false end
                elseif Tracers[p] then Tracers[p]:Remove() Tracers[p] = nil end
                
                if Settings.ESP_HeadDot then
                    if not HeadDots[p] then HeadDots[p] = Drawing.new("Circle") HeadDots[p].Radius = 5 HeadDots[p].Filled = true end
                    local ps, os = C:WorldToViewportPoint(head.Position)
                    if os then
                        HeadDots[p].Position = Vector2.new(ps.X, ps.Y)
                        HeadDots[p].Color = Settings.ESP_Rainbow and RC or Color3.fromRGB(220, 80, 255)
                        HeadDots[p].Visible = true
                    else HeadDots[p].Visible = false end
                elseif HeadDots[p] then HeadDots[p]:Remove() HeadDots[p] = nil end
            elseif HeadDots[p] then HeadDots[p]:Remove() HeadDots[p] = nil end
            end
        end

        for _, p in ipairs(P:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local rp = p.Character.HumanoidRootPart
                if Settings.HitBoxExpander then
                    if rp.Size ~= Vector3.new(6, 6, 6) then 
                        rp.Size = Vector3.new(6, 6, 6) 
                        rp.Transparency = 0.5 
                        rp.Color = Color3.fromRGB(255, 0, 0) 
                    end
                else 
                    if rp.Size ~= Vector3.new(2, 2, 1) then 
                        rp.Size = Vector3.new(2, 2, 1) 
                        rp.Transparency = 1 
                    end 
                end
            end
        end

        if Settings.TrueInvis then
            local ch = LP.Character
            if ch then 
                for _, pr in ipairs(ch:GetDescendants()) do 
                    if (pr:IsA("BasePart") or pr:IsA("Decal")) and not I_C[pr] then 
                        I_C[pr] = pr.Transparency 
                        pr.Transparency = 1 
                    end 
                end 
            end
        else
            for pr, tr in pairs(I_C) do 
                if pr and pr.Parent then pr.Transparency = tr end 
            end 
            I_C = {}
        end
    end)
end)
