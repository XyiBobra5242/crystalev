local platform = getgenv().CrystalLevPlatform

function platform.Create(class, props)
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
    platform.Protect(obj)
    return obj
end

function platform.Tween(obj, time, props)
    local t = platform.Services.TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

function platform.SetDraggable(frame, dragObj)
    dragObj = dragObj or frame
    local drag, startPos, startMouse
    dragObj.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true; startPos = frame.Position; startMouse = i.Position
        end
    end)
    platform.Services.UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - startMouse
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    platform.Services.UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
end
