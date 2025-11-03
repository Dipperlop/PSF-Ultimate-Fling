--[[
  PSF Ultimate Fling – Ultra Epic Edition
  Автор: PSF
  Эффекты: Живая радужная граница, анимированные кнопки, перетаскиваемое меню, автообновление, режимы
--]]

local Menu = {
    x = 100, y = 100,
    width = 320, height = 420,
    dragging = false,
    dragOffsetX = 0, dragOffsetY = 0,
    autoUpdate = true,
    currentMode = 1,
    modes = {"Режим 1", "Режим 2", "Режим 3"},
    hover = nil,
    pulse = 0
}

local saveFile = "menu_position.lua"

-- Сохранение и загрузка позиции
local function savePosition()
    local f = io.open(saveFile, "w")
    if f then
        f:write("return {x="..Menu.x..", y="..Menu.y.."}")
        f:close()
    end
end

local function loadPosition()
    if love.filesystem.getInfo(saveFile) then
        local data = dofile(saveFile)
        Menu.x = data.x or Menu.x
        Menu.y = data.y or Menu.y
    end
end
loadPosition()

-- Радужный цвет
local function rainbowColor(offset)
    local t = (os.clock()*0.3 + offset) % 1
    local r = math.sin(t*2*math.pi)*0.5 + 0.5
    local g = math.sin((t+1/3)*2*math.pi)*0.5 + 0.5
    local b = math.sin((t+2/3)*2*math.pi)*0.5 + 0.5
    return r, g, b
end

-- Hover проверка
local function isHover(x, y, bx, by, bw, bh)
    return x > bx and x < bx+bw and y > by and y < by+bh
end

-- Обработка мыши
function love.mousepressed(x, y, button)
    if button == 1 then
        if x > Menu.x and x < Menu.x+Menu.width and y > Menu.y and y < Menu.y+30 then
            Menu.dragging = true
            Menu.dragOffsetX = x - Menu.x
            Menu.dragOffsetY = y - Menu.y
        end

        local btnY = Menu.y + 50
        if isHover(x, y, Menu.x+20, btnY, Menu.width-40, 40) then
            Menu.currentMode = Menu.currentMode + 1
            if Menu.currentMode > #Menu.modes then Menu.currentMode = 1 end
        end
        btnY = btnY + 50
        if isHover(x, y, Menu.x+20, btnY, Menu.width-40, 40) then
            Menu.autoUpdate = not Menu.autoUpdate
        end
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        Menu.dragging = false
        savePosition()
    end
end

function love.mousemoved(x, y, dx, dy)
    if Menu.dragging then
        Menu.x = x - Menu.dragOffsetX
        Menu.y = y - Menu.dragOffsetY
    end
    -- Hover обновление
    local btnY = Menu.y + 50
    if isHover(x, y, Menu.x+20, btnY, Menu.width-40, 40) then Menu.hover = "mode" else Menu.hover = nil end
    btnY = btnY + 50
    if isHover(x, y, Menu.x+20, btnY, Menu.width-40, 40) then Menu.hover = "auto" end
end

-- Обновление
function love.update(dt)
    Menu.pulse = (Menu.pulse + dt*2) % (2*math.pi)
end

-- Рисуем меню
function love.draw()
    -- Живая радужная граница
    local segments = 120
    for i=1,segments do
        local t = i/segments
        local r,g,b = rainbowColor(t)
        love.graphics.setColor(r,g,b)
        local angle1 = t*2*math.pi
        local angle2 = (t+1/segments)*2*math.pi
        local x1 = Menu.x + Menu.width/2 + math.sin(angle1)*Menu.width/2
        local y1 = Menu.y + Menu.height/2 + math.cos(angle1)*Menu.height/2
        local x2 = Menu.x + Menu.width/2 + math.sin(angle2)*Menu.width/2
        local y2 = Menu.y + Menu.height/2 + math.cos(angle2)*Menu.height/2
        love.graphics.setLineWidth(4)
        love.graphics.line(x1, y1, x2, y2)
    end

    -- Фон меню
    love.graphics.setColor(0.1,0.1,0.1,0.9)
    love.graphics.rectangle("fill", Menu.x, Menu.y, Menu.width, Menu.height, 12,12)

    -- Заголовок
    love.graphics.setColor(1,1,1)
    love.graphics.printf("PSF Ultimate Fling", Menu.x, Menu.y+5, Menu.width, "center")

    -- Кнопки с анимированным переливом
    local btnY = Menu.y + 50
    local btnWidth = Menu.width - 40
    local btnHeight = 40
    local btnX = Menu.x + 20
    local glow = 0.3 + 0.2 * math.sin(Menu.pulse)

    local function drawButton(text, hover)
        if hover then
            love.graphics.setColor(0.3+glow,0.3+glow,0.3+glow,0.95)
        else
            love.graphics.setColor(0.2,0.2,0.2,0.85)
        end
        love.graphics.rectangle("fill", btnX, btnY, btnWidth, btnHeight, 6,6)
        -- Перелив внутри кнопки
        for i=0,btnWidth,4 do
            local r,g,b = rainbowColor(i/btnWidth + os.clock()*0.1)
            love.graphics.setColor(r,g,b,0.5)
            love.graphics.rectangle("fill", btnX+i, btnY, 4, btnHeight)
        end
        love.graphics.setColor(1,1,1,0.9)
        love.graphics.printf(text, btnX, btnY+10, btnWidth, "center")
        btnY = btnY + 50
    end

    drawButton("Сменить режим", Menu.hover=="mode")
    drawButton("Автообновление: "..tostring(Menu.autoUpdate), Menu.hover=="auto")

    -- Текущий режим
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Текущий режим: "..Menu.modes[math.floor(Menu.currentMode)], Menu.x, btnY, Menu.width, "center")
end
