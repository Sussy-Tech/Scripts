local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
local ballVelocity = 0	-- Only one ball at once.
game:GetService("Workspace").Balls.ChildAdded:Connect(function(child)
	local isThunk = false
	local velocityTask = task.spawn(function()
		while task.wait(0.5) do
			ballVelocity = child.Velocity.Magnitude
			if child.Velocity.Magnitude <= 0 then
				print("Found thunk ball")
				print("div")
				isThunk = true
				break
			end
		end
	end)

    local trackTask = task.spawn(function()
        local ball = child
        local oldPosition
        local distanceParry = getgenv().ScriptConfig.DistanceBeforeParry or 45.6
        while task.wait() do
        	distanceParry += 0.02
            if string.find(ball.BrickColor.Name:lower(), "red") then
                while task.wait() do
   					
                	if LocalPlayer:DistanceFromCharacter(ball.CFrame.Position) < distanceParry then
                		print("Ball too close! Parrying!")
                		task.wait(0.05)
	            		ReplicatedStorage.Remotes.ParryButtonPress:Fire()
	            		task.wait(0.3)
                		break
            		end
   
   					if (LocalPlayer:DistanceFromCharacter(ball.CFrame.Position) - ((ballVelocity / 2) - 5)) < 0 then
                		print("Ball is faster than the distance the player has of it! Parrying!")
                		task.wait(0.07)
                		ReplicatedStorage.Remotes.ParryButtonPress:Fire()
						task.wait(0.3)
						break
					end
                	
                	--[[
	                	if LocalPlayer:DistanceFromCharacter(ball.CFrame.Position) < ballVelocity or ballVelocity > getgenv().ScriptConfig.BallVelocityBeforeParryAttempt then
		            		print("Ball is coming fast!")
		            		print("Parrying in 0.2 seconds!")
		            		task.wait(0.2)
		            		ReplicatedStorage.Remotes.ParryButtonPress:Fire()
		            		task.wait(0.3)
		            		break
		            	end
	            	]]
                end
            end
        end
    end)
    child.Destroying:Connect(function()
        task.cancel(trackTask)
        task.cancel(velocityTask)
    end)
end)
