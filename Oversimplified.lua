-- [[ Oversimplified UI Library v1.0 ]] --
local Oversimplified = {}

Oversimplified.Theme = {
    Bg = Color3.fromRGB(24, 24, 27),        
    Border = Color3.fromRGB(39, 39, 42),    
    Text = Color3.fromRGB(228, 228, 231),   
    Active = Color3.fromRGB(99, 102, 241),  
    Inactive = Color3.fromRGB(63, 63, 70),  
    Good = Color3.fromRGB(74, 222, 128),    
    SliderBg = Color3.fromRGB(45, 45, 50)
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function Oversimplified:CreateWindow(titleText)
    local guiName = "OversimplifiedUI"
    if CoreGui:FindFirstChild(guiName) then CoreGui[guiName]:Destroy() end

    local ScreenGui = Instance.new("ScreenGui"); ScreenGui.Name = guiName; ScreenGui.Parent = CoreGui
    local MainFrame = Instance.new("Frame"); MainFrame.Size = UDim2.new(0, 500, 0, 350); MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175); MainFrame.BackgroundColor3 = self.Theme.Bg; MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
    local UIStroke = Instance.new("UIStroke", MainFrame); UIStroke.Color = self.Theme.Border; UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    MakeDraggable(MainFrame)

    local Title = Instance.new("TextLabel", MainFrame); Title.Size = UDim2.new(1, 0, 0, 30); Title.BackgroundTransparency = 1; Title.Text = "  " .. titleText; Title.TextColor3 = self.Theme.Text; Title.Font = Enum.Font.GothamBold; Title.TextSize = 14; Title.TextXAlignment = Enum.TextXAlignment.Left
    local Divider = Instance.new("Frame", MainFrame); Divider.Size = UDim2.new(1, 0, 0, 1); Divider.Position = UDim2.new(0, 0, 0, 30); Divider.BackgroundColor3 = self.Theme.Border; Divider.BorderSizePixel = 0

    -- Tab System UI
    local TabContainer = Instance.new("ScrollingFrame", MainFrame); TabContainer.Size = UDim2.new(0, 120, 1, -40); TabContainer.Position = UDim2.new(0, 5, 0, 35); TabContainer.BackgroundTransparency = 1; TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)
    
    local ContentContainer = Instance.new("Frame", MainFrame); ContentContainer.Size = UDim2.new(1, -135, 1, -40); ContentContainer.Position = UDim2.new(0, 130, 0, 35); ContentContainer.BackgroundTransparency = 1

    local WindowObj = { CurrentTab = nil }

    function WindowObj:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton", TabContainer); TabBtn.Size = UDim2.new(1, 0, 0, 30); TabBtn.BackgroundColor3 = Oversimplified.Theme.Inactive; TabBtn.TextColor3 = Oversimplified.Theme.Text; TabBtn.Font = Enum.Font.GothamMedium; TabBtn.TextSize = 13; TabBtn.Text = tabName
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)

        local TabScroll = Instance.new("ScrollingFrame", ContentContainer); TabScroll.Size = UDim2.new(1, 0, 1, 0); TabScroll.BackgroundTransparency = 1; TabScroll.ScrollBarThickness = 2; TabScroll.Visible = false
        local Layout = Instance.new("UIListLayout", TabScroll); Layout.Padding = UDim.new(0, 5)

        TabBtn.MouseButton1Click:Connect(function()
            for _, child in ipairs(ContentContainer:GetChildren()) do if child:IsA("ScrollingFrame") then child.Visible = false end end
            for _, btn in ipairs(TabContainer:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3 = Oversimplified.Theme.Inactive end end
            TabScroll.Visible = true; TabBtn.BackgroundColor3 = Oversimplified.Theme.Active
        end)

        if not self.CurrentTab then TabScroll.Visible = true; TabBtn.BackgroundColor3 = Oversimplified.Theme.Active; self.CurrentTab = tabName end

        local Elements = {}

        function Elements:CreateLabel(text)
            local Lbl = Instance.new("TextLabel", TabScroll); Lbl.Size = UDim2.new(1, -10, 0, 25); Lbl.BackgroundTransparency = 1; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 14; Lbl.TextXAlignment = Enum.TextXAlignment.Left; Lbl.Text = text
            TabScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
        end

        function Elements:CreateButton(text, callback)
            local Btn = Instance.new("TextButton", TabScroll); Btn.Size = UDim2.new(1, -10, 0, 34); Btn.BackgroundColor3 = Oversimplified.Theme.Inactive; Btn.TextColor3 = Oversimplified.Theme.Text; Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 13; Btn.Text = text
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
            Btn.MouseButton1Click:Connect(callback)
            TabScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
        end

        function Elements:CreateToggle(text, default, callback)
            local Container = Instance.new("TextButton", TabScroll); Container.Size = UDim2.new(1, -10, 0, 34); Container.BackgroundColor3 = Oversimplified.Theme.Bg; Container.Text = ""; Container.AutoButtonColor = false
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border
            
            local Lbl = Instance.new("TextLabel", Container); Lbl.Size = UDim2.new(1, -60, 1, 0); Lbl.Position = UDim2.new(0, 10, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamBold; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
            local Track = Instance.new("Frame", Container); Track.Size = UDim2.new(0, 36, 0, 18); Track.Position = UDim2.new(1, -46, 0.5, -9); Track.BackgroundColor3 = default and Oversimplified.Theme.Good or Oversimplified.Theme.Inactive
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
            local Circle = Instance.new("Frame", Track); Circle.Size = UDim2.new(0, 14, 0, 14); Circle.Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7); Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

            local state = default
            Container.MouseButton1Click:Connect(function()
                state = not state; callback(state)
                TweenService:Create(Track, TweenInfo.new(0.2), {BackgroundColor3 = state and Oversimplified.Theme.Good or Oversimplified.Theme.Inactive}):Play()
                TweenService:Create(Circle, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
            end)
            TabScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
        end

        function Elements:CreateSlider(text, min, max, default, callback)
            local Container = Instance.new("Frame", TabScroll); Container.Size = UDim2.new(1, -10, 0, 50); Container.BackgroundColor3 = Oversimplified.Theme.Bg; Container.BorderSizePixel = 0
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border
            
            local Lbl = Instance.new("TextLabel", Container); Lbl.Size = UDim2.new(1, -20, 0, 20); Lbl.Position = UDim2.new(0, 10, 0, 5); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamBold; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
            local ValueLbl = Instance.new("TextLabel", Container); ValueLbl.Size = UDim2.new(0, 50, 0, 20); ValueLbl.Position = UDim2.new(1, -60, 0, 5); ValueLbl.BackgroundTransparency = 1; ValueLbl.Text = tostring(default); ValueLbl.TextColor3 = Oversimplified.Theme.Text; ValueLbl.Font = Enum.Font.GothamMedium; ValueLbl.TextSize = 13; ValueLbl.TextXAlignment = Enum.TextXAlignment.Right
            
            local SliderBg = Instance.new("TextButton", Container); SliderBg.Size = UDim2.new(1, -20, 0, 8); SliderBg.Position = UDim2.new(0, 10, 0, 30); SliderBg.BackgroundColor3 = Oversimplified.Theme.SliderBg; SliderBg.Text = ""; SliderBg.AutoButtonColor = false
            Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)
            local SliderFill = Instance.new("Frame", SliderBg); SliderFill.Size = UDim2.new(math.clamp((default - min) / (max - min), 0, 1), 0, 1, 0); SliderFill.BackgroundColor3 = Oversimplified.Theme.Active
            Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local function updateSlider(input)
                local percentage = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * percentage)
                TweenService:Create(SliderFill, TweenInfo.new(0.05), {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                ValueLbl.Text = tostring(value); callback(value)
            end
            SliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; updateSlider(input) end end)
            UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
            UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end end)

            TabScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
        end

        return Elements
    end

    return WindowObj
end

return Oversimplified
