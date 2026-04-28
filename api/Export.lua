local platform = getgenv().CrystalLevPlatform
local Theme = platform.Theme

local project = platform.Project

local code = platform.GenerateCode(project)

local exportFrame = platform.Create("Frame", {
    Name = "Export",
    Size = UDim2.new(0, 550, 0, 400),
    Position = UDim2.new(0.5, -275, 0.5, -200),
    BackgroundColor3 = Theme.BG,
    BorderSizePixel = 0,
    Parent = platform.MainWindow,
    ZIndex = 80,
})

local titleBar = platform.Create("Frame", {
    Size = UDim2.new(1, 0, 0, 35),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = exportFrame,
})

platform.Create("TextLabel", {
    Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "💎 CrystalLev - Export Code",
    TextColor3 = Theme.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = titleBar,
})

platform.Create("TextButton", {
    Size = UDim2.new(0, 25, 0, 25),
    Position = UDim2.new(1, -30, 0, 5),
    BackgroundColor3 = Theme.Red,
    Text = "X",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = titleBar,
}).MouseButton1Click:Connect(function()
    exportFrame:Destroy()
end)

platform.SetDraggable(exportFrame, titleBar)

local codeBox = platform.Create("TextBox", {
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

local copyBtn = platform.Create("TextButton", {
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
    platform.Tween(copyBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(50, 200, 100)})
    platform.Tween(copyBtn, 0.15, {Text = "✅ Copied!"})
    wait(1)
    platform.Tween(copyBtn, 0.15, {BackgroundColor3 = Theme.Accent})
    platform.Tween(copyBtn, 0.15, {Text = "📋 Copy Code"})
end)

local loadstringCode = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/XyiBobra5242/crystalev/main/' .. project.Name .. '.lua"))()'

local loadstringBox = platform.Create("TextBox", {
    Size = UDim2.new(1, -170, 0, 30),
    Position = UDim2.new(0, 160, 1, -40),
    BackgroundColor3 = Theme.BG3,
    Text = loadstringCode,
    TextColor3 = Theme.Text2,
    Font = Enum.Font.Code,
    TextSize = 11,
    TextEditable = false,
    BorderSizePixel = 0,
    Parent = exportFrame,
})

local copyLoadBtn = platform.Create("TextButton", {
    Size = UDim2.new(0, 140, 0, 30),
    Position = UDim2.new(0, 160, 1, -40),
    Visible = false,
    BackgroundColor3 = Theme.Accent,
    Text = "Copy",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = exportFrame,
})
