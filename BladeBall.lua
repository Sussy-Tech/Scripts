local LocalPlayer = game:GetService("Players").LocalPlayer
game:GetService("Workspace").Balls.ChildAdded:Connect(function(child)
    local trackTask = task.spawn(function()
        local ball = child
        while task.wait() do
            if string.find(ball.BrickColor.Name:lower(), "red") then
                print("Found parry target")
                while LocalPlayer:DistanceFromCharacter(ball.CFrame.Position)
> getgenv().ScriptConfig.DistanceBeforeParry do
                        task.wait()
                end

                print("Parrying...")

                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                ReplicatedStorage.Remotes.ParryButtonPress:Fire()
                print("Parry attempted")
            end
        end
    end)
    child.Destroying:Connect(function()
        task.cancel(trackTask)
    end)
end)
