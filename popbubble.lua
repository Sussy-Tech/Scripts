if not getconnections then game:GetService("Players").LocalPlayer:Kick("Your exploit is NOT supported: Missing Functions") end
-- Bubble Captcha Auto
game:GetService("Players").LocalPlayer.PlayerGui.CaptchaGui.Captcha.FloatArea.ChildAdded:Connect(function(child)
    task.wait(0.5 + (math.random(1, 5) * 0.1))
    if child:IsA("TextButton") and child.Visible then
        local delay = math.random(5, 10) * 0.1
        task.wait(delay)
        for _, con in getconnections(child.MouseButton1Click) do
            pcall(con.Function)
        end
    end
end)
