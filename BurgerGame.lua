local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/Mercury%20Lib/Mercury%20Lib%20Source.lua"))()
-- fart
local GUI = Mercury:Create{
    Name = "Fart Hub",
    Size = UDim2.new(0, 650, 0, 450),
    Theme = Mercury.Themes.Dark
}
local Tab = GUI:Tab {
    Name = "Orders",
    Icon = "rbxassetid//233249802"
}
GUI:Credit {
    Name = "Ivan",
    Description = "me",
    Discord = "not Ivan#0001"
}

GUI:Credit {
    Name = "Dottik",
    Description = "Fart",
    Discord = "SharpedMasked#5693"
}
local function createButton(name)
    Tab:Button{
        Name = "Order " .. name,
        Description = "Orders " .. name,
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

local boxes = {
    {Object = Workspace.GameData.Objects.BoxFriCon, Args = {[1] = "Order", [2] = "Cups"}},
    {Object = Workspace.GameData.Objects.Boxreal, Args = {[1] = "Order", [2] = "Cups"}},
    {Object = Workspace.GameData.Objects.Boxtray, Args = {[1] = "Order", [2] = "Trays"}},
    {Object = Workspace.GameData.Objects.Boxbbun, Args = {[1] = "Order", [2] = "Bread"}},
    {Object = Workspace.GameData.Objects.Boxtbun, Args = {[1] = "Order", [2] = "Bread"}},
    {Object = Workspace.GameData.Objects.Boxtom, Args = {[1] = "Order", [2] = "Veggies"}},
    {Object = Workspace.GameData.Objects.Boxbrgr, Args = {[1] = "Order", [2] = "Meat"}},
    {Object = Workspace.GameData.Objects.Boxbac, Args = {[1] = "Order", [2] = "Meat"}},
    {Object = Workspace.GameData.Objects.Boxfri, Args = {[1] = "Order", [2] = "Fries"}},
    {Object = Workspace.GameData.Objects.Boxchz, Args = {[1] = "Order", [2] = "Veggies"}},
    {Object = Workspace.GameData.Objects.Boxpcl, Args = {[1] = "Order", [2] = "Veggies"}},
    {Object = Workspace.GameData.Objects.Boxoni, Args = {[1] = "Order", [2] = "Veggies"}},
    {Object = Workspace.GameData.Objects.Boxltc, Args = {[1] = "Order", [2] = "Veggies"}}
}

numBeforeOrder = nil
stopLoop = false;
function buyIfUnder()
    while true do 
        if stopLoop then return end
        for _, box in ipairs(boxes) do
            if box.Object.Amount.Value < numBeforeOrder then
                game:GetService("ReplicatedStorage").Remotes.Tell:FireServer(unpack(box.Args))
            end
        end
        wait(1)
    end
end

enabledUnBuy = true;

createButton("Bread")
createButton("Fries")
createButton("Veggies")
createButton("Cups")
createButton("Trays")
createButton("Meat")

Tab:Toggle {
    Name = "Order when under _",
    StartingState = false,
    Description = "Orders any ingredient when it has less than the selected amount",
    Callback = function(state)
        if state then 
            stopLoop = false
            buyIfUnder()
        else stopLoop = true end
    end
}
Tab:Textbox {
    Name = "Amount to Order",
    Callback = function(text)
        local num = tonumber(text)
        if (num == nil) then 
            GUI:Notification {
                Title = "This is just numbers, stu-",
                Text = "The prompt you just edited only supports numbers, lmao",
                Duration = 5,
            }
        else 
            numBeforeOrder = num
        end
    end
}

while true do
    wait(2)
    game:GetService("UserInputService").MouseIconEnabled = true
end

GUI:SetZIndex(99999999999)
GUI:Init()
