local platform = getgenv().CrystalLevPlatform
local Theme = platform.Theme
local GUI = platform.GetContainer()

local MainFrame = platform.Create("ScreenGui", {
    Name = "CrystalLev_Platform",
    Parent = GUI,
})

local Window = platform.Create("Frame", {
    Name = "Window",
    Size = UDim2.new(0, 700, 0, 480),
    Position = UDim2.new(0.5, -350, 0.5, -240),
    BackgroundColor3 = Theme.BG,
    BorderSizePixel = 0,
    Parent = MainFrame,
})

platform.Tween(Window, 0.4, {Size = UDim2.new(0, 700, 0, 480)})

local TitleBar = platform.Create("Frame", {
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Window,
})

platform.Create("TextLabel", {
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

platform.SetDraggable(Window, TitleBar)

-- Project Info Panel
local InfoPanel = platform.Create("Frame", {
    Size = UDim2.new(1, -20, 0, 50),
    Position = UDim2.new(0, 10, 0, 45),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Window,
})

platform.Create("TextLabel", {
    Size = UDim2.new(0, 40, 0, 20),
    Position = UDim2.new(0, 8, 0, 5),
    BackgroundTransparency = 1,
    Text = "Name:",
    TextColor3 = Theme.Text2,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = InfoPanel,
})

local NameInput = platform.Create("TextBox", {
    Size = UDim2.new(0, 140, 0, 22),
    Position = UDim2.new(0, 50, 0, 4),
    BackgroundColor3 = Theme.BG3,
    TextColor3 = Theme.Text,
    PlaceholderColor3 = Theme.Text2,
    PlaceholderText = "HubName",
    Font = Enum.Font.Gotham,
    TextSize = 11,
    BorderSizePixel = 0,
    Parent = InfoPanel,
})

platform.Create("TextLabel", {
    Size = UDim2.new(0, 45, 0, 20),
    Position = UDim2.new(0, 200, 0, 5),
    BackgroundTransparency = 1,
    Text = "Author:",
    TextColor3 = Theme.Text2,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = InfoPanel,
})

local AuthorInput = platform.Create("TextBox", {
    Size = UDim2.new(0, 140, 0, 22),
    Position = UDim2.new(0, 247, 0, 4),
    BackgroundColor3 = Theme.BG3,
    TextColor3 = Theme.Text,
    PlaceholderColor3 = Theme.Text2,
    PlaceholderText = "Author",
    Font = Enum.Font.Gotham,
    TextSize = 11,
    BorderSizePixel = 0,
    Parent = InfoPanel,
})

local project = platform.Project or { Name = "MyHub", Author = "User", Tabs = {} }

NameInput.FocusLost:Connect(function() project.Name = NameInput.Text end)
AuthorInput.FocusLost:Connect(function() project.Author = AuthorInput.Text end)

-- Tab Editor
local TabEditor = platform.Create("Frame", {
    Size = UDim2.new(0.38, 0, 1, -150),
    Position = UDim2.new(0, 10, 0, 105),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Window,
})

platform.Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = Theme.BG3,
    Text = "Tabs",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    Parent = TabEditor,
})

local TabList = platform.Create("ScrollingFrame", {
    Size = UDim2.new(1, -10, 1, -60),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundColor3 = Theme.BG2,
    ScrollBarThickness = 3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = TabEditor,
})

platform.Create("UIListLayout", {
    Padding = UDim.new(0, 3),
    Parent = TabList,
})

local AddTabBtn = platform.Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 5, 1, -32),
    BackgroundColor3 = Theme.Accent,
    Text = "+ Add Tab",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = TabEditor,
})

-- Element Editor
local ElementEditor = platform.Create("Frame", {
    Size = UDim2.new(0.58, 0, 1, -150),
    Position = UDim2.new(0.42, 0, 0, 105),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = Window,
})

platform.Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = Theme.BG3,
    Text = "Elements",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    Parent = ElementEditor,
})

local ElementList = platform.Create("ScrollingFrame", {
    Size = UDim2.new(1, -10, 1, -60),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundColor3 = Theme.BG2,
    ScrollBarThickness = 3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = ElementEditor,
})

platform.Create("UIListLayout", {
    Padding = UDim.new(0, 3),
    Parent = ElementList,
})

local AddElementBtn = platform.Create("TextButton", {
    Size = UDim2.new(1, -10, 0, 25),
    Position = UDim2.new(0, 5, 1, -32),
    BackgroundColor3 = Theme.Blue,
    Text = "+ Add Element",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = ElementEditor,
})

-- Bottom Buttons
local ExportBtn = platform.Create("TextButton", {
    Size = UDim2.new(0, 180, 0, 30),
    Position = UDim2.new(1, -190, 1, -38),
    BackgroundColor3 = Theme.Accent,
    Text = "📤 Export to GitHub",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    BorderSizePixel = 0,
    Parent = Window,
})

-- Сохраняем ссылки
platform.MainWindow = Window
platform.TabList = TabList
platform.ElementList = ElementList
platform.Project = project

-- Инициализация редактора табов
require("ui/TabEditor.lua")
require("ui/ScriptEditor.lua")

-- Экспорт
ExportBtn.MouseButton1Click:Connect(function()
    require("api/Export.lua")
end)
