local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/JRL-lav/Scripts/main/U"))()
local Window = Library:CreateWindow("Critical Legends")

-- // Vars \\ --
local Settings      = {}

-- // Main \\ --
local main = Window:AddFolder("Main")
main:AddToggle({
    text = "AutoFarm",
    state = false,
    callback = function(v)
        Settings["AutoFarm"] = v
    end
})

main:AddToggle({
    text = "GodMode",
    state = false,
    callback = function(v)
        Settings["GodeMode"] = v
    end
})

main:AddToggle({
    text = "AutoChest",
    state = false,
    callback = function(v)
        Settings["AutoChest"] = v
    end
})

local gm 
gm = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" and tostring(self) == "Damage" and args[1] == game.Players.LocalPlayer.Character and Settings.GodeMode then 
        return nil 
    end

    return gm(self, ...)
end)

spawn(function()
    while wait() do 
        if Settings.AutoFarm then 
            pcall(function()
                for i,v in pairs(workspace.CombatFolder:GetChildren()) do
                    if v:IsA("Folder") and v.Name == game.Players.LocalPlayer.Name and v:FindFirstChild("SwordOrb") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.SwordOrb.Base.CFrame
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while wait() do
        if Settings.AutoChest then 
            pcall(function()
                for i,v in pairs(workspace.Chests:GetChildren()) do
                    if v:IsA("Model") and not v:FindFirstChild("Open") then 
                        firetouchinterest(rootPart, v.Giver, 0)
                        firetouchinterest(rootPart, v.Giver, 1)
                    end
                end
            end)
        end
    end
end)

-- // Teleports \\ -- 
local tele = Window:AddFolder("Teleports")
local area_table = {}
for i,v in pairs(workspace.WorldMap:GetChildren()) do
    if v:IsA("Model") and not table.find(area_table, v.Name) then 
        table.insert(area_table, v.Name)
    end
end

tele:AddList({
    text = "Select Area",
    values = area_table,
    callback = function(v)
        Settings["ChosenArea"] = v
    end
})

tele:AddButton({
    text = "Teleport",
    callback = function()
        pcall(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.WorldMap[Settings.ChosenArea]:GetModelCFrame()
        end)
    end
})

-- // Credits \\ -- 
local cred = Window:AddFolder("Credits")
cred:AddButton({text = "LeadMarker#1219", callback = function() setclipboard("LeadMarker#1219") end})
cred:AddButton({text = "Discord", callback = function() setclipboard("discord.gg/8Cj5abGrNv") end})

-- // Init \\ -- 
Library:Init()
