local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/JRL-lav/Scripts/main/U"))()
local Window = Library:CreateWindow("Anime Fighters")

-- // Vars \\ -- 
local plr           = game:GetService("Players").LocalPlayer
local chr           = plr.Character
local rootPart      = chr.HumanoidRootPart
local hum           = chr.Humanoid
local Settings      = {}
local world         = plr.World.Value
local pet           = 1

-- // Farm \\ -- 
local farm = Window:AddFolder("Farm")
local pet_list = {}
for i,v in pairs(workspace.Pets:GetChildren()) do
    if v:IsA("Model") and v:FindFirstChild("Data") and v:FindFirstChild("Data"):FindFirstChild("Owner").Value == plr then 
        table.insert(pet_list, v.Name)
    end
end

local pet_drop = farm:AddList({
    text = "Select Pet",
    values = pet_list,
    callback = function(v)
        Settings["ChosenPet"] = v 
    end
})

farm:AddButton({
    text = "Refresh Pets",
    callback = function()
        pet_drop:RemoveAll()
        for i,v in pairs(workspace.Pets:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("Data") and v:FindFirstChild("Data"):FindFirstChild("Owner").Value == plr then 
                pet_drop:AddValue(v.Name)
            end
        end
    end
})

farm:AddToggle({
    text = "Send All Pets",
    state = false,
    callback = function(v)
        Settings["SendType"] = v
    end
})

local function getMob()
    local dist, mob = math.huge 
    for i,v in pairs(workspace.Worlds[world].Enemies:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then 
            local mag = (rootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).magnitude
            if mag < dist then 
                dist = mag 
                mob = v 
            end
        end
    end
    return mob
end

farm:AddToggle({
    text = "AutoFarm",
    state = false,
    callback = function(v)
        Settings["AutoFarm"] = v
    end
})

spawn(function()
    while wait() do 
        if Settings["AutoFarm"] then 
            local mob_mob = (rootPart.Position - getMob().HumanoidRootPart.Position).magnitude
            if mob_mob < 10 then
                if Settings.SendType == false then 
                    if workspace.Pets[Settings.ChosenPet].Data:FindFirstChild("Attacking").Value ~= getMob().Name then
                        game:GetService("ReplicatedStorage").Remote.SendPet:FireServer(workspace.Pets[Settings.ChosenPet], getMob(), 1)
                    end
                else
                    for i,v in pairs(workspace.Pets:GetChildren()) do
                        if v:IsA("Model") and v:FindFirstChild("Data") and v:FindFirstChild("Data"):FindFirstChild("Owner").Value == plr then 
                            game:GetService("ReplicatedStorage").Remote.SendPet:FireServer(v, getMob(), pet)
                            pet = pet + 1
                        end
                    end
                end
                game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
            else
                pet = 1
                rootPart.CFrame = getMob().HumanoidRootPart.CFrame
            end
        end
    end
end)

-- // Credits \\ -- 
local cred = Window:AddFolder("Credits")
cred:AddLabel({text = "LeadMarker#1219"})
cred:AddButton({text = "Discord", callback = function() setclipboard("discord.gg/8Cj5abGrNv") end})

-- Init
Library:Init()
