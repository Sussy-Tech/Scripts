local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
for _, name in ipairs({"Balcony", "Billboard", "CashRegister", "Corals", "LampPost", "Model", "LampPostFlags", "LightFIxture", "LongPillow", "lights", "Palm Tree", "Patio Table", "Piano", "Plant", "Post", "RockDoor", "Roller Rink", "Sapphire", "SquarePillow", "StageLight", "FixedBench", "FairyLights", "Bush", "MeshPart", "Plant_ElephantEar", "Plant_Swiss Cheese", "star", "cylinder", "sand castle", "wall", "log seats", "plant", "wall lamp", "TrafficLight", "hammer", "Waterfall", "back2school", "LED", "Log", "sidewalk"}) do for _, object in ipairs(workspace:GetDescendants()) do if object.Name == name then object:Destroy() end end end
local function waitForRespawn()
    while true do
        if not humanoid.Health > 0 then
            local characterAddedEvent = player.CharacterAdded:Wait()
            humanoid = characterAddedEvent:WaitForChild("Humanoid")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGitHubUsername/YourRepositoryName/YourScriptName.lua"))()
        end
        wait(1)
    end
end

-- Start the respawn check loop in a new thread (coroutine) to run it concurrently with the rest of your code.
coroutine.wrap(waitForRespawn)()
wait(0.1)
Notification:Notify(
    {Title = "hi", Description = "im lazy to make this any better and im retarded"},
    {OutlineColor = Color3.fromRGB(100, 100, 100),Time = 10, Type = "default"}
)
local folderName = "CollectibleDiamonds"
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local function sendNotification(title, text, duration)
    local NotificationService = game:GetService("NotificationService")
    NotificationService:CreateNotification(title, text, duration):SetCallback(function()
        -- Code to run when the notification is clicked (optional)
    end):SetButton1("OK"):SetButton2("Cancel"):SetIcon("rbxassetid://1234567890"):SetSound("rbxassetid://0987654321"):SetDuration(duration):SetCallback(function(callback)
        if callback == Enum.NotificationCallback.Button1 then
            -- Code to run when the "OK" button is clicked (optional)
        elseif callback == Enum.NotificationCallback.Button2 then
            -- Code to run when the "Cancel" button is clicked (optional)
        end
    end):SetCallbackType(Enum.NotificationCallbackType.ActionButton):SetTilt(true):SetClickable(true):SetInteractive(false)
end

local function sendNotificationCoroutine()
    repeat
        wait(5)  -- Adjust the wait time (in seconds) between each notification
        sendNotification("Notification Title", "This is a notification text.", 5)  -- Adjust the title, text, and duration of the notification
    until false
end

coroutine.wrap(sendNotificationCoroutine)()
local function resetAFK()
    player:Move(Vector3.new(0, 0, 0)) -- Move the player slightly to reset their AFK status
end

local function onInput(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        resetAFK()
    end
end

mouse.Move:Connect(onInput)
game:GetService("UserInputService").InputChanged:Connect(onInput)

local function antiAFK()
    repeat
        wait()
    until game:IsLoaded()

    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end

coroutine.wrap(antiAFK)()
local humanoid = player.Character:FindFirstChild("Humanoid")
if humanoid then
    humanoid.WalkSpeed = 120
end
if game.GameId ~= 321778215 then
    player:Kick("Please run this in Diamond Beach")
end

local function clearTerrainRepeatedly()
    while true do
        local terrain = game.Workspace.Terrain
        terrain:Clear()
        wait(5)
    end
end

-- Start the function in a new thread (coroutine) to run it concurrently with the rest of your code.
coroutine.wrap(clearTerrainRepeatedly)()


local diamondAmountLabel = player.PlayerGui.Shop.Header.diamondamount
local isWalking = false 
local bridgeColor = Color3.new(1, 1, 1)


local playersFolder = workspace:FindFirstChild("Players")
local diamondsFolder = workspace:FindFirstChild(folderName)

if not playersFolder then
    playersFolder = Instance.new("Folder")
    playersFolder.Name = "Players"
    playersFolder.Parent = workspace
end


local function deleteOldBridges()
    local bridgesToDelete = {}
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Name == "BridgePart" then
            table.insert(bridgesToDelete, descendant)
        end
    end
    for i = 1, #bridgesToDelete - 2 do
        if bridgesToDelete[i] and bridgesToDelete[i]:IsDescendantOf(workspace) then
            bridgesToDelete[i]:Destroy()
        end
    end
end

local function getDiamondAmount()
    return tonumber(diamondAmountLabel.ContentText) or 0
end

local terrain = game.Workspace.Terrain
terrain:Clear()
local platformStorage = {}
local function buildPlatformUnderPlayer()
    local platformSize = Vector3.new(30, 0.5, 30)
    local platform = Instance.new("Part")
    platform.Size = platformSize
    platform.Anchored = true
    platform.CanCollide = true
    platform.BrickColor = BrickColor.new(bridgeColor)
    local playerPosition = humanoid.RootPart.Position
    platform.CFrame = CFrame.new(playerPosition.X, playerPosition.Y - 3, playerPosition.Z)
    platform.Parent = workspace
    table.insert(platformStorage, platform)
    if #platformStorage > 1 then
        local previousPlatform = platformStorage[1]
        if previousPlatform and previousPlatform:IsDescendantOf(workspace) then
            previousPlatform:Destroy()
            table.remove(platformStorage, 1)
        end
    end
end
buildPlatformUnderPlayer()


local function createBridge(fromPosition, toPosition)
    local bridgeDirection = (toPosition - fromPosition).Unit
    local distance = (toPosition - fromPosition).Magnitude
    deleteOldBridges()
    local bridgePart = Instance.new("Part")
    bridgePart.Name = "BridgePart"
    bridgePart.Size = Vector3.new(15, 0.2, distance + 120)
    bridgePart.Anchored = true
    bridgePart.CanCollide = true
    bridgePart.BrickColor = BrickColor.new(bridgeColor)
    local endpoint = toPosition - bridgeDirection * 2
    bridgePart.CFrame = CFrame.lookAt(fromPosition, endpoint) * CFrame.new(0, -5, -distance / 2)
    local playerLookVector = (toPosition - fromPosition).Unit
    local bridgeLookVector = (toPosition - endpoint).Unit
    local angleY = math.atan2(playerLookVector.X, playerLookVector.Z) - math.atan2(bridgeLookVector.X, bridgeLookVector.Z)
    bridgePart.CFrame = bridgePart.CFrame * CFrame.Angles(0, angleY, -90)
    bridgePart.CFrame = bridgePart.CFrame * CFrame.Angles(0, math.rad(0), 90)
    bridgePart.Parent = workspace
    return bridgePart
end

local lastBridge = nil
local function walkToPart(part)
    isWalking = true
    currentTargetDiamond = part.CFrame
    if humanoid.SeatPart then
        humanoid.Jump = true
        wait(0.1)
        humanoid.Jump = false
    end
    local diamondPosition = part.Position
    local playerPosition = humanoid.RootPart.Position
    local distanceToDiamond = (diamondPosition - playerPosition).Magnitude
    if distanceToDiamond <= 20 and (diamondPosition.Y < playerPosition.Y or diamondPosition.Y > playerPosition.Y) then
        humanoid.RootPart.CFrame = CFrame.new(diamondPosition + Vector3.new(0, 5, 0))
    elseif distanceToDiamond <= 20 and diamondPosition.Y < playerPosition.Y then
        humanoid.RootPart.CFrame = CFrame.new(diamondPosition + Vector3.new(0, -5, 0))
    else
        lastCollectedTime = tick() -- Update the last collected time to the current time
        local originalPosition = humanoid.RootPart.Position
        local originalY = originalPosition.Y
        humanoid.WalkSpeed = 120
        wait(0.1)
        humanoid.WalkSpeed = 120
        humanoid.RootPart.CFrame = CFrame.new(originalPosition.X, originalY, originalPosition.Z)
        local bridge = createBridge(humanoid.RootPart.Position, part.Position)
        humanoid:MoveTo(part.Position)
        humanoid.MoveToFinished:Wait()
        if bridge and bridge:IsDescendantOf(workspace) then
            bridge:Destroy()
        end
        buildPlatformUnderPlayer()
    end
    isWalking = false
end

local function checkForNewParts()
    if not isWalking then
        local folder = workspace:FindFirstChild(folderName)
        if folder then
            local closestPart
            local closestDistance = math.huge
            for _, part in ipairs(folder:GetChildren()) do
                if part:IsA("Part") then
                    local distance = (part.Position - humanoid.RootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestPart = part
                        closestDistance = distance
                    end
                end
            end
            if closestPart then
                if not lastBridge or (lastBridge and not lastBridge:IsDescendantOf(workspace)) then
                    walkToPart(closestPart)
                end
            end
        end
    end
end

local initialDiamondAmount = getDiamondAmount()
local function onDiamondAmountChanged()
    local currentDiamondAmount = getDiamondAmount()
    if currentDiamondAmount - initialDiamondAmount >= 20 then
        wait(5)
        TPReturner()
    end
end

local function noclip()
    local Clip = false
    local function Nocl()
        if Clip == false and game.Players.LocalPlayer.Character ~= nil then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    if v.Name == "BridgePart" then
                        v.CanCollide = true
                    else
                        v.CanCollide = false 
                    end
                end
            end
        end
    end
    Noclip = game:GetService("RunService").Stepped:Connect(Nocl)
    if Clip == true then
        Clip = false
        wait(0.1) 
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end

noclip()
diamondAmountLabel:GetPropertyChangedSignal("ContentText"):Connect(onDiamondAmountChanged)

function Teleport()
    while wait() do
        pcall(
            function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end
        )
    end
end

function Teeleport()
    while true do
        checkForNewParts()
        wait(0.2)
    end
end

Teeleport()

local function onTeleport()
    while not game:IsLoaded() do
        wait()
    end
    wait(5)
    Teeleport()
end

game.Players.LocalPlayer.OnTeleport:Connect(onTeleport)

while true do
    humanoid.Jump = true
    wait(0.1)
    humanoid.Jump = false
    wait(0.1)

    -- Check if there are diamonds available in the CollectibleDiamonds folder.
    local diamondsFolder = workspace:FindFirstChild("CollectibleDiamonds")
    if not diamondsFolder or not diamondsFolder:IsDescendantOf(workspace) or #diamondsFolder:GetChildren() == 0 then
        -- If there are no diamonds available, run the TPReturner function to server hop and find new diamonds.
        TPReturner()
    end
end
