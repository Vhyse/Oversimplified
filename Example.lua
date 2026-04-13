-- [[ 1. Load the Oversimplified Library ]]
local libraryLink = "https://raw.githubusercontent.com/Vhyse/Oversimplified/refs/heads/main/Library.lua"
local Oversimplified = loadstring(game:HttpGet(libraryLink))()

-- [[ 2. Create the Main Window ]]
-- Pass "" or nil to skip the Key System.
-- Notice we no longer pass any weird colors, just pure default dark aesthetics.
local Window = Oversimplified:CreateWindow("Oversimplified Showcase", "")

Window:Notify("Welcome!", "This script demonstrates the pure white, clean dark background in v5.2.", 4)

-- [[ 3. Create Tabs ]]
local MainTab = Window:CreateTab("All Elements")
local DynamicTab = Window:CreateTab("Dynamic Tests")

-- ========================================== --
--       TAB 1: ALL ELEMENTS SHOWCASE        
-- ========================================== --
MainTab:CreateParagraph("Information", "This tab contains every single static and interactive element available in the Oversimplified UI Library. Notice the pure white text, clean dark background, and flawless macOS window controls!")
MainTab:CreateLabel("This is a clean, standard label.")

MainTab:CreateButton("Standard Button", function() 
    Window:Notify("Clicked", "You clicked the standard button!", 2) 
end)

MainTab:CreateToggle("Enable Feature", false, function(state) 
    print("Toggle is now:", state) 
end)

MainTab:CreateSlider("Speed Modifier", 16, 100, 16, function(value) 
    print("Slider value:", value) 
end)

MainTab:CreateInput("Target Username", "Enter name here...", function(text) 
    print("Input received:", text) 
end)

MainTab:CreateKeybind("Invisibility Key", Enum.KeyCode.F, function(key) 
    print("Keybind triggered:", key.Name) 
end)

MainTab:CreateDropdown("Select Hitbox", {"Head", "Torso", "HumanoidRootPart"}, "Head", function(selected) 
    print("Dropdown changed to:", selected) 
end)

MainTab:CreateColorPicker("ESP Color", Color3.fromRGB(255, 255, 255), function(color) 
    print("Color changed to RGB:", math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255)) 
end)

-- ========================================== --
--       TAB 2: DYNAMIC UPDATES TESTING      
-- ========================================== --
local DynamicParagraph = DynamicTab:CreateParagraph("API Methods", "Click the buttons below to see the UI elements change dynamically via code.")
local StatusLabel = DynamicTab:CreateLabel("Status: Waiting for update...")
local HealthSlider = DynamicTab:CreateSlider("Health Visualizer", 0, 100, 50, function(val) end)
local PlayerDropdown = DynamicTab:CreateDropdown("Players in Game", {"Loading..."}, "Loading...", function(val) end)

DynamicTab:CreateLabel("--- Update Controls ---")
DynamicTab:CreateButton("Update Paragraph", function() 
    DynamicParagraph:Set("Updated Methods", "The paragraph has been successfully updated via the script!") 
end)

DynamicTab:CreateButton("Update Label (Text)", function() 
    StatusLabel:Set("Status: Updated at " .. os.date("%X")) 
end)

DynamicTab:CreateButton("Force Slider to Max (100)", function() 
    HealthSlider:Set(100) 
end)

DynamicTab:CreateButton("Refresh Dropdown", function()
    local players = {}
    for _, p in ipairs(game.Players:GetPlayers()) do table.insert(players, p.Name) end
    if #players == 0 then table.insert(players, "Only You") end 
    PlayerDropdown:Refresh(players, players[1])
    Window:Notify("Refreshed", "Dropdown now shows actual players in the server.", 3)
end)
