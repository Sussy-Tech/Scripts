function SendMessage(url, playerUserId)
    local req = request or (syn and syn.request) or (http and http.request) or http_request
    if not req then error("not supported retard") end
    local response = req({
        Url = url,
        Method = "POST"
    })

    print("Sent")
end

local player = game.Players.LocalPlayer
local url = "http://laptop.sussy.dev:7032/count/add/1?plrname=" .. player.UserId .. "&placeid=" .. game.PlaceId
SendMessage(url, player.UserId)

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
wait(0.1)
Notification:Notify(
    {Title = "hi", Description = "im lazy to make this any better and im retarded"},
    {OutlineColor = Color3.fromRGB(100, 100, 100), Time = 10, Type = "default"}
)
wait(0.1)
Notification:Notify(
    {Title = "sex", Description = "sex"},
    {OutlineColor = Color3.fromRGB(100, 100, 100), Time = 2, Type = "default"}
)

local function findClosestGameSeat()
    local character = game.Players.LocalPlayer.Character
    local workspace = game:GetService("Workspace")
    
    local closestSeat = nil
    local closestDistance = math.huge
    
    for _, seat in pairs(workspace:GetDescendants()) do
        if seat:IsA("Seat") and seat.Name == "GameSeat" then
            local seatPosition = seat.Position
            local characterPosition = character:WaitForChild("HumanoidRootPart").Position
            local distance = (seatPosition - characterPosition).Magnitude
            
            if distance < closestDistance then
                closestSeat = seat
                closestDistance = distance
            end
        end
    end
    
    return closestSeat
end

local function teleportToSeatPosition(seat)
    local character = game.Players.LocalPlayer.Character

    if seat and character then
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local targetPosition = seat.Position

        humanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end

while true do
    local closestGameSeat = findClosestGameSeat()
    teleportToSeatPosition(closestGameSeat)
    wait(0.1)
end
