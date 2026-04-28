local platform = getgenv().CrystalLevPlatform
local Theme = platform.Theme

local project = platform.Project
local TabList = platform.TabList
local ElementList = platform.ElementList

local selectedTab = nil

function platform.RefreshTabs()
    for _, v in pairs(TabList:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    
    for _, tab in pairs(project.Tabs) do
        local f = platform.Create("Frame", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundColor3 = Theme.BG3,
            BorderSizePixel = 0,
            Parent = TabList,
        })
        
        platform.Create("TextButton", {
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
        }).MouseButton1Click:Connect(function()
            selectedTab = tab
            platform.RefreshElements()
        end)
        
        platform.Create("TextButton", {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -25, 0, 4),
            BackgroundColor3 = Theme.Red,
            Text = "X",
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            BorderSizePixel = 0,
            Parent = f,
        }).MouseButton1Click:Connect(function()
            for i, t in pairs(project.Tabs) do
                if t == tab then table.remove(project.Tabs, i); break end
            end
            platform.RefreshTabs()
        end)
    end
    
    TabList.CanvasSize = UDim2.new(0, 0, 0, #project.Tabs * 32)
end

platform.AddTabBtn.MouseButton1Click:Connect(function()
    local name = "Tab " .. (#project.Tabs + 1)
    table.insert(project.Tabs, { Name = name, Elements = {} })
    platform.RefreshTabs()
end)

function platform.RefreshElements()
    for _, v in pairs(ElementList:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    
    if not selectedTab then return end
    
    for _, el in pairs(selectedTab.Elements) do
        local f = platform.Create("Frame", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundColor3 = Theme.BG3,
            BorderSizePixel = 0,
            Parent = ElementList,
        })
        
        local typeColor = el.Type == "Button" and Theme.Blue or el.Type == "Toggle" and Theme.Orange or Theme.Accent
        
        platform.Create("Frame", {
            Size = UDim2.new(0, 3, 1, 0),
            BackgroundColor3 = typeColor,
            BorderSizePixel = 0,
            Parent = f,
        })
        
        platform.Create("TextButton", {
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
        }).MouseButton1Click:Connect(function()
            platform.OpenScriptEditor(el)
        end)
        
        platform.Create("TextButton", {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -25, 0, 4),
            BackgroundColor3 = Theme.Red,
            Text = "X",
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            BorderSizePixel = 0,
            Parent = f,
        }).MouseButton1Click:Connect(function()
            for i, e in pairs(selectedTab.Elements) do
                if e == el then table.remove(selectedTab.Elements, i); break end
            end
            platform.RefreshElements()
        end)
    end
    
    ElementList.CanvasSize = UDim2.new(0, 0, 0, #selectedTab.Elements * 32)
end

platform.AddElementBtn.MouseButton1Click:Connect(function()
    if not selectedTab then return end
    
    -- Простое меню выбора типа
    local menu = platform.Create("Frame", {
        Size = UDim2.new(0, 150, 0, 120),
        Position = UDim2.new(0.5, -75, 0.5, -60),
        BackgroundColor3 = Theme.BG2,
        BorderSizePixel = 0,
        Parent = platform.MainWindow,
        ZIndex = 50,
    })
    
    local types = {"Button", "Toggle", "Slider", "Dropdown"}
    for i, t in pairs(types) do
        platform.Create("TextButton", {
            Size = UDim2.new(1, -10, 0, 23),
            Position = UDim2.new(0, 5, 0, 5 + (i-1) * 26),
            BackgroundColor3 = Theme.BG3,
            Text = t,
            TextColor3 = Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            BorderSizePixel = 0,
            Parent = menu,
            ZIndex = 51,
        }).MouseButton1Click:Connect(function()
            local el = { Name = "New" .. t, Type = t, Script = "" }
            if t == "Slider" then el.Min = 1; el.Max = 100 end
            table.insert(selectedTab.Elements, el)
            menu:Destroy()
            platform.RefreshElements()
        end)
    end
end)
