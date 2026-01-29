# Script-Rnan-Hub

## 📥 Como usar

Cole isso no executor (Delta, etc):

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/renanthallys8-prog/Script-Rnan-Hub/main/hub.lua"))()
```

## ✨ Funcionalidades

- ✅ Sistema de Voo (Velocidades: 30, 100, 200, 300)
- ✅ Velocidade de Andar (Velocidades: 30, 100, 200, 300)
- 🎮 Controles: WASD, Space, Ctrl
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
Title = "Rnan Hub",
Icon = "shield",
Author = "by Renan",
Folder = "Rnan Hub",
Size = UDim2.fromOffset(580, 460),
MinSize = Vector2.new(560, 350),
MaxSize = Vector2.new(850, 560),
Transparent = true,
Theme = "Dark",
Resizable = true,
SideBarWidth = 200,
BackgroundImageTransparency = 0.42,
HideSearchBar = true,
ScrollBarEnabled = false,
User = {
Enabled = true,
Anonymous = false,
Callback = function()
print("User clicked!")
end,
},
-- KeySystem foi REMOVIDO completamente
-- Nenhuma key, nenhum grace, abre direto
})
-- O resto do código continua igual (tabs, toggles, etc.)
local MainTab = Window:Tab({ Title = "comandos!", Icon = "home" 