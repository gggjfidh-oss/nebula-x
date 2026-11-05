local P=game:GetService("Players")
local R=game:GetService("RunService")
local U=game:GetService("UserInputService")
local L=game:GetService("Lighting")
local C=workspace.CurrentCamera
local LP=P.LocalPlayer
local V=game:GetService("VirtualUser")
local D=game:GetService("Debris")
local CG=game:GetService("CoreGui")

local S={ESP_Boxes=false,ESP_Chams=false,ESP_Names=false,ESP_Health=false,ESP_Distance=false,ESP_Rainbow=false,ESP_TeamCheck=true,Aimbot=false,AimBotNPC=false,TriggerBot=false,ShowFOV=false,HitBoxExpander=false,WallCheck=false,AimPart="Head",Smoothness=3,FOV=150,GameFOV=70,HitSound=false,Speed=false,SpeedMultiplier=0.6,Jump=false,InfiniteJump=false,Bhop=false,Fly=false,FlySpeed=1,Noclip=false,WaterWalk=false,InfiniteZoom=false,NightVision=false,Freecam=false,GodMode=false,AntiVoid=false,AutoRespawn=false,AntiAFK=true,AntiRagdoll=false,TrueInvis=false,ClickTP=false,AutoClicker=false,SpinBot=false,Fullbright=false}

local FOVC=Drawing.new("Circle")
FOVC.Visible=false
FOVC.Transparency=0.7
FOVC.Thickness=1.5
FOVC.Color=Color3.fromRGB(220,80,255)
FOVC.Filled=false

local function Drag(o)
    local d,dI,dS,sP
    o.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            d=true dS=i.Position sP=o.Position
        end
    end)
    o.InputChanged:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            dI=i
        end
    end)
    U.InputChanged:Connect(function(i)
        if i==dI and d then
            local dl=i.Position-dS
            o.Position=UDim2.new(sP.X.Scale,sP.X.Offset+dl.X,sP.Y.Scale,sP.Y.Offset+dl.Y)
        end
    end)
    o.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            d=false dI=nil
        end
    end)
end

local G=Instance.new("ScreenGui",LP:WaitForChild("PlayerGui"))
G.Name="NebulaXV2"
local M=Instance.new("Frame",G)
M.Size=UDim2.new(0,520,0,390)
M.Position=UDim2.new(0.5,-260,0.5,-195)
M.BackgroundColor3=Color3.fromRGB(15,12,25)
Instance.new("UICorner",M).CornerRadius=UDim.new(0,12)
Instance.new("UIStroke",M).Color=Color3.fromRGB(220,80,255)
Drag(M)

local B=Instance.new("TextButton",G)
B.Size=UDim2.new(0,45,0,45) B.Position=UDim2.new(0,20,0,100)
B.BackgroundColor3=Color3.fromRGB(20,20,32) B.Text="N"
B.TextColor3=Color3.fromRGB(255,215,0) B.TextSize=20
Instance.new("UICorner",B).CornerRadius=UDim.new(1,0)
Drag(B)
B.MouseButton1Click:Connect(function() M.Visible=not M.Visible end)

local Ti=Instance.new("TextLabel",M)
Ti.Size=UDim2.new(1,-30,0,32) Ti.Position=UDim2.new(0,10,0,0)
Ti.BackgroundTransparency=1 Ti.Text="🔮 NEBULA X // V2.5"
Ti.TextColor3=Color3.fromRGB(240,220,255) Ti.TextSize=11
Ti.Font=Enum.Font.GothamBold Ti.TextXAlignment=Enum.TextXAlignment.Left

local St=Instance.new("TextLabel",M)
St.Size=UDim2.new(0,120,0,32) St.Position=UDim2.new(1,-145,0,0)
St.BackgroundTransparency=1 St.Text="FPS: 60 | Ping: 0ms"
St.TextColor3=Color3.fromRGB(0,255,150) St.TextSize=9
St.Font=Enum.Font.GothamBold St.TextXAlignment=Enum.TextXAlignment.Right

local Cl=Instance.new("TextButton",M)
Cl.Size=UDim2.new(0,24,0,24) Cl.Position=UDim2.new(1,-28,0,4)
Cl.BackgroundColor3=Color3.fromRGB(220,50,70) Cl.Text="✕"
Cl.TextColor3=Color3.fromRGB(255,255,255)
Instance.new("UICorner",Cl).CornerRadius=UDim.new(0,6)
Cl.MouseButton1Click:Connect(function() G:Destroy() end)

local TB=Instance.new("Frame",M)
TB.Size=UDim2.new(1,0,0,38) TB.Position=UDim2.new(0,0,0,32)
TB.BackgroundColor3=Color3.fromRGB(20,15,30) TB.BorderSizePixel=0
local TL=Instance.new("UIListLayout",TB)
TL.FillDirection=Enum.FillDirection.Horizontal
TL.HorizontalAlignment=Enum.HorizontalAlignment.Center
TL.Padding=UDim.new(0,4)

local Co=Instance.new("Frame",M)
Co.Size=UDim2.new(1,-16,1,-80) Co.Position=UDim2.new(0,8,0,74)
Co.BackgroundTransparency=1

local Pgs={}
local function CTab(n)
    local p=Instance.new("ScrollingFrame",Co)
    p.Size=UDim2.new(1,0,1,0) p.BackgroundTransparency=1 p.Visible=false
    p.CanvasSize=UDim2.new(0,0,0,1500) p.ScrollBarThickness=3
    local l=Instance.new("UIListLayout",p) l.Padding=UDim.new(0,6)
    local b=Instance.new("TextButton",TB)
    b.Size=UDim2.new(0,70,1,-4) b.BackgroundColor3=Color3.fromRGB(30,25,45)
    b.Text=n b.TextColor3=Color3.fromRGB(240,240,250) b.TextSize=10
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    b.MouseButton1Click:Connect(function()
        for _,v in pairs(Pgs) do v.Visible=false end
        p.Visible=true
    end)
    Pgs[n]=p
    return p
end

local function Tog(p,n,k)
    local b=Instance.new("TextButton",p)
    b.Size=UDim2.new(1,-4,0,32) b.BackgroundColor3=Color3.fromRGB(25,20,40)
    b.Text="  "..n..": [OFF]" b.TextColor3=Color3.fromRGB(240,240,255)
    b.TextSize=10 b.Font=Enum.Font.GothamBold
    b.TextXAlignment=Enum.TextXAlignment.Left
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    local s=Instance.new("UIStroke",b) s.Color=Color3.fromRGB(180,100,255)
    local st=false
    b.MouseButton1Click:Connect(function()
        st=not st
        b.BackgroundColor3=st and Color3.fromRGB(20,160,80) or Color3.fromRGB(25,20,40)
        b.Text="  "..n..": "..(st and "[ON]" or "[OFF]")
        s.Color=st and Color3.fromRGB(0,255,120) or Color3.fromRGB(180,100,255)
        if k then S[k]=st end
    end)
end

local function Btn(p,t,f)
    local b=Instance.new("TextButton",p)
    b.Size=UDim2.new(1,-4,0,32) b.BackgroundColor3=Color3.fromRGB(35,25,50)
    b.Text="  "..t b.TextColor3=Color3.fromRGB(255,255,255)
    b.TextSize=10 b.Font=Enum.Font.GothamBold
    b.TextXAlignment=Enum.TextXAlignment.Left
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    b.MouseButton1Click:Connect(f)
end

local E=CTab("ESP")
Tog(E,"Boxes","ESP_Boxes") Tog(E,"Chams","ESP_Chams")
Tog(E,"Rainbow","ESP_Rainbow") Tog(E,"Names","ESP_Names")
Tog(E,"Health","ESP_Health") Tog(E,"Distance","ESP_Distance")
Tog(E,"Team Check","ESP_TeamCheck")

local A=CTab("AIM")
Tog(A,"Aimbot","Aimbot") Tog(A,"Aim NPC","AimBotNPC")
Tog(A,"TriggerBot","TriggerBot") Tog(A,"HitSound","HitSound")
Tog(A,"Show FOV","ShowFOV") Tog(A,"HitBox","HitBoxExpander")
Tog(A,"WallCheck","WallCheck")
Btn(A,"⚡ Скорость: [Быстро]",function()
    if S.Smoothness==3 then S.Smoothness=1.5
    elseif S.Smoothness==1.5 then S.Smoothness=6
    else S.Smoothness=3 end
end)
Btn(A,"⭕ FOV: [150]",function()
    if S.FOV==150 then S.FOV=250 FOVC.Radius=250
    elseif S.FOV==250 then S.FOV=9999 FOVC.Radius=600
    else S.FOV=150 FOVC.Radius=150 end
end)

local U_T=CTab("UTILS")
Tog(U_T,"Speedhack","Speed") Tog(U_T,"JumpPower","Jump")
Tog(U_T,"Inf Jump","InfiniteJump") Tog(U_T,"Bhop","Bhop")
Tog(U_T,"Fly","Fly") Tog(U_T,"Noclip","Noclip")
Tog(U_T,"Freecam","Freecam") Tog(U_T,"WaterWalk","WaterWalk")
Tog(U_T,"Inf Zoom","InfiniteZoom") Tog(U_T,"NightVision","NightVision")
Tog(U_T,"Fullbright","Fullbright")
Btn(U_T,"👟 Скорость: [0.6]",function()
    if S.SpeedMultiplier==0.6 then S.SpeedMultiplier=1.2
    elseif S.SpeedMultiplier==1.2 then S.SpeedMultiplier=2.5
    else S.SpeedMultiplier=0.6 end
end)
Btn(U_T,"✈️ Полет: [1x]",function()
    if S.FlySpeed==1 then S.FlySpeed=2.5
    elseif S.FlySpeed==2.5 then S.FlySpeed=5
    else S.FlySpeed=1 end
end)
Btn(U_T,"🔭 Обзор: [70]",function()
    if S.GameFOV==70 then S.GameFOV=95
    elseif S.GameFOV==95 then S.GameFOV=120
    else S.GameFOV=70 end
end)

local X=CTab("EXTRA")
Tog(X,"GodMode","GodMode") Tog(X,"Anti-Ragdoll","AntiRagdoll")
Tog(X,"Anti-AFK","AntiAFK") Tog(X,"True Invis","TrueInvis")
Tog(X,"Auto-Respawn","AutoRespawn") Tog(X,"Anti-Void","AntiVoid")
Tog(X,"Click TP","ClickTP") Tog(X,"Auto-Clicker","AutoClicker")
Tog(X,"SpinBot","SpinBot")

local TP=CTab("TP")
local TSc=Instance.new("ScrollingFrame",TP)
TSc.Size=UDim2.new(1,0,1,0) TSc.BackgroundTransparency=1
TSc.CanvasSize=UDim2.new(0,0,0,500) TSc.ScrollBarThickness=3
local TLy=Instance.new("UIListLayout",TSc) TLy.Padding=UDim.new(0,4)

local function Refresh()
    for _,c in ipairs(TSc:GetChildren()) do
        if c:IsA("TextButton") and c.Name~="Ref" then c:Destroy() end
    end
    for _,p in ipairs(P:GetPlayers()) do
        if p~=LP then
            local b=Instance.new("TextButton",TSc)
            b.Size=UDim2.new(1,-4,0,32) b.BackgroundColor3=Color3.fromRGB(30,50,80)
            b.Text="  ➔ TP к: "..p.Name b.TextColor3=Color3.fromRGB(255,255,255) b.TextSize=10
            Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
            b.MouseButton1Click:Connect(function()
                pcall(function()
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                        LP.Character.HumanoidRootPart.CFrame=p.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0)
                    end
                end)
            end)
        end
    end
end

local RB=Instance.new("TextButton",TSc)
RB.Name="Ref" RB.Size=UDim2.new(1,-4,0,32)
RB.BackgroundColor3=Color3.fromRGB(80,40,120)
RB.Text="  🔄 Обновить" RB.TextColor3=Color3.fromRGB(255,255,255) RB.TextSize=10
Instance.new("UICorner",RB).CornerRadius=UDim.new(0,6)
RB.MouseButton1Click:Connect(Refresh)
Refresh()

for _,v in pairs(Pgs) do v.Visible=false end
Pgs["ESP"].Visible=true

local FC,FRx,FRy
U.InputChanged:Connect(function(i)
    if S.Freecam and FC and i.UserInputType==Enum.UserInputType.MouseMovement then
        if U:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            FRy=FRy-i.Delta.X*0.005
            FRx=math.clamp(FRx-i.Delta.Y*0.005,-math.pi/2+0.01,math.pi/2-0.01)
            FC=CFrame.new(FC.Position)*CFrame.Angles(0,FRy,0)*CFrame.Angles(FRx,0,0)
        end
    end
end)

local BV,NPC,NT
LP.Idled:Connect(function()
    if S.AntiAFK then
        V:Button2Down(Vector2.new(0,0),C.CFrame) task.wait(1) V:Button2Up(Vector2.new(0,0),C.CFrame)
    end
end)

local Mouse=LP:GetMouse()
Mouse.Button1Down:Connect(function()
    if S.ClickTP and Mouse.Target and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame=CFrame.new(Mouse.Hit.Position+Vector3.new(0,3,0))
    end
end)

U.JumpRequest:Connect(function()
    if S.InfiniteJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local I_C={}
local E_C,T_C,B_C={},{},{}
P.PlayerRemoving:Connect(function(p)
    if E_C[p] then E_C[p]:Destroy() E_C[p]=nil end
    if B_C[p] then B_C[p]:Destroy() B_C[p]=nil end
    T_C[p]=nil
end)

local Fps,FpE=0,0
R.RenderStepped:Connect(function(dt)
    pcall(function()
        Fps=Fps+1 FpE=FpE+dt
        if FpE>=0.5 then
            local p=math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            St.Text="FPS: "..math.floor(Fps/FpE).." | Ping: "..p.."ms"
            Fps,FpE=0,0
        end
        FOVC.Position=Vector2.new(C.ViewportSize.X/2,C.ViewportSize.Y/2)
        FOVC.Radius=S.FOV FOVC.Visible=S.ShowFOV
        C.FieldOfView=S.GameFOV

        if S.Freecam then
            if not FC then
                FC=C.CFrame
                FRy=math.atan2(-FC.LookVector.X,-FC.LookVector.Z)
                FRx=math.asin(math.clamp(FC.LookVector.Y,-1,1))
                C.CameraType=Enum.CameraType.Scriptable
            end
            local mv=Vector3.zero
            if U:IsKeyDown(Enum.KeyCode.W) then mv=mv+FC.LookVector end
            if U:IsKeyDown(Enum.KeyCode.S) then mv=mv-FC.LookVector end
            if U:IsKeyDown(Enum.KeyCode.A) then mv=mv-FC.RightVector end
            if U:IsKeyDown(Enum.KeyCode.D) then mv=mv+FC.RightVector end
            if U:IsKeyDown(Enum.KeyCode.Space) then mv=mv+Vector3.yAxis end
            if U:IsKeyDown(Enum.KeyCode.LeftControl) then mv=mv-Vector3.yAxis end
            if mv.Magnitude>0 then mv=mv.Unit end
            FC=FC+mv*(S.FlySpeed*50*dt) C.CFrame=FC
        elseif FC then
            FC=nil C.CameraType=Enum.CameraType.Custom
        end

        if S.Aimbot or S.AimBotNPC then
            local tg,ap,sd=nil,nil,S.FOV
            for _,p in ipairs(P:GetPlayers()) do
                if p~=LP and p.Character then
                    local a=p.Character:FindFirstChild(S.AimPart) or p.Character:FindFirstChild("Head")
                    if a then
                        local ps,os=C:WorldToViewportPoint(a.Position)
                        if os then
                            local d=(Vector2.new(ps.X,ps.Y)-Vector2.new(C.ViewportSize.X/2,C.ViewportSize.Y/2)).Magnitude
                            if d<sd then
                                if not S.ESP_TeamCheck or not p.Team or p.Team~=LP.Team then
                                    local ok=true
                                    if S.WallCheck then
                                        local rp=RaycastParams.new()
                                        rp.FilterDescendantsInstances={LP.Character,p.Character}
                                        if workspace:Raycast(C.CFrame.Position,a.Position-C.CFrame.Position,rp) then ok=false end
                                    end
                                    if ok then sd=d tg=p.Character ap=a end
                                end
                            end
                        end
                    end
                end
            end
            if S.AimBotNPC and tick()-(NT or 0)>0.5 then
                NT=tick() NPC={}
                for _,o in ipairs(workspace:GetDescendants()) do
                    if o:IsA("Humanoid") and o.Health>0 then
                        local m=o.Parent
                        if m and m:IsA("Model") and not P:GetPlayerFromCharacter(m) then
                            table.insert(NPC,m)
                        end
                    end
                end
            end
            if S.AimBotNPC then
                for _,m in ipairs(NPC) do
                    if m.Parent then
                        local a=m:FindFirstChild(S.AimPart) or m:FindFirstChild("Head")
                        if a then
                            local ps,os=C:WorldToViewportPoint(a.Position)
                            if os then
                                local d=(Vector2.new(ps.X,ps.Y)-Vector2.new(C.ViewportSize.X/2,C.ViewportSize.Y/2)).Magnitude
                                if d<sd then
                                    local ok=true
                                    if S.WallCheck then
                                        local rp=RaycastParams.new()
                                        rp.FilterDescendantsInstances={LP.Character,m}
                                        if workspace:Raycast(C.CFrame.Position,a.Position-C.CFrame.Position,rp) then ok=false end
                                    end
                                    if ok then sd=d tg=m ap=a end
                                end
                            end
                        end
                    end
                end
            end
            if ap then
                C.CFrame=C.CFrame:Lerp(CFrame.new(C.CFrame.Position,ap.Position),1/S.Smoothness)
            end
        end

        if S.TriggerBot then
            local rp=RaycastParams.new()
            rp.FilterDescendantsInstances={LP.Character}
            local rs=workspace:Raycast(C.CFrame.Position,C.CFrame.LookVector*1000,rp)
            if rs and rs.Instance then
                local m=rs.Instance.Parent
                local hm=m and m:FindFirstChildOfClass("Humanoid")
                if hm and hm.Health>0 then
                    local p=P:GetPlayerFromCharacter(m)
                    if not p or (p~=LP and not (S.ESP_TeamCheck and p.Team==LP.Team)) then
                        V:Button1Down(Vector2.new(0,0)) task.wait(0.02) V:Button1Up(Vector2.new(0,0))
                        if S.HitSound and tick()-(lastHit or 0)>0.3 then
                            lastHit=tick()
                            local s=Instance.new("Sound",workspace)
                            s.SoundId="rbxassetid://9069176472" s:Play() D:AddItem(s,1)
                        end
                    end
                end
            end
        end

        local ch=LP.Character
        if ch then
            local hm=ch:FindFirstChildOfClass("Humanoid")
            local rt=ch:FindFirstChild("HumanoidRootPart")
            if S.Speed and hm and rt and hm.MoveDirection.Magnitude>0 then
                rt.CFrame=rt.CFrame+hm.MoveDirection*S.SpeedMultiplier
            end
            if S.Jump and hm then hm.JumpPower=130 end
            if S.GodMode and hm then hm.Health=math.huge end
            if S.AntiRagdoll and hm then
                hm:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
                hm:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
            end
            if S.AutoRespawn and hm and hm.Health<=0 then LP:LoadCharacter() end
            if S.Bhop and hm and hm.MoveDirection.Magnitude>0 then hm:ChangeState(Enum.HumanoidStateType.Jumping) end
            if S.WaterWalk and rt then
                local r=workspace:Raycast(rt.Position,Vector3.new(0,-10,0))
                if r then
                    rt.CFrame=rt.CFrame+Vector3.new(0,(r.Position.Y+3)-rt.Position.Y,0)
                    rt.Velocity=Vector3.new(rt.Velocity.X,0,rt.Velocity.Z)
                end
            end
            if S.AntiVoid and rt and rt.Position.Y<-50 then rt.CFrame=rt.CFrame+Vector3.new(0,100,0) end
            if S.Noclip then
                for _,p in pairs(ch:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
            end
            if S.Fly and rt then
                if not BV or BV.Parent~=rt then
                    if BV then BV:Destroy() end
                    BV=Instance.new("BodyVelocity")
                    BV.MaxForce=Vector3.new(1e5,1e5,1e5) BV.Parent=rt
                end
                local mv=Vector3.zero
                if U:IsKeyDown(Enum.KeyCode.W) then mv=mv+C.CFrame.LookVector end
                if U:IsKeyDown(Enum.KeyCode.S) then mv=mv-C.CFrame.LookVector end
                if U:IsKeyDown(Enum.KeyCode.A) then mv=mv-C.CFrame.RightVector end
                if U:IsKeyDown(Enum.KeyCode.D) then mv=mv+C.CFrame.RightVector end
                if U:IsKeyDown(Enum.KeyCode.Space) then mv=mv+Vector3.yAxis end
                if U:IsKeyDown(Enum.KeyCode.LeftControl) then mv=mv-Vector3.yAxis end
                if mv.Magnitude>0 then mv=mv.Unit end
                BV.Velocity=mv*S.FlySpeed*50
            elseif BV then BV:Destroy() BV=nil end
            if S.SpinBot and rt then rt.CFrame=rt.CFrame*CFrame.Angles(0,math.rad(35),0) end
        end

        if S.AutoClicker then V:Button1Down(Vector2.new(0,0)) task.wait(0.05) V:Button1Up(Vector2.new(0,0)) end
        if S.Fullbright or S.NightVision then L.Brightness=3 L.GlobalShadows=false L.OutdoorAmbient=Color3.fromRGB(150,150,150) end

        local RC=Color3.fromHSV(tick()%5/5,1,1)
        for _,p in ipairs(P:GetPlayers()) do
            if p~=LP and p.Character and p.Character:FindFirstChild("Head") then
                local pc=p.Character
                local hl=E_C[p]
                if S.ESP_Boxes or S.ESP_Chams then
                    if not hl or hl.Parent~=pc then
                        if hl then hl:Destroy() end
                        hl=Instance.new("Highlight",pc) E_C[p]=hl
                    end
                    hl.FillTransparency=S.ESP_Chams and 0.2 or 0.5
                    hl.OutlineColor=S.ESP_Rainbow and RC or Color3.fromRGB(220,80,255)
                    hl.FillColor=S.ESP_Chams and (S.ESP_Rainbow and RC or Color3.fromRGB(220,80,255)) or Color3.fromRGB(255,255,255)
                elseif hl then hl:Destroy() E_C[p]=nil end

                local bb=B_C[p]
                ESP_Distance then
                            if not bb or bb.Parent~=pc then
                                if bb then bb:Destroy() end
                                bb=Instance.new("BillboardGui",pc)
                                bb.Size=UDim2.new(0,200,0,50) bb.StudsOffset=Vector3.new(0,2.5,0) bb.AlwaysOnTop=true
                                local tx=Instance.new("TextLabel",bb)
                                tx.Size=UDim2.new(1,0,1,0) tx.BackgroundTransparency=1
                                tx.TextColor3=Color3.fromRGB(255,255,255) tx.TextStrokeTransparency=0 tx.TextSize=11
                                B_C[p]=bb T_C[p]=tx
                            end
                            local tx=T_C[p]
                            if tx then
                                local t=""
                                if S.ESP_Names then t=t..p.Name.."\n" end
                                local hm=pc:FindFirstChildOfClass("Humanoid")
                                if S.ESP_Health and hm then t=t.."HP: "..math.floor(hm.Health).."\n" end
                                if S.ESP_Distance and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                                    t=t.."["..math.floor((LP.Character.HumanoidRootPart.Position-pc.Head.Position).Magnitude).."m]"
                                end
                                tx.Text=t
                            end
                        elseif bb then bb:Destroy() B_C[p]=nil T_C[p]=nil end
                    end
                end

                for _,p in ipairs(P:GetPlayers()) do
                    if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local rp=p.Character.HumanoidRootPart
                        if S.HitBoxExpander then
                            if rp.Size~=Vector3.new(5,5,5) then rp.Size=Vector3.new(5,5,5) rp.Transparency=0.5 rp.Color=Color3.fromRGB(255,0,0) end
                        else
                            if rp.Size~=Vector3.new(2,2,1) then rp.Size=Vector3.new(2,2,1) rp.Transparency=1 end
                        end
                    end
                end

                if S.TrueInvis then
                    local ch=LP.Character
                    if ch then
                        for _,pr in ipairs(ch:GetDescendants()) do
                            if (pr:IsA("BasePart") or pr:IsA("Decal")) and not I_C[pr] then
                                I_C[pr]=pr.Transparency pr.Transparency=1
                            end
                        end
                    end
                else
                    for pr,tr in pairs(I_C) do
                        if pr and pr.Parent then pr.Transparency=tr end
                    end
                    I_C={}
                end
            end)
        end)
