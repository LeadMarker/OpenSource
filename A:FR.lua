local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/sannin9000/Ui-Libraries/main/uwuware'))()
local window = library:CreateWindow('A:FR - LeadMarker')

local main = window:AddFolder('Spell Cast')

local SPELL_KEYS = {
    'UP',
    'DOWN',
    'LEFT',
    'RIGHT'
}

local function start_cast()
    local args = {
        [1] = "Input",
        [2] = "C",
        [3] = true
    }
    
    game:GetService("ReplicatedStorage").IO:FireServer(unpack(args))
end

local function end_cast()
    local args = {
        [1] = "Input",
        [2] = "C",
        [3] = false
    }
    
    game:GetService("ReplicatedStorage").IO:FireServer(unpack(args))
end 

local function sign(a)
    local args = {
        [1] = "AltActions",
        [2] = "Sign",
        [3] = a
    }
    
    game:GetService("ReplicatedStorage").IO:FireServer(unpack(args))
end

local SPELL_CAST = {
    ['Push'] = function()
        start_cast()
        sign('LEFT')
        sign('UP')
        sign('DOWN')
        sign('RIGHT')
        end_cast()
    end,
    ['Dash'] = function()
        start_cast()
        sign('LEFT')
        sign('UP')
        sign('RIGHT')
        end_cast()
    end,
    ['Light'] = function()
        start_cast()
        sign('DOWN')
        sign('UP')
        end_cast()
    end,
    ['Portal'] = function()
        start_cast()
        sign('LEFT')
        sign('UP')
        sign('DOWN')
        sign('UP')
        sign('RIGHT')
        end_cast()
    end,
    ['Blood'] = function()
        start_cast()
        sign('DOWN')
        sign('RIGHT')
        sign('UP')
        end_cast()
    end,
    ['Sacred Field'] = function()
        start_cast()
        sign('LEFT')
        sign('DOWN')
        sign('RIGHT')
        sign('DOWN')
        sign('UP')
        end_cast()
    end,
    ['Heal'] = function()
        start_cast()
        sign('RIGHT')
        sign('LEFT')
        sign('UP')
        sign('DOWN')
        end_cast()
    end,
    ['Ground Explosion'] = function()
        start_cast()
        sign('LEFT')
        sign('UP')
        sign('RIGHT')
        sign('DOWN')
        sign('LEFT')
        sign('RIGHT')
        end_cast()
    end,
    ['Tree'] = function()
        start_cast()
        sign('UP')
        sign('LEFT')
        sign('DOWN')
        sign('RIGHT')
        sign('UP')
        end_cast()
    end,
    ['Electricity Slam'] = function()
        start_cast()
        sign('UP')
        sign('LEFT')
        sign('RIGHT')
        sign('DOWN')
        end_cast()
    end,
    ['Flick'] = function()
        start_cast()
        sign('LEFT')
        sign('UP')
        end_cast()
    end
}

for i,v in pairs(SPELL_CAST) do 
    main:AddBind({
        text = i,
        key = 'NONE',
        hold = false,
        callback = function(spell)
            v()
        end
    })
end

library:Init()
