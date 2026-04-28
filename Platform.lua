-- 💎 CrystalLev Platform v2.0
-- Единый файл | Мягкий UI | Анимации

if getgenv().CrystalLevPlatform then return end
getgenv().CrystalLevPlatform = { Version = "2.0.0" }

local Services = {
    Tween = game:GetService("TweenService"),
    Input = game:GetService("UserInputService"),
    CoreGui = game:GetService("CoreGui"),
    Players = game:GetService("Players"),
}

local Player = Services.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Контейнер
local GUI = nil
pcall(function() if gethui then GUI = gethui() end end)
if not GUI then
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(PlayerGui); GUI = PlayerGui end end)
end
if not GUI then GUI = Services.CoreGui end

for _, v in pairs(GUI:GetChildren()) do
    if v.Name == "CrystalLevPlatform" then v:Destroy() end
end

-- Утилиты
local function Create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k == "Children" then for _, c in pairs(v) do c.Parent = obj end
        elseif k == "Parent" then obj.Parent = v
        else pcall(function() obj[k] = v end) end
    end
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(obj) end end)
    return obj
end

local function Tween(obj, time, props, easing)
    easing = easing or Enum.EasingStyle.Quart
    local t = Services.Tween:Create(obj, TweenInfo.new(time, easing, Enum.EasingDirection.Out), props)
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
    Services.Input.InputChanged:Connect(function(i)
        if d and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - sm
            frame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
        end
    end)
    Services.Input.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end
    end)
end

local function Round(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = instance
end

-- Цвета
local C = {
    Accent = Color3.fromRGB(130, 100, 255),
    Accent2 = Color3.fromRGB(100, 70, 230),
    BG = Color3.fromRGB(15, 15, 20),
    BG2 = Color3.fromRGB(22, 22, 30),
    BG3 = Color3.fromRGB(30, 30, 40),
    Card = Color3.fromRGB(25, 25, 35),
    Text = Color3.fromRGB(240, 240, 250),
    Text2 = Color3.fromRGB(150, 150, 170),
    Red = Color3.fromRGB(255, 75, 85),
    Green = Color3.fromRGB(80, 220, 120),
    Blue = Color3.fromRGB(90, 140, 255),
    Orange = Color3.fromRGB(255, 160, 50),
    Yellow = Color3.fromRGB(255, 210, 70),
}

-- Данные
local Project = { Name = "MyHub", Author = "User", Tabs = {} }
local SelectedTab = nil
local EditingElement = nil

-- Экран
local ScreenGui = Create("ScreenGui", { Name = "CrystalLevPlatform", Parent = GUI })
local Overlay = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.5,
    Parent = ScreenGui,
    ZIndex = 1,
})
Tween(Overlay, 0.3, {BackgroundTransparency = 0.4})

-- Главное окно
local Main = Create("Frame", {
    Size = UDim2.new(0, 680, 0, 440),
    Position = UDim2.new(0.5, -340, 0.5, -220),
    BackgroundColor3 = C.BG,
    Parent = ScreenGui,
    ZIndex = 2,
})
Round(Main, 12)

-- Анимация
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Tween(Main, 0.4, {Size = UDim2.new(0, 680, 0, 440)}, Enum.EasingStyle.Back)
Tween(Main, 0.4, {Position = UDim2.new(0.5, -340, 0.5, -220)}, Enum.EasingStyle.Back)

-- Заголовок
local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = C.BG2,
    Parent = Main,
})
Round(Header, 12)

local HeaderGradient = Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.Accent),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 130, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 180, 255)),
    }),
    Rotation = 90,
    Parent = Header,
})

Create("TextLabel", {
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 15, 0, 0),
    BackgroundTransparency = 1,
    Text = "💎 CrystalLev Platform",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header,
})

Draggable(Main, Header)

-- Инфо панель
local Info = Create("Frame", {
    Size = UDim2.new(1, -24, 0, 45),
    Position = UDim2.new(0, 12, 0, 60),
    BackgroundColor3 = C.Card,
    Parent = Main,
})
Round(Info, 8)

Create("TextLabel", {
    Size = UDim2.new(0, 45, 0, 18),
    Position = UDim2.new(0, 12, 0, 6),
    BackgroundTransparency = 1,
    Text = "Name",
    TextColor3 = C.Text2,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Info,
})

local NameBox = Create("TextBox", {
    Size = UDim2.new(0, 130, 0, 26),
    Position = UDim2.new(0, 60, 0, 10),
    BackgroundColor3 = C.BG3,
    Text = "MyHub",
    TextColor3 = C.Text,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = Info,
})
Round(NameBox, 4)

Create("TextLabel", {
    Size = UDim2.new(0, 45, 0, 18),
    Position = UDim2.new(0, 210, 0, 6),
    BackgroundTransparency = 1,
    Text = "Author",
    TextColor3 = C.Text2,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Info,
})

local AuthorBox = Create("TextBox", {
    Size = UDim2.new(0, 130, 0, 26),
    Position = UDim2.new(0, 260, 0, 10),
    BackgroundColor3 = C.BG3,
    Text = "User",
    TextColor3 = C.Text,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = Info,
})
Round(AuthorBox, 4)

NameBox.FocusLost:Connect(function() Project.Name = NameBox.Text end)
AuthorBox.FocusLost:Connect(function() Project.Author = AuthorBox.Text end)

-- Левая панель (Табы)
local LeftPanel = Create("Frame", {
    Size = UDim2.new(0, 230, 1, -130),
    Position = UDim2.new(0, 12, 0, 115),
    BackgroundColor3 = C.Card,
    Parent = Main,
})
Round(LeftPanel, 8)

Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 30),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "📁 Tabs",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = LeftPanel,
})

local TabCount = Create("TextLabel", {
    Size = UDim2.new(0, 30, 0, 20),
    Position = UDim2.new(1, -40, 0, 12),
    BackgroundColor3 = C.Accent,
    Text = "0",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    Parent = LeftPanel,
})
Round(TabCount, 10)

local TabList = Create("ScrollingFrame", {
    Size = UDim2.new(1, -16, 1, -85),
    Position = UDim2.new(0, 8, 0, 42),
    BackgroundColor3 = C.Card,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = LeftPanel,
})

local TabLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 6),
    Parent = TabList,
})

local AddTabBtn = Create("TextButton", {
    Size = UDim2.new(1, -16, 0, 32),
    Position = UDim2.new(0, 8, 1, -40),
    BackgroundColor3 = C.Accent,
    Text = "+ New Tab",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    Parent = LeftPanel,
})
Round(AddTabBtn, 6)

-- Правая панель (Элементы)
local RightPanel = Create("Frame", {
    Size = UDim2.new(1, -260, 1, -130),
    Position = UDim2.new(0, 248, 0, 115),
    BackgroundColor3 = C.Card,
    Parent = Main,
})
Round(RightPanel, 8)

Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 30),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "📦 Elements",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = RightPanel,
})

local ElementCount = Create("TextLabel", {
    Size = UDim2.new(0, 30, 0, 20),
    Position = UDim2.new(1, -40, 0, 12),
    BackgroundColor3 = C.Blue,
    Text = "0",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    Parent = RightPanel,
})
Round(ElementCount, 10)

local ElementList = Create("ScrollingFrame", {
    Size = UDim2.new(1, -16, 1, -85),
    Position = UDim2.new(0, 8, 0, 42),
    BackgroundColor3 = C.Card,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Blue,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = RightPanel,
})

local ElementLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 6),
    Parent = ElementList,
})

local AddElementBtn = Create("TextButton", {
    Size = UDim2.new(1, -16, 0, 32),
    Position = UDim2.new(0, 8, 1, -40),
    BackgroundColor3 = C.Blue,
    Text = "+ New Element",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    Parent = RightPanel,
})
Round(AddElementBtn, 6)

-- Кнопка Export
local ExportBtn = Create("TextButton", {
    Size = UDim2.new(0, 160, 0, 34),
    Position = UDim2.new(1, -172, 1, -44),
    BackgroundColor3 = C.Green,
    Text = "📤 Export",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    Parent = Main,
})
Round(ExportBtn, 8)

-- ========================================
-- ЛОГИКА
-- ========================================

function RefreshTabs()
    for _, v in pairs(TabList:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end

    for i, tab in pairs(Project.Tabs) do
        local item = Create("Frame", {
            Size = UDim2.new(1, -4, 0, 34),
            BackgroundColor3 = SelectedTab == tab and Color3.fromRGB(45, 40, 55) or C.BG3,
            Parent = TabList,
        })
        Round(item, 6)

        local btn = Create("TextButton", {
            Size = UDim2.new(1, -36, 1, 0),
            Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1,
            Text = tab.Name,
            TextColor3 = C.Text,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = item,
        })

        btn.MouseButton1Click:Connect(function()
            SelectedTab = tab
            RefreshTabs()
            RefreshElements()
        end)

        local del = Create("TextButton", {
            Size = UDim2.new(0, 22, 0, 22),
            Position = UDim2.new(1, -28, 0, 6),
            BackgroundColor3 = C.Red,
            Text = "×",
            TextColor3 = C.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            Parent = item,
        })
        Round(del, 4)

        del.MouseButton1Click:Connect(function()
            table.remove(Project.Tabs, i)
            if SelectedTab == tab then SelectedTab = nil end
            RefreshTabs()
            RefreshElements()
        end)
    end

    TabCount.Text = #Project.Tabs
    TabList.CanvasSize = UDim2.new(0, 0, 0, #Project.Tabs * 42)
end

function RefreshElements()
    for _, v in pairs(ElementList:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end

    if not SelectedTab then
        ElementCount.Text = "0"
        return
    end

    for i, el in pairs(SelectedTab.Elements) do
        local color = el.Type == "Button" and C.Blue or el.Type == "Toggle" and C.Orange or el.Type == "Slider" and C.Accent or C.Yellow

        local item = Create("Frame", {
            Size = UDim2.new(1, -4, 0, 34),
            BackgroundColor3 = C.BG3,
            Parent = ElementList,
        })
        Round(item, 6)

        Create("Frame", {
            Size = UDim2.new(0, 3, 1, 0),
            BackgroundColor3 = color,
            Parent = item,
        })
        Round(item:FindFirstChild("Frame") or item, 3)

        local btn = Create("TextButton", {
            Size = UDim2.new(1, -36, 1, 0),
            Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1,
            Text = "[" .. el.Type .. "] " .. el.Name,
            TextColor3 = C.Text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = item,
        })

        btn.MouseButton1Click:Connect(function()
            EditingElement = el
            OpenEditor(el)
        end)

        local del = Create("TextButton", {
            Size = UDim2.new(0, 22, 0, 22),
            Position = UDim2.new(1, -28, 0, 6),
            BackgroundColor3 = C.Red,
            Text = "×",
            TextColor3 = C.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            Parent = item,
        })
        Round(del, 4)

        del.MouseButton1Click:Connect(function()
            table.remove(SelectedTab.Elements, i)
            RefreshElements()
        end)
    end

    ElementCount.Text = #SelectedTab.Elements
    ElementList.CanvasSize = UDim2.new(0, 0, 0, #SelectedTab.Elements * 42)
end

-- Добавление таба
AddTabBtn.MouseButton1Click:Connect(function()
    table.insert(Project.Tabs, { Name = "Tab " .. (#Project.Tabs + 1), Elements = {} })
    RefreshTabs()
    Tween(AddTabBtn, 0.1, {BackgroundColor3 = Color3.fromRGB(160, 130, 255)})
    wait(0.1)
    Tween(AddTabBtn, 0.1, {BackgroundColor3 = C.Accent})
end)

-- Добавление элемента
AddElementBtn.MouseButton1Click:Connect(function()
    if not SelectedTab then
        -- Уведомление
        local notif = Create("Frame", {
            Size = UDim2.new(0, 200, 0, 30),
            Position = UDim2.new(0.5, -100, 0.5, -15),
            BackgroundColor3 = C.Red,
            Parent = ScreenGui,
            ZIndex = 10,
        })
        Round(notif, 6)
        Create("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "Select a tab first!",
            TextColor3 = C.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            Parent = notif,
        })
        Tween(notif, 0.3, {Position = UDim2.new(0.5, -100, 0.5, -50)})
        wait(1.5)
        Tween(notif, 0.3, {Position = UDim2.new(0.5, -100, 0.5, -15), BackgroundTransparency = 1})
        wait(0.3)
        notif:Destroy()
        return
    end

    -- Меню выбора типа
    local menu = Create("Frame", {
        Size = UDim2.new(0, 160, 0, 160),
        Position = UDim2.new(0.5, -80, 0.5, -80),
        BackgroundColor3 = C.BG2,
        Parent = ScreenGui,
        ZIndex = 10,
    })
    Round(menu, 10)

    Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = C.BG3,
        Text = "Element Type",
        TextColor3 = C.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        Parent = menu,
    })

    local types = {
        { Name = "Button", Color = C.Blue },
        { Name = "Toggle", Color = C.Orange },
        { Name = "Slider", Color = C.Accent },
        { Name = "Dropdown", Color = C.Yellow },
    }

    for i, t in pairs(types) do
        local btn = Create("TextButton", {
            Size = UDim2.new(1, -20, 0, 26),
            Position = UDim2.new(0, 10, 0, 34 + (i-1) * 30),
            BackgroundColor3 = t.Color,
            Text = t.Name,
            TextColor3 = C.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            Parent = menu,
            ZIndex = 11,
        })
        Round(btn, 5)

        btn.MouseButton1Click:Connect(function()
            local el = { Name = "New" .. t.Name, Type = t.Name, Script = "" }
            if t.Name == "Slider" then el.Min = 1; el.Max = 100 end
            table.insert(SelectedTab.Elements, el)
            menu:Destroy()
            RefreshElements()
        end)
    end
end)

-- Редактор скриптов
local Editor = Create("Frame", {
    Size = UDim2.new(0, 420, 0, 320),
    Position = UDim2.new(0.5, -210, 0.5, -160),
    BackgroundColor3 = C.BG,
    Parent = ScreenGui,
    Visible = false,
    ZIndex = 20,
})
Round(Editor, 12)

local EditorHeader = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = C.BG2,
    Parent = Editor,
})
Round(EditorHeader, 12)

Create("TextLabel", {
    Size = UDim2.new(1, -50, 1, 0),
    Position = UDim2.new(0, 15, 0, 0),
    BackgroundTransparency = 1,
    Text = "✏️ Script Editor",
    TextColor3 = C.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = EditorHeader,
})

local EditorClose = Create("TextButton", {
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -34, 0, 5),
    BackgroundColor3 = C.Red,
    Text = "×",
    TextColor3 = C.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    Parent = Editor,
})
Round(EditorClose, 6)
EditorClose.MouseButton1Click:Connect(function() Editor.Visible = false end)

Draggable(Editor, EditorHeader)

local ScriptBox = Create("TextBox", {
    Size = UDim2.new(1, -24, 1, -90),
    Position = UDim2.new(0, 12, 0, 48),
    BackgroundColor3 = C.BG3,
    TextColor3 = C.Text,
    PlaceholderText = "Write Lua code here...",
    PlaceholderColor3 = C.Text2,
    Font = Enum.Font.Code,
    TextSize = 13,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    BorderSizePixel = 0,
    Parent = Editor,
})
Round(ScriptBox, 6)

local SaveBtn = Create("TextButton", {
    Size = UDim2.new(0, 100, 0, 30),
    Position = UDim2.new(0, 12, 1, -42),
    BackgroundColor3 = C.Green,
    Text = "💾 Save",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    Parent = Editor,
})
Round(SaveBtn, 6)
SaveBtn.MouseButton1Click:Connect(function()
    if EditingElement then
        EditingElement.Script = ScriptBox.Text
    end
    Editor.Visible = false
end)

function OpenEditor(element)
    EditingElement = element
    ScriptBox.Text = element.Script or ""
    Editor.Visible = true
end

-- ========================================
-- ЭКСПОРТ
-- ========================================
ExportBtn.MouseButton1Click:Connect(function()
    local code = GenerateCode()

    local ExportFrame = Create("Frame", {
        Size = UDim2.new(0, 500, 0, 380),
        Position = UDim2.new(0.5, -250, 0.5, -190),
        BackgroundColor3 = C.BG,
        Parent = ScreenGui,
        ZIndex = 30,
    })
    Round(ExportFrame, 12)

    local ExportHeader = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = C.BG2,
        Parent = ExportFrame,
    })
    Round(ExportHeader, 12)

    Create("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = "✅ Generated by CrystalLev",
        TextColor3 = C.Green,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ExportHeader,
    })

    Create("TextButton", {
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -34, 0, 6),
        BackgroundColor3 = C.Red,
        Text = "×",
        TextColor3 = C.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Parent = ExportFrame,
    }).MouseButton1Click:Connect(function() ExportFrame:Destroy() end)

    Draggable(ExportFrame, ExportHeader)

    local CodeBox = Create("TextBox", {
        Size = UDim2.new(1, -24, 1, -100),
        Position = UDim2.new(0, 12, 0, 50),
        BackgroundColor3 = C.BG3,
        Text = code,
        TextColor3 = C.Text,
        Font = Enum.Font.Code,
        TextSize = 11,
        TextEditable = false,
        MultiLine = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        BorderSizePixel = 0,
        Parent = ExportFrame,
    })
    Round(CodeBox, 6)

    local CopyBtn = Create("TextButton", {
        Size = UDim2.new(0, 140, 0, 32),
        Position = UDim2.new(0, 12, 1, -44),
        BackgroundColor3 = C.Accent,
        Text = "📋 Copy Code",
        TextColor3 = C.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        Parent = ExportFrame,
    })
    Round(CopyBtn, 6)

    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(code) end
        Tween(CopyBtn, 0.15, {BackgroundColor3 = C.Green})
        CopyBtn.Text = "✅ Copied!"
        wait(1.5)
        Tween(CopyBtn, 0.15, {BackgroundColor3 = C.Accent})
        CopyBtn.Text = "📋 Copy Code"
    end)
end)

-- ========================================
-- ГЕНЕРАТОР КОДА
-- ========================================
function GenerateCode()
    local code = [[
-- 💎 Generated by CrystalLev Platform
-- Hub: ]] .. Project.Name .. [[
-- Author: ]] .. Project.Author .. [[

if getgenv().]] .. Project.Name .. [[ then return end
getgenv().]] .. Project.Name .. [[ = true

local T = game:GetService("TweenService")
local U = game:GetService("UserInputService")
local P = game:GetService("Players").LocalPlayer
local PG = P:WaitForChild("PlayerGui")
local CG = game:GetService("CoreGui")

local function GC()
    local s,r = pcall(function()
        if gethui then return gethui() end
        if syn and syn.protect_gui then syn.protect_gui(PG); return PG end
        return CG
    end)
    return (s and r) and r or CG
end

local GUI = GC()
for _,v in pairs(GUI:GetChildren()) do
    if v.Name == "]] .. Project.Name .. [[_Hub" then v:Destroy() end
end

local function R(o) pcall(function() if syn and syn.protect_gui then syn.protect_gui(o) end end) end

local function C(c,p)
    local o = Instance.new(c)
    for k,v in pairs(p or {}) do
        if k=="Children" then for _,ch in pairs(v) do ch.Parent=o end
        elseif k=="Parent" then o.Parent=v
        else pcall(function() o[k]=v end) end
    end
    R(o)
    return o
end

local function Tw(o,t,p) local tw=T:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),p)tw:Play()return tw end

local function Rd(o,r)
    local cn = Instance.new("UICorner")
    cn.CornerRadius = UDim.new(0,r or 6)
    cn.Parent = o
end

local function Dr(f,d)
    d=d or f
    local a,b,c
    d.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then a=true;b=f.Position;c=i.Position end end)
    U.InputChanged:Connect(function(i)if a and i.UserInputType==Enum.UserInputType.MouseMovement then local dt=i.Position-c;f.Position=UDim2.new(b.X.Scale,b.X.Offset+dt.X,b.Y.Scale,b.Y.Offset+dt.Y)end end)
    U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then a=false end end)
end

local A = Color3.fromRGB(130,100,255)
local B = Color3.fromRGB(15,15,20)
local B2 = Color3.fromRGB(22,22,30)
local B3 = Color3.fromRGB(30,30,40)
local W = Color3.fromRGB(240,240,250)
local G = Color3.fromRGB(150,150,170)

local SG = C("ScreenGui",{Name="]]..Project.Name..[[_Hub",Parent=GUI})
local M = C("Frame",{Size=UDim2.new(0,550,0,380),Position=UDim2.new(0.5,-275,0.5,-190),BackgroundColor3=B,Parent=SG})
Rd(M,12)

local H = C("Frame",{Size=UDim2.new(1,0,0,45),BackgroundColor3=B2,Parent=M})
Rd(H,12)
C("TextLabel",{Size=UDim2.new(1,-70,1,0),Position=UDim2.new(0,15,0,0),BackgroundTransparency=1,Text="💎 ]]..Project.Name..[[",TextColor3=A,Font=Enum.Font.GothamBold,TextSize=14,TextXAlignment=Enum.TextXAlignment.Left,Parent=H})
C("TextLabel",{Size=UDim2.new(0,65,1,0),Position=UDim2.new(1,-70,0,0),BackgroundTransparency=1,Text="CrystalLev",TextColor3=Color3.fromRGB(80,80,80),Font=Enum.Font.Gotham,TextSize=9,TextXAlignment=Enum.TextXAlignment.Right,Parent=H})
Dr(M,H)

local TB = C("Frame",{Size=UDim2.new(0,125,1,-45),Position=UDim2.new(0,0,0,45),BackgroundColor3=B2,Parent=M})
C("UIListLayout",{Padding=UDim.new(0,4),Parent=TB})

local CT = C("Frame",{Size=UDim2.new(1,-130,1,-50),Position=UDim2.new(0,130,0,45),BackgroundColor3=B,Parent=M})
C("UIListLayout",{Padding=UDim.new(0,5),Parent=CT})

local OpenedTab = nil
]]

    for _, tab in pairs(Project.Tabs) do
        local tName = tab.Name:gsub("[^%w]", "_")
        code = code .. [[

-- Tab: ]] .. tab.Name .. [[
local TB_]] .. tName .. [[ = C("TextButton",{
    Size=UDim2.new(1,-16,0,32),Position=UDim2.new(0,8,0,0),
    BackgroundColor3=B3,Text="]]..tab.Name..[[",TextColor3=W,Font=Enum.Font.Gotham,TextSize=11,BorderSizePixel=0,Parent=TB,
})
Rd(TB_]]..tName..[[,5)

local CT_]]..tName..[[ = C("Frame",{
    Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,Parent=CT,
})
]]
        for _, el in pairs(tab.Elements) do
            local eName = el.Name:gsub("[^%w]", "_")
            if el.Type == "Button" then
                code = code .. [[
C("TextButton",{
    Size=UDim2.new(1,-16,0,30),Position=UDim2.new(0,8,0,0),
    BackgroundColor3=B3,Text="]]..el.Name..[[",TextColor3=W,Font=Enum.Font.Gotham,TextSize=11,BorderSizePixel=0,Parent=CT_]]..tName..[[,
}).MouseButton1Click:Connect(function()
    ]]..(el.Script or "")..[[
end)
]]
            elseif el.Type == "Toggle" then
                code = code .. [[
local T_]]..eName..[[_State = false
local T_]]..eName..[[ = C("Frame",{
    Size=UDim2.new(1,-16,0,30),Position=UDim2.new(0,8,0,0),BackgroundColor3=B3,Parent=CT_]]..tName..[[,
})
C("TextLabel",{
    Size=UDim2.new(0,180,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,
    Text="]]..el.Name..[[",TextColor3=W,Font=Enum.Font.Gotham,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,
    Parent=T_]]..eName..[[,
})
local T_]]..eName..[[_Btn = C("Frame",{
    Size=UDim2.new(0,36,0,18),Position=UDim2.new(1,-44,0.5,-9),BackgroundColor3=Color3.fromRGB(60,60,70),Parent=T_]]..eName..[[,
})
Rd(T_]]..eName..[[_Btn,9)
local T_]]..eName..[[_Dot = C("Frame",{
    Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,2,0.5,-7),BackgroundColor3=W,Parent=T_]]..eName..[[_Btn,
})
Rd(T_]]..eName..[[_Dot,7)
T_]]..eName..[[_Btn.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then
        T_]]..eName..[[_State = not T_]]..eName..[[_State
        Tw(T_]]..eName..[[_Btn,0.2,{BackgroundColor3=T_]]..eName..[[_State and A or Color3.fromRGB(60,60,70)})
        Tw(T_]]..eName..[[_Dot,0.2,{Position=UDim2.new(0,T_]]..eName..[[_State and 20 or 2,0.5,-7)})
        ]]..(el.Script or "")..[[
    end
end)
]]
            end
        end
        code = code .. [[
TB_]]..tName..[[.MouseButton1Click:Connect(function()
    if OpenedTab then OpenedTab.Visible=false end
    CT_]]..tName..[[.Visible=true
    OpenedTab=CT_]]..tName..[[
end)
]]
    end
    if #Project.Tabs > 0 then
        local fn = Project.Tabs[1].Name:gsub("[^%w]", "_")
        code = code .. [[
CT_]]..fn..[[.Visible=true
OpenedTab=CT_]]..fn..[[
]]
    end
    return code
end

-- Инициализация
RefreshTabs()

print("[CrystalLev] Platform loaded!")
print("[CrystalLev] GitHub: https://github.com/XyiBobra5242/crystalev")
