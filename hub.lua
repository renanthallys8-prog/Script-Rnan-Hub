local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Rnan Hub",
    Icon = "shield",
    Author = "by Renan",
    Folder = "Rnan Hub",
    Size = UDim2.fromOffset(400, 350),
    Theme = "Dark",
    Resizable = true,
})

local MainTab = Window:Tab({ Title = "Tsunami Brainrot", Icon = "home" })

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
