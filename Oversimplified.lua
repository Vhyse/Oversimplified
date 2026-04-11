-- [[ Oversimplified UI Library v2.3 - Keybind Clear Patch ]] --
local Oversimplified = {}

Oversimplified.Theme = {
    Bg = Color3.fromRGB(24, 24, 27),        
    Border = Color3.fromRGB(55, 55, 60),    
    Text = Color3.fromRGB(228, 228, 231),   
    Active = Color3.fromRGB(99, 102, 241),  
    Inactive = Color3.fromRGB(40, 40, 45),  
    Good = Color3.fromRGB(74, 222, 128),    
    SliderBg = Color3.fromRGB(45, 45, 50),
    DarkerBg = Color3.fromRGB(18, 18, 20)
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
    
    local MainFrame = Instance.new("CanvasGroup"); MainFrame.Size = UDim2.new(0, 520, 0, 380); MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190); MainFrame.BackgroundColor3 = self.Theme.Bg; MainFrame.Parent = ScreenGui; MainFrame.GroupTransparency = 1
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
    local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = self.Theme.Border; MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MakeDraggable(MainFrame)

    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()

    local isVisible = true
    local isTweening = false
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert and not isTweening then
            isTweening = true
            isVisible = not isVisible
            if isVisible then
                MainFrame.Visible = true
                local t = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {GroupTransparency = 0})
                t:Play(); t.Completed:Wait()
            else
                local t = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {GroupTransparency = 1})
                t:Play(); t.Completed:Wait()
                MainFrame.Visible = false
            end
            isTweening = false
        end
    end)

    local Title = Instance.new("TextLabel", MainFrame); Title.Size = UDim2.new(1, 0, 0, 30); Title.BackgroundTransparency = 1; Title.Text = "  " .. titleText; Title.TextColor3 = self.Theme.Active; Title.Font = Enum.Font.GothamBold; Title.TextSize = 14; Title.TextXAlignment = Enum.TextXAlignment.Left
    local Divider = Instance.new("Frame", MainFrame); Divider.Size = UDim2.new(1, 0, 0, 1); Divider.Position = UDim2.new(0, 0, 0, 30); Divider.BackgroundColor3 = self.Theme.Border; Divider.BorderSizePixel = 0

    local TabContainer = Instance.new("ScrollingFrame", MainFrame); TabContainer.Size = UDim2.new(0, 130, 1, -40); TabContainer.Position = UDim2.new(0, 0, 0, 35); TabContainer.BackgroundTransparency = 1; TabContainer.ScrollBarThickness = 0
    local TabLayout = Instance.new("UIListLayout", TabContainer); TabLayout.Padding = UDim.new(0, 5); TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local TabPad = Instance.new("UIPadding", TabContainer); TabPad.PaddingTop = UDim.new(0, 2); TabPad.PaddingBottom = UDim.new(0, 2)
    
    local ContentContainer = Instance.new("CanvasGroup", MainFrame); ContentContainer.Size = UDim2.new(1, -135, 1, -40); ContentContainer.Position = UDim2.new(0, 130, 0, 35); ContentContainer.BackgroundTransparency = 1

    local WindowObj = { CurrentTab = nil }
    local isSwitchingTab = false

    function WindowObj:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton", TabContainer); TabBtn.Size = UDim2.new(1, -16, 0, 30); TabBtn.BackgroundColor3 = Oversimplified.Theme.Inactive; TabBtn.TextColor3 = Oversimplified.Theme.Text; TabBtn.Font = Enum.Font.GothamMedium; TabBtn.TextSize = 13; TabBtn.Text = tabName; TabBtn.AutoButtonColor = false
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)
        local TabStroke = Instance.new("UIStroke", TabBtn); TabStroke.Color = Oversimplified.Theme.Border; TabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local TabScroll = Instance.new("ScrollingFrame", ContentContainer); TabScroll.Size = UDim2.new(1, 0, 1, 0); TabScroll.BackgroundTransparency = 1; TabScroll.ScrollBarThickness = 2; TabScroll.Visible = false
        local Layout = Instance.new("UIListLayout", TabScroll); Layout.Padding = UDim.new(0, 6); Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center; Layout.SortOrder = Enum.SortOrder.LayoutOrder
        local ScrollPad = Instance.new("UIPadding", TabScroll); ScrollPad.PaddingTop = UDim.new(0, 2); ScrollPad.PaddingBottom = UDim.new(0, 2)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 15)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            if WindowObj.CurrentTab == tabName or isSwitchingTab then return end
            isSwitchingTab = true
            local fadeOut = TweenService:Create(ContentContainer, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {GroupTransparency = 1})
            fadeOut:Play(); fadeOut.Completed:Wait()

            for _, child in ipairs(ContentContainer:GetChildren()) do if child:IsA("ScrollingFrame") then child.Visible = false end end
            for _, btn in ipairs(TabContainer:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3 = Oversimplified.Theme.Inactive end end
            TabScroll.Visible = true; TabBtn.BackgroundColor3 = Oversimplified.Theme.Active
            WindowObj.CurrentTab = tabName

            local fadeIn = TweenService:Create(ContentContainer, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {GroupTransparency = 0})
            fadeIn:Play(); fadeIn.Completed:Wait()
            isSwitchingTab = false
        end)

        if not self.CurrentTab then TabScroll.Visible = true; TabBtn.BackgroundColor3 = Oversimplified.Theme.Active; self.CurrentTab = tabName end

        local Elements = {}

        function Elements:CreateParagraph(title, desc)
            local Container = Instance.new("Frame", TabScroll); Container.Size = UDim2.new(1, -14, 0, 50); Container.BackgroundColor3 = Oversimplified.Theme.Bg
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border; Container.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local LblTitle = Instance.new("TextLabel", Container); LblTitle.Size = UDim2.new(1, -20, 0, 20); LblTitle.Position = UDim2.new(0, 10, 0, 5); LblTitle.BackgroundTransparency = 1; LblTitle.Text = title; LblTitle.TextColor3 = Oversimplified.Theme.Active; LblTitle.Font = Enum.Font.GothamBold; LblTitle.TextSize = 13; LblTitle.TextXAlignment = Enum.TextXAlignment.Left
            local LblDesc = Instance.new("TextLabel", Container); LblDesc.Size = UDim2.new(1, -20, 0, 20); LblDesc.Position = UDim2.new(0, 10, 0, 25); LblDesc.BackgroundTransparency = 1; LblDesc.Text = desc; LblDesc.TextColor3 = Oversimplified.Theme.Text; LblDesc.Font = Enum.Font.Gotham; LblDesc.TextSize = 12; LblDesc.TextXAlignment = Enum.TextXAlignment.Left; LblDesc.TextWrapped = true
        end

        function Elements:CreateLabel(text)
            local Lbl = Instance.new("TextLabel", TabScroll); Lbl.Size = UDim2.new(1, -14, 0, 25); Lbl.BackgroundTransparency = 1; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamBold; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left; Lbl.Text = text
        end

        function Elements:CreateButton(text, callback)
            local Btn = Instance.new("TextButton", TabScroll); Btn.Size = UDim2.new(1, -14, 0, 34); Btn.BackgroundColor3 = Oversimplified.Theme.Inactive; Btn.TextColor3 = Oversimplified.Theme.Text; Btn.Font = Enum.Font.GothamMedium; Btn.TextSize = 13; Btn.Text = text; Btn.AutoButtonColor = false
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Btn).Color = Oversimplified.Theme.Border; Btn.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            Btn.MouseButton1Click:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Oversimplified.Theme.Active}):Play(); task.wait(0.1); TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Oversimplified.Theme.Inactive}):Play(); callback() end)
        end

        function Elements:CreateToggle(text, default, callback)
            local Container = Instance.new("TextButton", TabScroll); Container.Size = UDim2.new(1, -14, 0, 34); Container.BackgroundColor3 = Oversimplified.Theme.Bg; Container.Text = ""; Container.AutoButtonColor = false
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border; Container.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local Lbl = Instance.new("TextLabel", Container); Lbl.Size = UDim2.new(1, -60, 1, 0); Lbl.Position = UDim2.new(0, 10, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
            local Track = Instance.new("Frame", Container); Track.Size = UDim2.new(0, 36, 0, 18); Track.Position = UDim2.new(1, -46, 0.5, -9); Track.BackgroundColor3 = default and Oversimplified.Theme.Active or Oversimplified.Theme.Inactive
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
            local Circle = Instance.new("Frame", Track); Circle.Size = UDim2.new(0, 14, 0, 14); Circle.Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7); Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
            local state = default
            Container.MouseButton1Click:Connect(function()
                state = not state; callback(state)
                TweenService:Create(Track, TweenInfo.new(0.2), {BackgroundColor3 = state and Oversimplified.Theme.Active or Oversimplified.Theme.Inactive}):Play()
                TweenService:Create(Circle, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
            end)
        end

        function Elements:CreateSlider(text, min, max, default, callback)
            local Container = Instance.new("Frame", TabScroll); Container.Size = UDim2.new(1, -14, 0, 50); Container.BackgroundColor3 = Oversimplified.Theme.Bg
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border; Container.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local Lbl = Instance.new("TextLabel", Container); Lbl.Size = UDim2.new(1, -20, 0, 20); Lbl.Position = UDim2.new(0, 10, 0, 5); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
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
        end

        function Elements:CreateInput(text, placeholder, callback)
            local Container = Instance.new("Frame", TabScroll); Container.Size = UDim2.new(1, -14, 0, 34); Container.BackgroundColor3 = Oversimplified.Theme.Bg
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border; Container.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local Lbl = Instance.new("TextLabel", Container); Lbl.Size = UDim2.new(0.5, 0, 1, 0); Lbl.Position = UDim2.new(0, 10, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
            local InputBox = Instance.new("TextBox", Container); InputBox.Size = UDim2.new(0.5, -20, 0, 24); InputBox.Position = UDim2.new(0.5, 10, 0.5, -12); InputBox.BackgroundColor3 = Oversimplified.Theme.DarkerBg; InputBox.TextColor3 = Oversimplified.Theme.Text; InputBox.PlaceholderText = placeholder; InputBox.Font = Enum.Font.Gotham; InputBox.TextSize = 12; InputBox.ClearTextOnFocus = false
            Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", InputBox).Color = Oversimplified.Theme.Border; InputBox.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            InputBox.FocusLost:Connect(function() callback(InputBox.Text) end)
        end

        -- [[ UPDATED KEYBIND WITH CLEAR FUNCTIONALITY ]]
        function Elements:CreateKeybind(text, defaultKey, callback)
            local Container = Instance.new("Frame", TabScroll); Container.Size = UDim2.new(1, -14, 0, 34); Container.BackgroundColor3 = Oversimplified.Theme.Bg
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border; Container.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            
            local Lbl = Instance.new("TextLabel", Container); Lbl.Size = UDim2.new(0.5, 0, 1, 0); Lbl.Position = UDim2.new(0, 10, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
            
            -- Display "None" if defaultKey is nil
            local startText = defaultKey and defaultKey.Name or "None"
            local BindBtn = Instance.new("TextButton", Container); BindBtn.Size = UDim2.new(0, 80, 0, 24); BindBtn.Position = UDim2.new(1, -90, 0.5, -12); BindBtn.BackgroundColor3 = Oversimplified.Theme.DarkerBg; BindBtn.TextColor3 = Oversimplified.Theme.Active; BindBtn.Font = Enum.Font.GothamBold; BindBtn.TextSize = 12; BindBtn.Text = startText; BindBtn.AutoButtonColor = false
            Instance.new("UICorner", BindBtn).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", BindBtn).Color = Oversimplified.Theme.Border; BindBtn.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            
            local currentKey = defaultKey
            local listening = false

            BindBtn.MouseButton1Click:Connect(function()
                listening = true; BindBtn.Text = "..."
                local connection
                connection = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        listening = false
                        
                        -- Check for Backspace to clear the bind
                        if input.KeyCode == Enum.KeyCode.Backspace then
                            currentKey = nil
                            BindBtn.Text = "None"
                        else
                            currentKey = input.KeyCode
                            BindBtn.Text = currentKey.Name
                        end
                        
                        connection:Disconnect()
                    end
                end)
            end)

            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                -- Only trigger if listening is false, game didn't process it, and currentKey isn't nil
                if not listening and not gameProcessed and currentKey and input.KeyCode == currentKey then 
                    callback(currentKey) 
                end
            end)
        end

        function Elements:CreateDropdown(text, options, default, callback)
            local Container = Instance.new("Frame", TabScroll); Container.Size = UDim2.new(1, -14, 0, 34); Container.BackgroundColor3 = Oversimplified.Theme.Bg; Container.ClipsDescendants = true
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border; Container.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local DropBtn = Instance.new("TextButton", Container); DropBtn.Size = UDim2.new(1, 0, 0, 34); DropBtn.BackgroundTransparency = 1; DropBtn.Text = ""; DropBtn.AutoButtonColor = false
            local Lbl = Instance.new("TextLabel", DropBtn); Lbl.Size = UDim2.new(0.5, 0, 1, 0); Lbl.Position = UDim2.new(0, 10, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
            local SelectedLbl = Instance.new("TextLabel", DropBtn); SelectedLbl.Size = UDim2.new(0.5, -30, 1, 0); SelectedLbl.Position = UDim2.new(0.5, 0, 0, 0); SelectedLbl.BackgroundTransparency = 1; SelectedLbl.Text = default; SelectedLbl.TextColor3 = Oversimplified.Theme.Active; SelectedLbl.Font = Enum.Font.GothamMedium; SelectedLbl.TextSize = 12; SelectedLbl.TextXAlignment = Enum.TextXAlignment.Right
            local Icon = Instance.new("TextLabel", DropBtn); Icon.Size = UDim2.new(0, 20, 1, 0); Icon.Position = UDim2.new(1, -20, 0, 0); Icon.BackgroundTransparency = 1; Icon.Text = "+"; Icon.TextColor3 = Oversimplified.Theme.Text; Icon.Font = Enum.Font.GothamBold; Icon.TextSize = 14
            local OptionContainer = Instance.new("Frame", Container); OptionContainer.Size = UDim2.new(1, -20, 0, 0); OptionContainer.Position = UDim2.new(0, 10, 0, 34); OptionContainer.BackgroundTransparency = 1
            local OptLayout = Instance.new("UIListLayout", OptionContainer); OptLayout.Padding = UDim.new(0, 2)
            
            local open = false
            local function toggle()
                open = not open
                Icon.Text = open and "-" or "+"
                local targetSize = open and UDim2.new(1, -14, 0, 34 + (#options * 26) + 5) or UDim2.new(1, -14, 0, 34)
                TweenService:Create(Container, TweenInfo.new(0.2), {Size = targetSize}):Play()
            end
            DropBtn.MouseButton1Click:Connect(toggle)

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton", OptionContainer); OptBtn.Size = UDim2.new(1, 0, 0, 24); OptBtn.BackgroundColor3 = Oversimplified.Theme.DarkerBg; OptBtn.TextColor3 = Oversimplified.Theme.Text; OptBtn.Font = Enum.Font.Gotham; OptBtn.TextSize = 12; OptBtn.Text = opt; OptBtn.AutoButtonColor = false
                Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 4)
                OptBtn.MouseButton1Click:Connect(function() SelectedLbl.Text = opt; toggle(); callback(opt) end)
            end
        end

        function Elements:CreateColorPicker(text, defaultColor, callback)
            local Container = Instance.new("Frame", TabScroll); Container.Size = UDim2.new(1, -14, 0, 34); Container.BackgroundColor3 = Oversimplified.Theme.Bg; Container.ClipsDescendants = true
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", Container).Color = Oversimplified.Theme.Border; Container.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local PickBtn = Instance.new("TextButton", Container); PickBtn.Size = UDim2.new(1, 0, 0, 34); PickBtn.BackgroundTransparency = 1; PickBtn.Text = ""; PickBtn.AutoButtonColor = false
            local Lbl = Instance.new("TextLabel", PickBtn); Lbl.Size = UDim2.new(0.5, 0, 1, 0); Lbl.Position = UDim2.new(0, 10, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = Oversimplified.Theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
            local ColorPreview = Instance.new("Frame", PickBtn); ColorPreview.Size = UDim2.new(0, 40, 0, 16); ColorPreview.Position = UDim2.new(1, -50, 0.5, -8); ColorPreview.BackgroundColor3 = defaultColor
            Instance.new("UICorner", ColorPreview).CornerRadius = UDim.new(0, 4); Instance.new("UIStroke", ColorPreview).Color = Oversimplified.Theme.Border; ColorPreview.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local SlidersFrame = Instance.new("Frame", Container); SlidersFrame.Size = UDim2.new(1, -20, 0, 80); SlidersFrame.Position = UDim2.new(0, 10, 0, 34); SlidersFrame.BackgroundTransparency = 1
            local S_Layout = Instance.new("UIListLayout", SlidersFrame); S_Layout.Padding = UDim.new(0, 5)

            local open = false
            PickBtn.MouseButton1Click:Connect(function()
                open = not open
                local targetSize = open and UDim2.new(1, -14, 0, 120) or UDim2.new(1, -14, 0, 34)
                TweenService:Create(Container, TweenInfo.new(0.2), {Size = targetSize}):Play()
            end)

            local r, g, b = defaultColor.R * 255, defaultColor.G * 255, defaultColor.B * 255
            local function updateColor()
                local newColor = Color3.fromRGB(r, g, b)
                ColorPreview.BackgroundColor3 = newColor
                callback(newColor)
            end

            local function createColorSlider(cName, defaultVal, trackColor)
                local S_Frame = Instance.new("Frame", SlidersFrame); S_Frame.Size = UDim2.new(1, 0, 0, 20); S_Frame.BackgroundTransparency = 1
                local S_Bg = Instance.new("TextButton", S_Frame); S_Bg.Size = UDim2.new(1, -30, 0, 6); S_Bg.Position = UDim2.new(0, 0, 0.5, -3); S_Bg.BackgroundColor3 = Oversimplified.Theme.SliderBg; S_Bg.Text = ""; S_Bg.AutoButtonColor = false
                Instance.new("UICorner", S_Bg).CornerRadius = UDim.new(1, 0)
                local S_Fill = Instance.new("Frame", S_Bg); S_Fill.Size = UDim2.new(defaultVal/255, 0, 1, 0); S_Fill.BackgroundColor3 = trackColor
                Instance.new("UICorner", S_Fill).CornerRadius = UDim.new(1, 0)
                local S_Val = Instance.new("TextLabel", S_Frame); S_Val.Size = UDim2.new(0, 25, 1, 0); S_Val.Position = UDim2.new(1, -25, 0, 0); S_Val.BackgroundTransparency = 1; S_Val.Text = tostring(math.floor(defaultVal)); S_Val.TextColor3 = Oversimplified.Theme.Text; S_Val.Font = Enum.Font.Gotham; S_Val.TextSize = 11
                local dragging = false
                local function s_update(input)
                    local percentage = math.clamp((input.Position.X - S_Bg.AbsolutePosition.X) / S_Bg.AbsoluteSize.X, 0, 1)
                    local val = math.floor(percentage * 255)
                    TweenService:Create(S_Fill, TweenInfo.new(0.05), {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                    S_Val.Text = tostring(val)
                    if cName == "R" then r = val elseif cName == "G" then g = val else b = val end
                    updateColor()
                end
                S_Bg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; s_update(input) end end)
                UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
                UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then s_update(input) end end)
            end

            createColorSlider("R", r, Color3.fromRGB(255, 75, 75))
            createColorSlider("G", g, Color3.fromRGB(75, 255, 75))
            createColorSlider("B", b, Color3.fromRGB(75, 75, 255))
        end

        return Elements
    end

    return WindowObj
end

return Oversimplified
