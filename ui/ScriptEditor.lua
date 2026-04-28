local platform = getgenv().CrystalLevPlatform
local Theme = platform.Theme

local editorFrame = platform.Create("Frame", {
    Name = "ScriptEditor",
    Size = UDim2.new(0, 400, 0, 300),
    Position = UDim2.new(0.5, -200, 0.5, -150),
    BackgroundColor3 = Theme.BG,
    BorderSizePixel = 0,
    Parent = platform.MainWindow,
    Visible = false,
    ZIndex = 60,
})

local titleBar = platform.Create("Frame", {
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Theme.BG2,
    BorderSizePixel = 0,
    Parent = editorFrame,
})

platform.Create("TextLabel", {
    Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "Script Editor",
    TextColor3 = Theme.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = titleBar,
})

platform.Create("TextButton", {
    Size = UDim2.new(0, 25, 0, 25),
    Position = UDim2.new(1, -30, 0, 2),
    BackgroundColor3 = Theme.Red,
    Text = "X",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = titleBar,
}).MouseButton1Click:Connect(function()
    editorFrame.Visible = false
end)

local editingElement = nil

local scriptBox = platform.Create("TextBox", {
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
    Parent = editorFrame,
})

local saveBtn = platform.Create("TextButton", {
    Size = UDim2.new(0, 100, 0, 25),
    Position = UDim2.new(0, 10, 1, -32),
    BackgroundColor3 = Theme.Accent,
    Text = "Save",
    TextColor3 = Color3.fromRGB(0, 0, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0,
    Parent = editorFrame,
})

saveBtn.MouseButton1Click:Connect(function()
    if editingElement then
        editingElement.Script = scriptBox.Text
        platform.Tween(saveBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(50, 200, 100)})
        wait(0.3)
        platform.Tween(saveBtn, 0.15, {BackgroundColor3 = Theme.Accent})
    end
end)

scriptBox:GetPropertyChangedSignal("Text"):Connect(function()
    if editingElement then
        editingElement.Script = scriptBox.Text
    end
end)

platform.SetDraggable(editorFrame, titleBar)

function platform.OpenScriptEditor(element)
    editingElement = element
    scriptBox.Text = element.Script or ""
    editorFrame.Visible = true
    editorFrame.ZIndex = 70
end
