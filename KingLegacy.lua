local quest_mod     = require(game:GetService("ReplicatedStorage").Modules.QuestManager)
local plr           = game.Players.LocalPlayer
local chr           = plr.Character 

function check_quest(quest)
    for i,v in pairs(quest_mod) do 
        if v.Mob == getgenv().mob then 
            return v.Mob
        end
    end
end

function get_quest_level(quest)
    for i,v in pairs(quest_mod) do 
        if v.Mob == quest then 
            return v.Level
        end
    end
end

function get_quest(quest)
    for i,v in pairs(workspace.AllNPC:GetChildren()) do 
        if v:IsA("Model") and v.Name == 'QuestLvl' .. get_quest_level(getgenv().mob) then 
            return v 
        end
    end
end

function click()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(800,800, 0, true, game, 1)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(800,800, 0, false, game, 1)
end

function click_button(button)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(button.AbsolutePosition.X + button.AbsoluteSize.X / 2, button.AbsolutePosition.Y + 50, 0, true, button, 1);
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(button.AbsolutePosition.X + button.AbsoluteSize.X / 2, button.AbsolutePosition.Y + 50, 0, false, button, 1)
end

while getgenv().autofarm do wait()
    pcall(function()
        if plr.PlayerGui.Quest.QuestBoard.Visible == true then 
            for i,v in pairs(workspace.Monster.Mon:GetChildren()) do 
                if v:IsA("Model") and v.Name == check_quest(getgenv().mob) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then 
                    repeat wait()
                        if getgenv().autofarm then 
                            chr.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                            if chr:FindFirstChild("None") == nil then 
                                chr.Humanoid:EquipTool(plr.Backpack:FindFirstChild("None"))
                            end
                            
                            click()
                        end
                    until not getgenv().autofarm or v.Humanoid.Health <= 0 or plr.PlayerGui.Quest.QuestBoard.Visible == false
                end
            end
        else
            if workspace.AllNPC:FindFirstChild(tostring(get_quest(getgenv().mob))) then 
                quest_npc = workspace.AllNPC:FindFirstChild(tostring(get_quest(getgenv().mob)))
                chr.HumanoidRootPart.CFrame = quest_npc:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,-3)
                
                if plr.PlayerGui:FindFirstChild(tostring(get_quest(getgenv().mob))) == nil then 
                    game:GetService("ReplicatedStorage").Remotes.Functions.CheckQuest:InvokeServer( workspace.AllNPC:FindFirstChild(tostring(get_quest(getgenv().mob))))
                else
                    accept_button = plr.PlayerGui:FindFirstChild(tostring(get_quest(getgenv().mob))).Dialogue.Accept
                    click_button(accept_button)
                end
            end
        end
    end)
end
