-- CrystalLev Platform
if getgenv().CrystalLevPlatform then return end
getgenv().CrystalLevPlatform = { Version = "1.0.0" }

-- Сервисы
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Контейнер
local GUI = nil
pcall(function()
    if gethui then GUI = gethui() end
end)
if not GUI then
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(PlayerGui)
            GUI = PlayerGui
        end
    end)
end
if not GUI then GUI = CoreGui end

-- Удаляем старый UI если есть
for _, v in pairs(GUI:GetChildren()) do
    if v.Name == "CrystalLev_Platform" then v:Destroy() end
end

-- Защита
local function Protect(obj)
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(obj) end
    end)
end

-- Создание элементов
local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k == "Children" then
            for _, c in pairs(v) do c.Parent = obj end
        elseif k == "Parent" then
            obj.Parent = v
        else
            pcall(function() obj[k] = v end)
        end
    end
    Protect(obj)
    return obj
end

-- Анимация
local function Tween(obj, time, props)
    local t = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

-- Перетаскивание
local function Draggable(frame, dragObj)
    dragObj = dragObj or frame
    local dragging, startPos, startMouse
    dragObj.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = frame.Position
            startMouse = i.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - startMouse
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Тема
local Theme = {
    Accent = Color3.fromRGB(0, 255, 140),
    BG = Color3.fromRGB(18, 18, 18),
    BG2 = Color3.fromRGB(28, 28, 28),
    BG3 = Color3.fromRGB(38, 38, 38),
    Text = Color3.fromRGB(255, 255, 255),
    Text2 = Color3.fromRGB(160, 160, 160),
    Red = Color3.fromRGB(255, 60, 60),
    Blue = Color3.fromRGB(80, 140, 255),
    Orange = Color3.fromRGB(255, 160, 40),
}

-- Проект
local Project = {
    Name = "MyHub",
    Author = "User",
    Tabs = {},
}

-- ========================================
-- UI
-- ========================================

local ScreenGui = Create("ScreenGui", {
    Name = "CrystalLev_Platform",
    Parent = GUI,
    ResetOnSpawn = false,
})

local Main = Create("Frame", {
    Name = "Main",
    Size = UDim2.new(0, 700, 0, 480),
    Position = UDim2.new(0.5, -350, 0.5, -240),
    BackgroundColor3 = Theme.BG,
    BorderSizePixel = 0,
    Parent = ScreenGui,
    ClipsDescendants = true,
})

-- Анимация появления
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Tween(Main, 0.4, {Size = UDim2.new(0, 700, 0, 480)})
Tween(Main, 0.4, {Position = UDim2.new(0.5, -350, 0.5, -240)})

-- Title Bar
local TitleBar = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Main,
})

Create("TextLabel", {
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 12, 0, 0),
    BackgroundTransparency = 1,
    Text = "💎 CrystalLev Platform",
    TextColor3 = Theme.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = TitleBar,
})

Draggable(Main, TitleBar)

-- Project Info
local InfoPanel = Create("Frame", {
    Size = UDim2.new(1, -20, 0, 50),
    Position = UDim2.new(0, 10, 0, 45),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Main,
})

Create("TextLabel", {
    Size = UDim2.new(0, 45, 0, 20),
    Position = UDim2.new(0, 8, 0, 5),
    BackgroundTransparency = 1,
    Text = "Name:",
    TextColor3 = Theme.Text2,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = InfoPanel,
})

local NameInput = Create("TextBox", {
    Size = UDim2.new(0, 140, 0, 22),
    Position = UDim2.new(0, 55, 0, 4),
    BackgroundColor3 = Theme.BG3,
    Text = "MyHub",
    TextColor3 = Theme.Text,
    PlaceholderColor3 = Theme.Text2,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    BorderSizePixel = 0,
    Parent = InfoPanel,
})

Create("TextLabel", {
    Size = UDim2.new(0, 45, 0, 20),
    Position = UDim2.new(0, 210, 0, 5),
    BackgroundTransparency = 1,
    Text = "Author:",
    TextColor3 = Theme.Text2,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = InfoPanel,
})

local AuthorInput = Create("TextBox", {
    Size = UDim2.new(0, 140, 0, 22),
    Position = UDim2.new(0, 257, 0, 4),
    BackgroundColor3 = Theme.BG3,
    Text = "User",
    TextColor3 = Theme.Text,
    PlaceholderColor3 = Theme.Text2,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    BorderSizePixel = 0,
    Parent = InfoPanel,
})

NameInput.FocusLost:Connect(function() Project.Name = NameInput.Text end)
AuthorInput.FocusLost:Connect(function() Project.Author = AuthorInput.Text end)

-- Left Panel (Tabs)
local LeftPanel = Create("Frame", {
    Size = UDim2.new(0.38, -5, 1, -150),
    Position = UDim2.new(0, 10, 0, 105),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Main,
})

Create("Frame", {
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = LeftPanel,
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 8, 0, 0),
    BackgroundTransparency = 1,
    Text = "📁 Tabs",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = LeftPanel,
})

local TabList = Create("ScrollingFrame", {
    Size = UDim2.new(1, -10, 1, -65),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundColor3 = Theme.BG2,
    ScrollBarThickness = 3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = LeftPanel,
})

Create("UIListLayout", {
    Padding = UDim.new(0, 3),
    Parent = TabList,
})

local AddTabBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 28),
    Position = UDim2.new(0, 5, 1, -35),
    BackgroundColor3 = Theme.Accent,
    Text = "+ Add Tab",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = LeftPanel,
})

-- Right Panel (Elements)
local RightPanel = Create("Frame", {
    Size = UDim2.new(0.58, -5, 1, -150),
    Position = UDim2.new(0.40, 0, 0, 105),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Main,
})

Create("Frame", {
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = RightPanel,
})

Create("TextLabel", {
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 8, 0, 0),
    BackgroundTransparency = 1,
    Text = "📦 Elements",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = RightPanel,
})

local ElementList = Create("ScrollingFrame", {
    Size = UDim2.new(1, -10, 1, -65),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundColor3 = Theme.BG2,
    ScrollBarThickness = 3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = RightPanel,
})

Create("UIListLayout", {
    Padding = UDim.new(0, 3),
    Parent = ElementList,
})

local AddElementBtn = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 28),
    Position = UDim2.new(0, 5, 1, -35),
    BackgroundColor3 = Theme.Blue,
    Text = "+ Add Element",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = RightPanel,
})

-- Bottom Buttons
local ExportBtn = Create("TextButton", {
    Size = UDim2.new(0, 180, 0, 32),
    Position = UDim2.new(1, -190, 1, -40),
    BackgroundColor3 = Theme.Accent,
    Text = "📤 Export Code",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    BorderSizePixel = 0,
    Parent = Main,
})

-- ========================================
-- ЛОГИКА
-- ========================================
local selectedTab = nil
local editingElement = nil

-- Добавление вкладки
AddTabBtn.MouseButton1Click:Connect(function()
    local name = "Tab " .. (#Project.Tabs + 1)
    table.insert(Project.Tabs, { Name = name, Elements = {} })
    RefreshTabs()
    
    Tween(AddTabBtn, 0.1, {BackgroundColor3 = Color3.fromRGB(50, 255, 150)})
    wait(0.1)
    Tween(AddTabBtn, 0.1, {BackgroundColor3 = Theme.Accent})
end)

-- Обновление списка вкладок
function RefreshTabs()
    for _, v in pairs(TabList:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    
    for i, tab in pairs(Project.Tabs) do
        local f = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundColor3 = Theme.BG3,
            BorderSizePixel = 0,
            Parent = TabList,
        })
        
        local btn = Create("TextButton", {
            Size = UDim2.new(1, -30, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            BackgroundTransparency = 1,
            Text = tab.Name,
            TextColor3 = Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            Parent = f,
        })
        
        btn.MouseButton1Click:Connect(function()
            selectedTab = tab
            RefreshElements()
        end)
        
        local delBtn = Create("TextButton", {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -25, 0, 4),
            BackgroundColor3 = Theme.Red,
            Text = "X",
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            BorderSizePixel = 0,
            Parent = f,
        })
        
        delBtn.MouseButton1Click:Connect(function()
            table.remove(Project.Tabs, i)
            if selectedTab == tab then selectedTab = nil end
            RefreshTabs()
            RefreshElements()
        end)
    end
    
    TabList.CanvasSize = UDim2.new(0, 0, 0, #Project.Tabs * 32)
end

-- Обновление списка элементов
function RefreshElements()
    for _, v in pairs(ElementList:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    
    if not selectedTab then return end
    
    for i, el in pairs(selectedTab.Elements) do
        local typeColor = Theme.Blue
        if el.Type == "Toggle" then typeColor = Theme.Orange
        elseif el.Type == "Slider" then typeColor = Theme.Accent
        end
        
        local f = Create("Frame", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundColor3 = Theme.BG3,
            BorderSizePixel = 0,
            Parent = ElementList,
        })
        
        Create("Frame", {
            Size = UDim2.new(0, 3, 1, 0),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
            Parent = f,
        })
        
        local btn = Create("TextButton", {
            Size = UDim2.new(1, -35, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            BackgroundTransparency = 1,
            Text = "[" .. el.Type .. "] " .. el.Name,
            TextColor3 = Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            Parent = f,
        })
        
        btn.MouseButton1Click:Connect(function()
            editingElement = el
            OpenScriptEditor(el)
        end)
        
        local delBtn = Create("TextButton", {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -25, 0, 4),
            BackgroundColor3 = Theme.Red,
            Text = "X",
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            BorderSizePixel = 0,
            Parent = f,
        })
        
        delBtn.MouseButton1Click:Connect(function()
            table.remove(selectedTab.Elements, i)
            RefreshElements()
        end)
    end
    
    ElementList.CanvasSize = UDim2.new(0, 0, 0, #selectedTab.Elements * 32)
end

-- Добавление элемента
AddElementBtn.MouseButton1Click:Connect(function()
    if not selectedTab then
        -- Показать подсказку
        local hint = Create("TextLabel", {
            Size = UDim2.new(0, 200, 0, 25),
            Position = UDim2.new(0.5, -100, 0.5, -12),
            BackgroundColor3 = Theme.Red,
            Text = "⚠️ Выбери вкладку сначала!",
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            BorderSizePixel = 0,
            Parent = Main,
            ZIndex = 50,
        })
        wait(1.5)
        hint:Destroy()
        return
    end
    
    -- Меню выбора типа
    local menu = Create("Frame", {
        Size = UDim2.new(0, 160, 0, 140),
        Position = UDim2.new(0.5, -80, 0.5, -70),
        BackgroundColor3 = Theme.BG2,
        BorderSizePixel = 0,
        Parent = Main,
        ZIndex = 50,
    })
    
    Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundColor3 = Theme.BG3,
        Text = "Выбери тип",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        Parent = menu,
    })
    
    local types = {"Button", "Toggle", "Slider", "Dropdown"}
    for i, t in pairs(types) do
        local typeBtn = Create("TextButton", {
            Size = UDim2.new(1, -20, 0, 23),
            Position = UDim2.new(0, 10, 0, 28 + (i-1) * 26),
            BackgroundColor3 = Theme.BG3,
            Text = t,
            TextColor3 = Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            BorderSizePixel = 0,
            Parent = menu,
            ZIndex = 51,
        })
        
        typeBtn.MouseButton1Click:Connect(function()
            local el = { Name = "New" .. t, Type = t, Script = "" }
            if t == "Slider" then el.Min = 1; el.Max = 100 end
            table.insert(selectedTab.Elements, el)
            menu:Destroy()
            RefreshElements()
        end)
    end
end)

-- Редактор скриптов
local scriptEditor = Create("Frame", {
    Name = "ScriptEditor",
    Size = UDim2.new(0, 400, 0, 300),
    Position = UDim2.new(0.5, -200, 0.5, -150),
    BackgroundColor3 = Theme.BG,
    BorderSizePixel = 0,
    Parent = Main,
    Visible = false,
    ZIndex = 60,
})

Create("Frame", {
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = scriptEditor,
})

Create("TextLabel", {
    Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "✏️ Script Editor",
    TextColor3 = Theme.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = scriptEditor,
})

local closeEditorBtn = Create("TextButton", {
    Size = UDim2.new(0, 25, 0, 25),
    Position = UDim2.new(1, -30, 0, 2),
    BackgroundColor3 = Theme.Red,
    Text = "X",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = scriptEditor,
})

closeEditorBtn.MouseButton1Click:Connect(function()
    scriptEditor.Visible = false
end)

local scriptBox = Create("TextBox", {
    Size = UDim2.new(1, -20, 1, -70),
    Position = UDim2.new(0, 10, 0, 40),
    BackgroundColor3 = Theme.BG3,
    TextColor3 = Theme.Text,
    PlaceholderText = "Пиши Lua код сюда...",
    PlaceholderColor3 = Theme.Text2,
    Font = Enum.Font.Code,
    TextSize = 12,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    BorderSizePixel = 0,
    Parent = scriptEditor,
})

Create("TextButton", {
    Size = UDim2.new(0, 100, 0, 25),
    Position = UDim2.new(0, 10, 1, -32),
    BackgroundColor3 = Theme.Accent,
    Text = "Save",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = scriptEditor,
}).MouseButton1Click:Connect(function()
    if editingElement then
        editingElement.Script = scriptBox.Text
    end
    scriptEditor.Visible = false
end)

Draggable(scriptEditor, scriptEditor:FindFirstChildOfClass("Frame"))

function OpenScriptEditor(element)
    editingElement = element
    scriptBox.Text = element.Script or ""
    scriptEditor.Visible = true
    scriptEditor.ZIndex = 70
end

-- ========================================
-- ГЕНЕРАЦИЯ КОДА
-- ========================================
local function GenerateCode()
    local tabs = Project.Tabs
    
    local code = [[
-- 💎 Generated by CrystalLev Platform
-- Hub: ]] .. Project.Name .. [[
-- Author: ]] .. Project.Author .. [[

if getgenv().]] .. Project.Name .. [[ then return end
getgenv().]] .. Project.Name .. [[ = true

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local function GetContainer()
    local s, r = pcall(function()
        if gethui then return gethui() end
        if syn and syn.protect_gui then syn.protect_gui(PlayerGui); return PlayerGui end
        return CoreGui
    end)
    return (s and r) and r or CoreGui
end

local GUI = GetContainer()

for _, v in pairs(GUI:GetChildren()) do
    if v.Name == "]] .. Project.Name .. [[_Hub" then v:Destroy() end
end

local function Protect(obj)
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(obj) end end)
end

local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k == "Children" then for _, c in pairs(v) do c.Parent = obj end
        elseif k == "Parent" then obj.Parent = v
        else pcall(function() obj[k] = v end) end
    end
    Protect(obj)
    return obj
end

local function Tween(obj, time, props)
    local t = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function Draggable(frame, dragObj)
    dragObj = dragObj or frame
    local d, sp, sm
    dragObj.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            d = true; sp = frame.Position; sm = i.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if d and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - sm
            frame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end
    end)
end

local Accent = Color3.fromRGB(0, 255, 140)

-- ScreenGui
local ScreenGui = Create("ScreenGui", { Name = "]] .. Project.Name .. [[_Hub", Parent = GUI })

-- Main Window
local Main = Create("Frame", {
    Name = "Main",
    Size = UDim2.new(0, 550, 0, 380),
    Position = UDim2.new(0.5, -275, 0.5, -190),
    BackgroundColor3 = Color3.fromRGB(18, 18, 18),
    BorderSizePixel = 0,
    Parent = ScreenGui,
})

Tween(Main, 0.3, {Size = UDim2.new(0, 550, 0, 380)})

-- Title
local TitleBar = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 35),
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    BorderSizePixel = 0,
    Parent = Main,
})

Create("TextLabel", {
    Size = UDim2.new(1, -70, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "💎 ]] .. Project.Name .. [[",
    TextColor3 = Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = TitleBar,
})

Create("TextLabel", {
    Size = UDim2.new(0, 65, 1, 0),
    Position = UDim2.new(1, -70, 0, 0),
    BackgroundTransparency = 1,
    Text = "CrystalLev",
    TextColor3 = Color3.fromRGB(80, 80, 80),
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Right,
    Parent = TitleBar,
})

Draggable(Main, TitleBar)

-- Tab Bar
local TabBar = Create("Frame", {
    Size = UDim2.new(0, 130, 1, -35),
    Position = UDim2.new(0, 0, 0, 35),
    BackgroundColor3 = Color3.fromRGB(22, 22, 22),
    BorderSizePixel = 0,
    Parent = Main,
})

Create("UIListLayout", { Padding = UDim.new(0, 2), Parent = TabBar })

-- Content Area
local Content = Create("Frame", {
    Size = UDim2.new(1, -135, 1, -40),
    Position = UDim2.new(0, 135, 0, 35),
    BackgroundColor3 = Color3.fromRGB(18, 18, 18),
    BorderSizePixel = 0,
    Parent = Main,
})

Create("UIListLayout", { Padding = UDim.new(0, 4), Parent = Content })

local openedTab = nil
]]

    for _, tab in pairs(tabs) do
        local tName = tab.Name:gsub("[^%w]", "_")
        
        code = code .. [[

-- Tab: ]] .. tab.Name .. [[
local TabBtn_]] .. tName .. [[ = Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 30),
    Position = UDim2.new(0, 5, 0, 0),
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    Text = "]] .. tab.Name .. [[",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = TabBar,
})

local Content_]] .. tName .. [[ = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Visible = false,
    Parent = Content,
})
]]

        for _, el in pairs(tab.Elements) do
            local eName = el.Name:gsub("[^%w]", "_")
            
            if el.Type == "Button" then
                code = code .. [[
Create("TextButton", {
    Size = UDim2.new(1, -20, 0, 28),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundColor3 = Color3.fromRGB(38, 38, 38),
    Text = "]] .. el.Name .. [[",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = Content_]] .. tName .. [[,
}).MouseButton1Click:Connect(function()
    ]] .. (el.Script or "") .. [[
end)
]]
            elseif el.Type == "Toggle" then
                code = code .. [[
local Toggle_]] .. eName .. [[_State = false
local Toggle_]] .. eName .. [[ = Create("Frame", {
    Size = UDim2.new(1, -20, 0, 30),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundColor3 = Color3.fromRGB(38, 38, 38),
    BorderSizePixel = 0,
    Parent = Content_]] .. tName .. [[,
})

Create("TextLabel", {
    Size = UDim2.new(0, 200, 1, 0),
    Position = UDim2.new(0, 8, 0, 0),
    BackgroundTransparency = 1,
    Text = "]] .. el.Name .. [[",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Toggle_]] .. eName .. [[,
})

local Toggle_]] .. eName .. [[_Btn = Create("Frame", {
    Size = UDim2.new(0, 35, 0, 18),
    Position = UDim2.new(1, -43, 0.5, -9),
    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
    BorderSizePixel = 0,
    Parent = Toggle_]] .. eName .. [[,
})

local Toggle_]] .. eName .. [[_Dot = Create("Frame", {
    Size = UDim2.new(0, 14, 0, 14),
    Position = UDim2.new(0, 2, 0.5, -7),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BorderSizePixel = 0,
    Parent = Toggle_]] .. eName .. [[_Btn,
})

Toggle_]] .. eName .. [[_Btn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        Toggle_]] .. eName .. [[_State = not Toggle_]] .. eName .. [[_State
        Tween(Toggle_]] .. eName .. [[_Btn, 0.2, {BackgroundColor3 = Toggle_]] .. eName .. [[_State and Accent or Color3.fromRGB(60, 60, 60)})
        Tween(Toggle_]] .. eName .. [[_Dot, 0.2, {Position = UDim2.new(0, Toggle_]] .. eName .. [[_State and 19 or 2, 0.5, -7)})
        ]] .. (el.Script or "") .. [[
    end
end)
]]
            end
        end
        
        code = code .. [[
TabBtn_]] .. tName .. [[.MouseButton1Click:Connect(function()
    if openedTab then openedTab.Visible = false end
    Content_]] .. tName .. [[.Visible = true
    openedTab = Content_]] .. tName .. [[
end)
]]
    end
    
    if #tabs > 0 then
        local firstName = tabs[1].Name:gsub("[^%w]", "_")
        code = code .. [[
-- Open first tab
Content_]] .. firstName .. [[.Visible = true
openedTab = Content_]] .. firstName .. [[
]]
    end
    
    return code
end

-- ========================================
-- ЭКСПОРТ
-- ========================================
ExportBtn.MouseButton1Click:Connect(function()
    local code = GenerateCode()
    
    local exportFrame = Create("Frame", {
        Size = UDim2.new(0, 500, 0, 380),
        Position = UDim2.new(0.5, -250, 0.5, -190),
        BackgroundColor3 = Theme.BG,
        BorderSizePixel = 0,
        Parent = Main,
        ZIndex = 80,
    })
    
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Theme.BG2,
        BorderSizePixel = 0,
        Parent = exportFrame,
    })
    
    Create("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "💎 CrystalLev - Export Code",
        TextColor3 = Theme.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = exportFrame,
    })
    
    Create("TextButton", {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -30, 0, 5),
        BackgroundColor3 = Theme.Red,
        Text = "X",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        BorderSizePixel = 0,
        Parent = exportFrame,
    }).MouseButton1Click:Connect(function()
        exportFrame:Destroy()
    end)
    
    Draggable(exportFrame, exportFrame:FindFirstChildOfClass("Frame"))
    
    local codeBox = Create("TextBox", {
        Size = UDim2.new(1, -20, 1, -85),
        Position = UDim2.new(0, 10, 0, 45),
        BackgroundColor3 = Theme.BG3,
        Text = code,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        Font = Enum.Font.Code,
        TextSize = 10,
        TextEditable = false,
        MultiLine = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        BorderSizePixel = 0,
        Parent = exportFrame,
    })
    
    local copyBtn = Create("TextButton", {
        Size = UDim2.new(0, 140, 0, 30),
        Position = UDim2.new(0, 10, 1, -40),
        BackgroundColor3 = Theme.Accent,
        Text = "📋 Copy Code",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        BorderSizePixel = 0,
        Parent = exportFrame,
    })
    
    copyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(code)
        end
        Tween(copyBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(50, 200, 100)})
        copyBtn.Text = "✅ Copied!"
        wait(1)
        Tween(copyBtn, 0.15, {BackgroundColor3 = Theme.Accent})
        copyBtn.Text = "📋 Copy Code"
    end)
    
    local loadstringText = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/' .. Project.Name .. '.lua"))()'
    
    Create("TextBox", {
        Size = UDim2.new(1, -160, 0, 30),
        Position = UDim2.new(0, 150, 1, -40),
        BackgroundColor3 = Theme.BG3,
        Text = loadstringText,
        TextColor3 = Theme.Text2,
        Font = Enum.Font.Code,
        TextSize = 11,
        TextEditable = false,
        BorderSizePixel = 0,
        Parent = exportFrame,
    })
end)

-- ========================================
-- ЗАПУСК
-- ========================================
print("[CrystalLev] Platform loaded!")
print("[CrystalLev] GitHub: https://github.com/XyiBobra5242/crystalev")
