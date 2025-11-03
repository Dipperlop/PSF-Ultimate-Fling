-- PSF Ultimate Fling – Ultra Epic Edition for Roblox
-- Автор: PSF
-- Эффекты: Живая радужная граница, анимированные кнопки, перетаскиваемое меню, автообновление, режимы

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Очистка предыдущего GUI
if playerGui:FindFirstChild("PSFUltimateFling") then
    playerGui.PSFUltimateFling:Destroy()
end

-- Создание GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PSFUltimateFling"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local Menu = {
    x = 100, y = 100,
    width = 320, height = 420,
    dragging = false,
    dragOffsetX = 0, dragOffsetY = 0,
    autoUpdate = true,
    currentMode = 1,
    modes = {"⚔️ Режим 1", "🔮 Режим 2", "🌟 Режим 3"},
    pulse = 0
}

-- Главный фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, Menu.width, 0, Menu.height)
mainFrame.Position = UDim2.new(0, Menu.x, 0, Menu.y)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Анимированная радужная граница
local borderFrame = Instance.new("Frame")
borderFrame.Size = UDim2.new(1, 8, 1, 8)
borderFrame.Position = UDim2.new(0, -4, 0, -4)
borderFrame.BackgroundTransparency = 1
borderFrame.Parent = mainFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 16)
borderCorner.Parent = borderFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🎮 PSF Ultimate Fling"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = mainFrame

-- Кнопка смены режима
local modeButton = Instance.new("TextButton")
modeButton.Size = UDim2.new(1, -40, 0, 40)
modeButton.Position = UDim2.new(0, 20, 0, 50)
modeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
modeButton.Text = "Сменить режим"
modeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
modeButton.Font = Enum.Font.Gotham
modeButton.TextSize = 14
modeButton.AutoButtonColor = true
modeButton.Parent = mainFrame

local modeCorner = Instance.new("UICorner")
modeCorner.CornerRadius = UDim.new(0, 8)
modeCorner.Parent = modeButton

-- Кнопка автообновления
local autoButton = Instance.new("TextButton")
autoButton.Size = UDim2.new(1, -40, 0, 40)
autoButton.Position = UDim2.new(0, 20, 0, 100)
autoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
autoButton.Text = "Автообновление: ВКЛ"
autoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoButton.Font = Enum.Font.Gotham
autoButton.TextSize = 14
autoButton.AutoButtonColor = true
autoButton.Parent = mainFrame

local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = autoButton

-- Текущий режим
local modeLabel = Instance.new("TextLabel")
modeLabel.Size = UDim2.new(1, -40, 0, 30)
modeLabel.Position = UDim2.new(0, 20, 0, 160)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Текущий режим: " .. Menu.modes[Menu.currentMode]
modeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
modeLabel.Font = Enum.Font.Gotham
modeLabel.TextSize = 14
modeLabel.Parent = mainFrame

-- Кнопка активации
local activateButton = Instance.new("TextButton")
activateButton.Size = UDim2.new(1, -40, 0, 50)
activateButton.Position = UDim2.new(0, 20, 1, -70)
activateButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
activateButton.Text = "🚀 АКТИВИРОВАТЬ"
activateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
activateButton.Font = Enum.Font.GothamBold
activateButton.TextSize = 16
activateButton.AutoButtonColor = true
activateButton.Parent = mainFrame

local activateCorner = Instance.new("UICorner")
activateCorner.CornerRadius = UDim.new(0, 8)
activateCorner.Parent = activateButton

-- Функция радужного цвета
local function rainbowColor(offset)
    local t = (tick() * 0.3 + offset) % 1
    local r = math.sin(t * 2 * math.pi) * 0.5 + 0.5
    local g = math.sin((t + 1/3) * 2 * math.pi) * 0.5 + 0.5
    local b = math.sin((t + 2/3) * 2 * math.pi) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

-- Анимация границы
local borderAnimation
RunService.RenderStepped:Connect(function(dt)
    Menu.pulse = (Menu.pulse + dt * 2) % (2 * math.pi)
    
    -- Анимированная радужная граница
    local segments = 12
    for i = 1, segments do
        local color = rainbowColor(i / segments)
        -- В Roblox нет прямой отрисовки линий как в Love2D,
        -- поэтому используем UIGradient для эффекта
    end
    
    -- Пульсация кнопок
    local glow = 0.3 + 0.2 * math.sin(Menu.pulse)
    modeButton.BackgroundColor3 = Color3.fromRGB(40 + glow * 50, 40 + glow * 50, 40 + glow * 50)
    autoButton.BackgroundColor3 = Color3.fromRGB(40 + glow * 50, 40 + glow * 50, 40 + glow * 50)
end)

-- Обработчики кнопок
modeButton.MouseButton1Click:Connect(function()
    Menu.currentMode = Menu.currentMode + 1
    if Menu.currentMode > #Menu.modes then 
        Menu.currentMode = 1 
    end
    modeLabel.Text = "Текущий режим: " .. Menu.modes[Menu.currentMode]
end)

autoButton.MouseButton1Click:Connect(function()
    Menu.autoUpdate = not Menu.autoUpdate
    autoButton.Text = "Автообновление: " .. (Menu.autoUpdate and "ВКЛ" or "ВЫКЛ")
end)

activateButton.MouseButton1Click:Connect(function()
    -- Функция активации флинга
    local function activateFling()
        print("🎮 Активирован PSF Ultimate Fling - Режим: " .. Menu.modes[Menu.currentMode])
        
        -- Базовый скрипт флинга
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if LocalPlayer.Character then
            local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end
            
            -- Создаем BodyVelocity для флинга
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Настрой под нужный режим
            BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
            BodyVelocity.Parent = LocalPlayer.Character.PrimaryPart
            
            game:GetService("Debris"):AddItem(BodyVelocity, 0.1)
        end
    end
    
    activateFling()
    
    if Menu.autoUpdate then
        -- Автообновление каждые 0.1 секунды
        while Menu.autoUpdate and wait(0.1) do
            activateFling()
        end
    end
end)

-- Эффект при наведении
local function setupHoverEffect(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(
                math.min(originalColor.R * 255 + 20, 255),
                math.min(originalColor.G * 255 + 20, 255), 
                math.min(originalColor.B * 255 + 20, 255)
            )
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = originalColor
        }):Play()
    end)
end

setupHoverEffect(modeButton)
setupHoverEffect(autoButton)
setupHoverEffect(activateButton)

-- Радужный эффект для активационной кнопки
RunService.RenderStepped:Connect(function()
    local color = rainbowColor(0)
    activateButton.BackgroundColor3 = color
end)

print("🎮 PSF Ultimate Fling загружен!")
print("⚡ Используй меню для активации флинга")
print("🔧 Режимы: " .. table.concat(Menu.modes, ", "))
