-- Mostrar notificação de carregamento
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RnanHubNotif"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local textLabel = Instance.new("TextLabel")
textLabel.Name = "NotifLabel"
textLabel.Size = UDim2.new(0, 300, 0, 100)
textLabel.Position = UDim2.new(0.5, -150, 0, 20)
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabel.BackgroundTransparency = 0.3
textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
textLabel.TextSize = 18
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "✓ Rnan Hub carregando..."
textLabel.Parent = screenGui

task.wait(1)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

textLabel.Text = "✓ WindUI carregado!"
task.wait(0.5)

local Window = WindUI:CreateWindow({
    Title = "Rnan Hub",
    Icon = "shield",
    Author = "by Renan",
    Folder = "Rnan Hub",
    Size = UDim2.fromOffset(400, 350),
    Theme = "Dark",
    Resizable = true,
})

textLabel.Text = "✓ Janela criada!"
task.wait(1)

-- Remover notificação
screenGui:Destroy()

local MainTab = Window:Tab({ Title = "Tsunami Brainrot", Icon = "home" })

-- Adicionar imagem no topo da janela
local imageSection = MainTab:Section({ Title = "" })

-- Criar ImageLabel customizado
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Encontrar a janela da WindUI
local rnanHubGui = playerGui:FindFirstChild("RnanHub") or playerGui:FindFirstChild("Rnan Hub")
if rnanHubGui then
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "HubIcon"
    imageLabel.Size = UDim2.new(0, 100, 0, 100)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = "https://i.imgur.com/ob1cHgw.png"
    imageLabel.Parent = rnanHubGui
end

-- ============ SEÇÃO DE TELEPORTE ============
local TeleportSection = MainTab:Section({ Title = "Teleportes" })

-- Função para teleportar
local function teleportToZone(zone)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    if zone and zone:IsA("Part") or zone:IsA("Model") then
        local targetPos = zone:IsA("Part") and zone.Position or zone:FindFirstChild("HumanoidRootPart") and zone.HumanoidRootPart.Position or zone:GetBoundingBox().Position
        humanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
    end
end

-- Detectar zonas automaticamente
local workspace = game:GetService("Workspace")
local zones = {}
local zoneIndex = 1

-- Procurar por partes grandes (plataformas)
for _, part in pairs(workspace:GetDescendants()) do
    if part:IsA("Part") and part.Size.Magnitude > 5 and part.CanCollide then
        if not part.Parent:FindFirstChild("Humanoid") then
            zones[zoneIndex] = part
            zoneIndex = zoneIndex + 1
            if zoneIndex > 10 then break end
        end
    end
end

-- Criar botões para cada zona
for i, zone in pairs(zones) do
    TeleportSection:Button({
        Title = "Teleportar para Zona " .. i,
        Description = "Ir para zona segura #" .. i,
        Callback = function()
            teleportToZone(zone)
        end,
    })
end

local isFlying = false
local speed = 0
local bodyVelocity = nil
local bodyGyro = nil
local flyingConnection = nil

local function startFlying(velocidade)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if not character then return end
    
    isFlying = true
    speed = velocidade
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    if flyingConnection then flyingConnection:Disconnect() end
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = humanoidRootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 10000
    bodyGyro.CFrame = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart
    
    flyingConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not isFlying or not humanoidRootPart.Parent then
            isFlying = false
            if flyingConnection then flyingConnection:Disconnect() end
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
            return
        end
        
        local camera = workspace.CurrentCamera
        local move = Vector3.new(0, 0, 0)
        local UserInputService = game:GetService("UserInputService")
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
        
        if move.Magnitude > 0 then move = move.Unit end
        bodyVelocity.Velocity = move * speed
        bodyGyro.CFrame = camera.CFrame
    end)
end

local Section1 = MainTab:Section({ Title = "Voar" })
Section1:Button({ Title = "Voar 30", Callback = function() startFlying(30) end })
Section1:Button({ Title = "Voar 100", Callback = function() startFlying(100) end })
Section1:Button({ Title = "Voar 200", Callback = function() startFlying(200) end })
Section1:Button({ Title = "Voar 300", Callback = function() startFlying(300) end })

local Section2 = MainTab:Section({ Title = "Andar" })
local function setSpeed(v) 
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then humanoid.WalkSpeed = v end
    end
end

Section2:Button({ Title = "Andar 30", Callback = function() setSpeed(30) end })
Section2:Button({ Title = "Andar 100", Callback = function() setSpeed(100) end })
Section2:Button({ Title = "Andar 200", Callback = function() setSpeed(200) end })
Section2:Button({ Title = "Andar 300", Callback = function() setSpeed(300) end })

print("✓ Hub carregado!")
