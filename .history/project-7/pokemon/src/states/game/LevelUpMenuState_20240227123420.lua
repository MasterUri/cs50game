--[[
    GD50
    Pokemon

    Author: Yurii Moskva
    i_moskva@yahoo.com
]]

LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(pokemon, levelUpStats)
    self.pokemon = pokemon
    -- self.levelUpStats = levelUpStats
    local HPIncrease, attackIncrease, defenseIncrease, speedIncrease = levelUpStats

    if HPIncrease == nil then HPIncrease = 0 end
    if attackIncrease == nil then attackIncrease = 0 end
    if defenseIncrease == nil then defenseIncrease = 0 end
    if speedIncrease == nil then speedIncrease = 0 end
    
    self.levelUpMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT - 64,
        width = VIRTUAL_WIDTH / 2,
        height = 64,
        items = {
            {
                text = 'HP: ' .. tostring(self.pokemon.HP - HPIncrease .. ' + ' .. 
                    HPIncrease .. ' = ' .. self.pokemon.HP)
            },
            {
                text = 'Attack: ' .. tostring(self.pokemon.attack - attackIncrease .. ' + ' .. 
                    attackIncrease .. ' = ' .. self.pokemon.attack)
            },
            {
                text = 'Defense: ' .. tostring(self.pokemon.defense - defenseIncrease .. ' + ' .. 
                    defenseIncrease .. ' = ' .. self.pokemon.defense)
            },
            {
                text = 'Speed: ' .. tostring(self.pokemon.speed - speedIncrease .. ' + ' .. 
                    speedIncrease .. ' = ' .. self.pokemon.speed)
            }
        }
    } 
end

function LevelUpMenuState:update(dt)
    self.levelUpMenu:update(dt)
end

function LevelUpMenuState:render()
    self.levelUpMenu:render()
end