-- [[ Oversimplified Example Script by Vhyse ]]

-- [[ 1. Load the Library ]]
local libraryLink = "https://raw.githubusercontent.com/Vhyse/Oversimplified/refs/heads/main/Library.lua"
local Oversimplified = loadstring(game:HttpGet(libraryLink))()

-- [[ 2. Initialize Window ]]
local Window = Oversimplified:CreateWindow("Project: Oversimplified", "")
Window:Notify("Injected Successfully", "Welcome to the advanced showcase. Cinematic backdrop is active.", 4)

-- [[ 3. State Management ]]
local Config = {
    Aimbot = false,
    AimbotFOV = 90,
    ESP = false,
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
local SettingsTab = Window:CreateTab("Settings")

-- ========================================== --
--                COMBAT TAB                  --
-- ========================================== --
CombatTab:CreateParagraph("Aimbot Configuration", "Adjust your targeting settings here.")

local AimbotToggle = CombatTab:CreateToggle("Enable Aimbot", Config.Aimbot, function(state)
    Config.Aimbot = state
    if state then
        Window:Notify("Aimbot Enabled", "Press your assigned key to lock on.", 2)
    end
end)

local FOVSlider = CombatTab:CreateSlider("Aimbot FOV", 10, 300, Config.AimbotFOV, function(value)
    Config.AimbotFOV = value
end)

CombatTab:CreateDropdown("Target Part", {"Head", "Torso", "HumanoidRootPart"}, "Head", function(selected)
    print("Aimbot target updated to:", selected)
end)

local AimKeybind = CombatTab:CreateKeybind("Aimbot Lock Key", Enum.KeyCode.E, function(key)
    if Config.Aimbot then
        print("Locking onto target with key:", key.Name)
    else
        Window:Notify("Aimbot Disabled", "You must enable the aimbot first!", 2)
    end
end)

-- ========================================== --
--               VISUALS TAB                  --
-- ========================================== --
VisualsTab:CreateParagraph("ESP Settings", "Configure player highlights and chams.")

local ESPToggle = VisualsTab:CreateToggle("Enable Player Box ESP", Config.ESP, function(state)
    Config.ESP = state
    -- In a real script, you would loop through players and add/remove Highlight objects here
end)

local ESPColorPicker = VisualsTab:CreateColorPicker("Box ESP Color", Config.ESPColor, function(color)
    Config.ESPColor = color
    -- Update existing ESP boxes to the new color dynamically
end)

VisualsTab:CreateToggle("Show Player Names", false, function(state)
    print("Name ESP:", state)
end)

-- ========================================== --
--             LOCAL PLAYER TAB               --
-- ========================================== --
PlayerTab:CreateParagraph("Character Mods", "Enhance your movement capabilities.")

local WSSlider = PlayerTab:CreateSlider("WalkSpeed Override", 16, 200, Config.WalkSpeed, function(value)
    Config.WalkSpeed = value
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
    end
end)

local JPSlider = PlayerTab:CreateSlider("JumpPower Override", 50, 300, Config.JumpPower, function(value)
    Config.JumpPower = value
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.UseJumpPower = true
        char.Humanoid.JumpPower = value
    end
end)

PlayerTab:CreateButton("Reset Character", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 0
        Window:Notify("Respawning", "Character reset triggered.", 2)
    end
end)

-- ========================================== --
--               SETTINGS TAB                 --
-- ========================================== --
-- This tab shows off the power of the Dynamic Updaters!

SettingsTab:CreateParagraph("Hub Management", "Control the script and your configurations.")

SettingsTab:CreateLabel("Press 'Insert' to hide the UI seamlessly.")

SettingsTab:CreateButton("Reset All Configs to Default", function()
    -- We use the new dynamic :Set() methods to visually update the UI 
    -- while simultaneously triggering their callback functions!
    
    AimbotToggle:Set(false)
    FOVSlider:Set(90)
    
    ESPToggle:Set(false)
    ESPColorPicker:Set(Color3.fromRGB(255, 0, 0))
    
    WSSlider:Set(16)
    JPSlider:Set(50)
    
    Window:Notify("Configs Wiped", "All settings have been restored to default values safely.", 3)
end)

-- A fun little dynamic interaction using the Input updater
local StatusInput = SettingsTab:CreateInput("Current Status", "Idle...", function(text) end)

SettingsTab:CreateButton("Trigger AFK Mode", function()
    -- Dynamically update the input box text and its title
    StatusInput:Set("User is currently AFK.", "AFK Mode Active:")
    WSSlider:Set(0) -- Freeze the player dynamically
    Window:Notify("AFK Mode", "You are frozen. Reset configs to move again.", 3)
end)
