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
    self.HPIncrease, self.attackIncrease, self.defenseIncrease, self.speedIncrease = levelUpStats

    if self.HPIncrease == nil then self.HPIncrease = 0 end
    if self.attackIncrease == nil then self.attackIncrease = 0 end
    if self.defenseIncrease == nil then self.defenseIncrease = 0 end
    if self.speedIncrease == nil then self.speedIncrease = 0 end
    
    self.levelUpMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT - 64,
        width = VIRTUAL_WIDTH / 2,
        height = 64,
        items = {
            {
                text = 'HP: ' .. tostring(self.pokemon.HP - self.HPIncrease .. ' + ' .. 
                    self.HPIncrease .. ' = ' .. self.pokemon.HP)
            },
            {
                text = 'Attack: ' .. tostring(self.pokemon.attack - self.attackIncrease .. ' + ' .. 
                    self.attackIncrease .. ' = ' .. self.pokemon.attack)
            },
            {
                text = 'Defense: ' .. tostring(self.pokemon.defense - self.defenseIncrease .. ' + ' .. 
                    self.defenseIncrease .. ' = ' .. self.pokemon.defense)
            },
            {
                text = 'Speed: ' .. tostring(self.pokemon.speed - self.speedIncrease .. ' + ' .. 
                    self.speedIncrease .. ' = ' .. self.pokemon.speed)
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