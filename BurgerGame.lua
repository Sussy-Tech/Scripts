local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/Mercury%20Lib/Mercury%20Lib%20Source.lua"))()
-- fart
local GUI = Mercury:Create{
    Name = "Burger Game",
    Size = UDim2.new(0, 650, 0, 450),
    Theme = Mercury.Themes.Dark
}
local Tab = GUI:Tab{
    Name = "Orders",
    Icon = "rbxassetid//233249802"
}
GUI:Credit{
	Name = "Ivan",
	Description = "me",
	Discord = "not Ivan#0001"
}
local function createButton(name)
    local isLooping = false
    local loopButton = Tab:Toggle{
        Name = "Loop Buy " .. name,
        Callback = function(value)
            isLooping = value
        end
    }

    Tab:Button{
        Name = "Order " .. name,
        Description = nil,
        Callback = function()
            local args = {
                [1] = "Order",
                [2] = name
            }
            if not isLooping then
                game:GetService("ReplicatedStorage").Remotes.Tell:FireServer(unpack(args))
            else
                while isLooping do
                    game:GetService("ReplicatedStorage").Remotes.Tell:FireServer(unpack(args))
                    wait(1)
                end
            end
        end
    }
end

createButton("Bread")
createButton("Fries")
createButton("Veggies")
createButton("Cups")
createButton("Trays")
createButton("Meat")

local loopAllButton = Tab:Toggle{
    Name = "Loop Buy All",
    Callback = function(value)
        for _, button in ipairs(Tab:GetChildren()) do
            if button:IsA("Button") then
                local args = {
                    [1] = "Order",
                    [2] = button.Name:sub(7)
                }
                if value then
                    button:SetInteractable(false)
                    while value do
                        game:GetService("ReplicatedStorage").Remotes.Tell:FireServer(unpack(args))
                        wait(1)
                    end
                    button:SetInteractable(true)
                end
            end
        end
    end
}
while true do
	wait(5)
	game:GetService("UserInputService").MouseIconEnabled = true
end
GUI:SetDraggable(true)
GUI:SetZIndex(99999999999)
GUI:Init()
