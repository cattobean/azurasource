--mercury lib
local Azura = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
--mercury lib's documentation = https://github.com/deeeity/mercury-lib

--create the gui
local GUI = Azura:Create{
    Name = "Azura | Fisch",
    Size = UDim2.fromOffset(600, 400),
    Theme = Azura.Themes.Rust,
    Link = "https://github.com/cattobeans/azura.lua"
}
--humanoid
humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
--tabs

local PlayerTab = GUI:Tab{
	Name = "Player",
	Icon = "rbxassetid://103423369795760"
}

PlayerTab:Slider{
	Name = "Walkspeed Edit",
	Default = 50,
	Min = 0,
	Max = 100,
	Callback = function(speed)
    humanoid.WalkSpeed = speed
    end

}

-- TOGGLE PLATFORM UNDER PLAYER


local platform  -- Variable to store the created platform

-- Function to create the platform under the player
local function createPlatform()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Create a block to act as the platform
    platform = Instance.new("Part")
    platform.Size = Vector3.new(0.25, 6, 6)  -- Platform size (adjust as needed)
    platform.Rotation = Vector3.new(0, 90, 90)
    platform.Position = humanoidRootPart.Position - Vector3.new(0, humanoidRootPart.Position.Y, 0)  -- Position the platform at Y = 0
    platform.Position = Vector3.new(platform.Position.X, 0, platform.Position.Z)  -- Lock the Y axis to 0
    platform.Anchored = true  -- Keep the platform stationary
    platform.CanCollide = true  -- Disable collision to avoid pushing the player up
    platform.BrickColor = BrickColor.new("Deep orange")  -- Set the color to blue (like water)
    platform.Parent = workspace  -- Parent the platform to the workspace
    platform.Shape = Enum.PartType.Cylinder
    platform.Material = Enum.Material.Neon
    platform.Transparency = 0.6
end

-- Function to update the platform's position
local function updatePlatformPosition()
    if platform then
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        -- Lock platform's Y to 0 and follow player's X/Z position
        platform.Position = Vector3.new(humanoidRootPart.Position.X, 126, humanoidRootPart.Position.Z)
    end
end

-- Function to remove the platform
local function removePlatform()
    if platform then
        platform:Destroy()
        platform = nil  -- Clear the reference to the platform
    end
end

-- Set up the toggle button
PlayerTab:Toggle{
    Name = "Walk on Water",  -- Name of the toggle
    StartingState = false,   -- Starting state (off by default)
    Description = "Toggle to enable or disable walking on water.",  -- Optional description
    Callback = function(state)
        if state then
            -- When the toggle is turned ON, create the platform
            createPlatform()

            -- Continuously update the platform's position to follow the player
            game:GetService("RunService").Heartbeat:Connect(function()
                updatePlatformPosition()
            end)
        else
            -- When the toggle is turned OFF, remove the platform
            removePlatform()
        end
    end
}

