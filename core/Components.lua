local platform = getgenv().CrystalLevPlatform
local Theme = platform.Theme

function platform.MakeButton(parent, text, callback)
    local btn = platform.Create("TextButton", {
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundColor3 = Theme.BG3,
        TextColor3 = Theme.Text,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        BorderSizePixel = 0,
        Parent = parent,
    })
    btn.MouseButton1Click:Connect(function()
        platform.Tween(btn, 0.1, {BackgroundColor3 = Theme.Accent})
        wait(0.1)
        platform.Tween(btn, 0.1, {BackgroundColor3 = Theme.BG3})
        if callback then callback() end
    end)
    btn.MouseEnter:Connect(function()
        platform.Tween(btn, 0.15, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)})
    end)
    btn.MouseLeave:Connect(function()
        platform.Tween(btn, 0.15, {BackgroundColor3 = Theme.BG3})
    end)
    return btn
end

function platform.MakeToggle(parent, text, default, callback)
    local toggled = default or false
    
    local frame = platform.Create("Frame", {
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundColor3 = Theme.BG3,
        BorderSizePixel = 0,
        Parent = parent,
    })
    
    platform.Create("TextLabel", {
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame,
    })
    
    local toggleBtn = platform.Create("Frame", {
        Size = UDim2.new(0, 35, 0, 18),
        Position = UDim2.new(1, -43, 0.5, -9),
        BackgroundColor3 = toggled and Theme.Accent or Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Parent = frame,
    })
    
    local dot = platform.Create("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, toggled and 19 or 2, 0.5, -7),
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0,
        Parent = toggleBtn,
    })
    
    toggleBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            toggled = not toggled
            platform.Tween(toggleBtn, 0.2, {BackgroundColor3 = toggled and Theme.Accent or Color3.fromRGB(60, 60, 60)})
            platform.Tween(dot, 0.2, {Position = UDim2.new(0, toggled and 19 or 2, 0.5, -7)})
            if callback then callback(toggled) end
        end
    end)
    
    return {Frame = frame, Set = function(v) 
        toggled = v
        toggleBtn.BackgroundColor3 = v and Theme.Accent or Color3.fromRGB(60, 60, 60)
        dot.Position = UDim2.new(0, v and 19 or 2, 0.5, -7)
    end}
end

function platform.MakeSlider(parent, text, min, max, default, callback)
    local value = default or min
    
    local frame = platform.Create("Frame", {
        Size = UDim2.new(1, -10, 0, 45),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundColor3 = Theme.BG3,
        BorderSizePixel = 0,
        Parent = parent,
    })
    
    platform.Create("TextLabel", {
        Size = UDim2.new(1, -16, 0, 18),
        Position = UDim2.new(0, 8, 0, 3),
        BackgroundTransparency = 1,
        Text = text .. ": " .. value,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = frame,
    })
    
    local sliderBar = platform.Create("Frame", {
        Size = UDim2.new(1, -16, 0, 4),
        Position = UDim2.new(0, 8, 0, 30),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Parent = frame,
    })
    
    local fill = platform.Create("Frame", {
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = sliderBar,
    })
    
    local dragging = false
    sliderBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    platform.Services.UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    platform.Services.UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local percent = math.clamp((i.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max - min) * percent)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            frame:FindFirstChildOfClass("TextLabel").Text = text .. ": " .. value
            if callback then callback(value) end
        end
    end)
end

function platform.MakeDropdown(parent, text, options, callback)
    local opened = false
    local selected = options[1] or ""
    
    local frame = platform.Create("Frame", {
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundColor3 = Theme.BG3,
        BorderSizePixel = 0,
        Parent = parent,
    })
    
    local btn = platform.Create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text .. ": " .. selected,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        BorderSizePixel = 0,
        Parent = frame,
    })
    
    local list = platform.Create("Frame", {
        Size = UDim2.new(1, 0, 0, #options * 22),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.BG2,
        BorderSizePixel = 0,
        Visible = false,
        Parent = frame,
    })
    
    for _, opt in pairs(options) do
        local optBtn = platform.Create("TextButton", {
            Size = UDim2.new(1, 0, 0, 22),
            BackgroundColor3 = Theme.BG2,
            Text = opt,
            TextColor3 = Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            BorderSizePixel = 0,
            Parent = list,
        })
        optBtn.MouseButton1Click:Connect(function()
            selected = opt
            btn.Text = text .. ": " .. selected
            list.Visible = false
            opened = false
            if callback then callback(selected) end
        end)
    end
    
    btn.MouseButton1Click:Connect(function()
        opened = not opened
        list.Visible = opened
        frame.Size = UDim2.new(1, -10, 0, opened and 30 + #options * 22 or 30)
    end)
end
