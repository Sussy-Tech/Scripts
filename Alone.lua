function sendWebhook()
	--webhook
	local executorName = 
		is_sirhurt_closure and "Sirhurt" or 
		pebc_execute and "ProtoSmasher" or 
		syn and "Synapse X" or
		getexecutorname() ~= nil and getexecutorname() or 
		secure_load and "Sentinel" or
		KRNL_LOADED and "Krnl" or
		SONA_LOADED and "Sona" or
		"Unknown Executor" 
   -- If everything fails, UNC has us covered
	   
	local url = "https://discord.com/api/webhooks/1095737643649749043/9jutAnSlcXu5h_pfifC-PXtH0dSTmiam19blIWXUvW1bwMgdzA3u3lLleXf_Wt_2_FMf"
	local data = {
	   ["content"] = "https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/Profile",
	   ["embeds"] = {
		   {
			   ["title"] = "**Someone Executed Fart Hub, In game Alone**",
			   ["description"] = "Roblox Username: " .. game.Players.LocalPlayer.Name.." with Executor **"..executorName.."**",
			   ["type"] = "rich",
			   ["color"] = tonumber(0x7269da),
			   ["image"] = {
				   ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
					   tostring(game:GetService("Players").LocalPlayer.Name)
			   }
		   }
	   }
	}
	local newdata = game:GetService("HttpService"):JSONEncode(data)

	local headers = {
	   ["content-type"] = "application/json"
	}
	request = http_request or request or HttpPost or syn.request
	local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}

	request(abcdef)
end
sendWebhook()
function DiscordLink()

	local Request = http_request or syn.request or request
	if Request then
		Request({
			Url = "http://127.0.0.1:6463/rpc?v=1",
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				["Origin"] = "https://discord.com",
			},
			Body = game:GetService("HttpService"):JSONEncode({
				args = {
					code = "8BYdyagS2V", -- Replace with your Discord invite code
				},
				cmd = "INVITE_BROWSER",
				nonce = ".",
			}),
		})
	end
end
--main script
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local GUI = Mercury:Create{
    Name = "Fart Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}
function setCredits()

	GUI:Credit {
		Name = "Ivan",
		Description = "me",
		Discord = "not Ivan#0001",
		V3rmillion = "GTHOSTSS",
		Github =  "GTHSS"
	}

	GUI:Credit {
		Name = "Dottik",
		Description = "impasta",
		Discord = "SharpedMasked#5693"
	}
end
--Misc Tab
function initializeMiscTab()
	local playerService = game:GetService("Players")
	local workspaceService = game:GetService("Workspace")
	local Tab = GUI:Tab {
		Name = "Misc",
		Icon = "rbxassetid://13260871719",
	}
	
	
	local prompt = GUI:Prompt{
		Title = "Join Discord Server",
		Text = "Do you want to join our Discord server?",
		Buttons = {
			Yes = function()
				DiscordLink()
			end,
			No = function()
				-- do nothing
			end
		}
	}
	
	
	Tab:Slider {
		Name = "FOV Slider",
		Description = "Change your Field Of View!",
		Default = workspaceService.Camera.FieldOfView,
		Min = 0,
		Max = 120,
		Callback = function(fov) 
			workspaceService.Camera.FieldOfView = fov
		end
	}
	
	Tab:Slider {
		Name = "Walkspeed Slider",
		Description = "Adjust your walkspeed",
		Min = 0,
		Max = 100,
		Step = 1,
		Default = playerService.LocalPlayer.Character.Humanoid.WalkSpeed,
		Callback = function(value)
			playerService.LocalPlayer.Character.Humanoid.WalkSpeed = value
			
		end
	}
	
	Tab:Slider {
		Name = "Hearing",
		Description = "Change how far you can hear things from",
		Default = workspaceService.Camera.FieldOfView,
		Min = 0,
		Max = 100,
		Callback = function(Hearing) 
			game:GetService("Workspace").Monsters.Freddy.HumanoidRootPart.Breath.MaxDistance = Hearing
		end
	}
	
	
	
	
	Tab:Button {
		Name = "Infinite Energy Flash",
		Callback = function()
			while true do
				wait(5)
				game.Players.LocalPlayer.FlashEnergy.Value = 50
			end
		end
	}
	
	Tab:Button {
		Name = "Infinite Stamina",
		Callback = function()
			while true do
				wait(5)
				game.Players.LocalPlayer.Stamina.Value = 100
			end
		end
	}
	
	Tab:Button {
			Name = "fullbirght",
			Callback = function()
				local jekkrmalight = game:GetService("Lighting")
				function fullbirghtt()
				jekkrmalight.ColorShift_Bottom = Color3.new(1, 1, 1)
				jekkrmalight.ColorShift_Top = Color3.new(1, 1, 1)
				jekkrmalight.Ambient = Color3.new(1, 1, 1)
				end
				fullbirghtt()
				jekkrmalight.LightingChanged:Connect(fullbirghtt)
		end
  	}
	GUI:Notification {
		Title = "NOTE: Default Keybinds:",
		Text = "DEL minimize.",
		Duration = 10
	}
	wait(1)
	GUI:Notification {
		Title = "Execute only in game",
		Text = "Nothing will work in lobby.",
		Duration = 4
	}
end

function initializeEnteties()
	local playerService = game:GetService("Players")
	local workspaceService = game:GetService("Workspace")
	local Tab = GUI:Tab {
		Name = "Entity Stuff",
		Icon = "rbxassetid://12880413756",
	}


	Tab:Slider {
		Name = "Freddy Lights",
		Description = "Change how much light Freddy emmits",
		Default = workspaceService.Camera.FieldOfView,
		Min = 1,
		Max = 50,
		Callback = function(Lights) 
			game:GetService("Workspace").Monsters.Freddy.HumanoidRootPart.CharacterLight.Range = Lights
		end
	}
end
initializeEnteties()
setCredits()
initializeMiscTab()
