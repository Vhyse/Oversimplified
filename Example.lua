-- [[ OVERSIMPLIFIED UI LIBRARY EXAMPLE SHOWCASE ]] --

-- [[ 1. Load the Library ]]
-- (Ensure you have executed the source code first, or load it via URL if hosted)
local Oversimplified = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vhyse/Oversimplified/refs/heads/main/Library.lua"))()
local Oversimplified = getgenv().Oversimplified -- Assuming the source is loaded in your environment

-- [[ 2. Initialize Window ]]
local Window = Oversimplified:CreateWindow("Project: Oversimplified", "")
Window:Notify("Injected Successfully", "Welcome to the advanced showcase. All updaters are active.", 4)

-- [[ 3. State Management ]]
local Config = {
    Aimbot = false,
    AimbotFOV = 90,
    TargetPart = "Head",
    AimKey = Enum.KeyCode.E,
    ESP = false,
    ShowNames = false,
    ESPColor = Color3.fromRGB(255, 0, 0),
    WalkSpeed = 16,
    JumpPower = 50
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- [[ 4. Create Tabs ]]
local CombatTab = Window:CreateTab("Combat")
local VisualsTab = Window:CreateTab("Visuals")
local PlayerTab = Window:CreateTab("Local Player")

-- ========================================== --
--                COMBAT TAB                  --
-- ========================================== --

-- Testing the new dynamic automatic wrapping for long paragraphs
local CombatPara = CombatTab:CreateParagraph(
    "Aimbot Configuration", 
    "Adjust your targeting settings here. Notice how this description is incredibly long, but because of the AutomaticSize system you requested, the UI seamlessly pushes the rest of the text downward and adjusts the boundaries without breaking anything at all!"
)

local AimbotToggle = CombatTab:CreateToggle("Enable Aimbot", Config.Aimbot, function(state)
    Config.Aimbot = state
    if state then
        Window:Notify("Aimbot Enabled", "Press your assigned key to lock on.", 2)
    end
end)

local FOVSlider = CombatTab:CreateSlider("Aimbot FOV", 10, 300, Config.AimbotFOV, function(value)
    Config.AimbotFOV = value
end)

local TargetDropdown = CombatTab:CreateDropdown("Target Part", {"Head", "Torso", "HumanoidRootPart"}, Config.TargetPart, function(selected)
    Config.TargetPart = selected
end)

local AimKeybind = CombatTab:CreateKeybind("Aimbot Lock Key", Config.AimKey, function(key)
    if not Config.Aimbot then
        Window:Notify("Aimbot Disabled", "You must enable the aimbot first!", 2)
    end
end)

-- ========================================== --
--               VISUALS TAB                  --
-- ========================================== --
local VisualsPara = VisualsTab:CreateParagraph("ESP Settings", "Configure player highlights and chams.")

local ESPToggle = VisualsTab:CreateToggle("Enable Player Box ESP", Config.ESP, function(state)
    Config.ESP = state
end)

local ESPColorPicker = VisualsTab:CreateColorPicker("Box ESP Color", Config.ESPColor, function(color)
    Config.ESPColor = color
end)

local NameToggle = VisualsTab:CreateToggle("Show Player Names", Config.ShowNames, function(state)
    Config.ShowNames = state
end)

-- ========================================== --
--             LOCAL PLAYER TAB               --
-- ========================================== --
local PlayerPara = PlayerTab:CreateParagraph("Character Mods", "Enhance your movement capabilities.")

local WSSlider = PlayerTab:CreateSlider("WalkSpeed Override", 16, 200, Config.WalkSpeed, function(value)
    Config.WalkSpeed = value
end)

local JPSlider = PlayerTab:CreateSlider("JumpPower Override", 50, 300, Config.JumpPower, function(value)
    Config.JumpPower = value
end)

-- ========================================== --
--      NEW: DEDICATED HUB SETTINGS TAB       --
-- ========================================== --

-- This automatically generates a tab locked to the bottom with the Background and Identity toggles
local SettingsTab = Window:AddHubSettingsTab()

local SettingsPara = SettingsTab:CreateParagraph("Hub Management", "Use these buttons to test the v6.0 Dynamic Updaters.")
local InfoLabel = SettingsTab:CreateLabel("Press 'Insert' to hide the UI seamlessly.")

SettingsTab:CreateButton("Reset All Configs to Default", function()
    AimbotToggle:Set(false)
    FOVSlider:Set(90)
    TargetDropdown:Set("Head")
    AimKeybind:Set(Enum.KeyCode.E)
    ESPToggle:Set(false)
    NameToggle:Set(false)
    ESPColorPicker:Set(Color3.fromRGB(255, 0, 0))
    WSSlider:Set(16)
    JPSlider:Set(50)
    Window:Notify("Configs Wiped", "All settings have been restored to default values.", 3)
end)

SettingsTab:CreateButton("Refresh Target Dropdown (Fetch Players)", function()
    local playersList = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(playersList, p.Name) end
    end
    if #playersList == 0 then table.insert(playersList, "No Targets Found") end 
    TargetDropdown:Refresh(playersList, playersList[1])
    Window:Notify("Targets Refreshed", "Aimbot dropdown now shows alive players.", 3)
end)

-- Testing the new true/false 'clearOnLeave' property for TextBoxes (set to true here)
local StatusInput = SettingsTab:CreateInput("Current Status", "Idle...", true, function(text) 
    print("User updated status to:", text)
end)

SettingsTab:CreateButton("Trigger AFK Mode", function()
    StatusInput:Set("User is currently AFK.", "AFK Mode Active:")
    WSSlider:Set(0)
    JPSlider:Set(0)
    InfoLabel:Set("AFK MODE ENGAGED. PLEASE RESET CONFIGS.")
    SettingsPara:Set("Hub Frozen", "You have triggered AFK mode. Movement is disabled.")
end)

local SelfDestructBtn = SettingsTab:CreateButton("Unload Script", function()
    Window:Unload()
end)
