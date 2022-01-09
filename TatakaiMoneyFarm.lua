local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/JRL-lav/Scripts/main/U"))()
local Window = Library:CreateWindow("By LeadMarker#1219")


local plr           = game:GetService("Players").LocalPlayer
local chr           = plr.Character
local rootPart      = chr.HumanoidRootPart
local TweenService  = game:GetService("TweenService")
local noclipE       = false
local antifall      = nil

Window:AddToggle({
    text = "MoneyFarm",
    state = false,
    callback = function(v)
        getgenv().moneyfarm = v 
    end
})

local function noclip()
	for i, v in pairs(chr:GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide == true then
			v.CanCollide = false
		end
	end
end

local function moveto(obj, speed)
    local info = TweenInfo.new(((rootPart.Position - obj.Position).Magnitude)/ speed,Enum.EasingStyle.Linear)
    local tween = TweenService:Create(rootPart, info, {CFrame = obj})

    if not rootPart:FindFirstChild("BodyVelocity") then
        antifall = Instance.new("BodyVelocity", rootPart)
        antifall.Velocity = Vector3.new(0,0,0)
        noclipE = game:GetService("RunService").Stepped:Connect(noclip)
        tween:Play()
    end
 
    tween.Completed:Connect(function()
        antifall:Destroy()
        noclipE:Disconnect()
    end)
end

local function getPoster()
    local dist, post = math.huge 
    for i,v in pairs(game:GetService("Workspace").Quests.Misc.Posters:GetChildren()) do
        if v:IsA("Part") and v.Decal.Transparency == 1 then 
            local mag = (rootPart.Position - v.Position).magnitude 
            if mag < dist then 
                dist = mag 
                post = v 
            end
        end
    end
    return post
end

spawn(function()
    while wait() do 
        if getgenv().moneyfarm then 
            pcall(function()
                if chr:FindFirstChild("Quest") == nil then 
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Quest")
                else
                    local quest = chr.PreviousQuest.Value
                    if quest == "Delivery" then 
                        for i,v in pairs(game:GetService("Workspace").Quests.QuestLocations.Delivery:GetChildren()) do
                            if v.BillboardGui.Enabled == true then 
                                moveto(v.CFrame, 50) 
                            end
                        end
                    elseif quest == "Poster" then 
                        local postmag = (rootPart.Position - getPoster().Position).magnitude 
                        if postmag <= 8 then 
                            fireclickdetector(getPoster().ClickDetector)
                        else
                            moveto(getPoster().CFrame * CFrame.new(0,0,0), 50)
                        end
                    elseif quest == "Cat" then 
                        for i,v in pairs(game:GetService("Workspace").Quests.QuestLocations.Cat:GetChildren()) do
                            if v.BillboardGui.Enabled == true then 
                                moveto(v.CFrame, 50) 
                            end
                        end
                    end
                end
            end)
        end
    end
end)

Library:Init()
