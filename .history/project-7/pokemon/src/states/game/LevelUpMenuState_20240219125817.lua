--[[
    GD50
    Pokemon

    Author: Yurii Moskva
    i_moskva@yahoo.com
]]

LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(pokemon, levelUpStats)
    self.pokemon = pokemon
    self.levelUpStats = levelUpStats
    
    self.levelUpMenu = Menu {
        x = VIRTUAL_WIDTH - VIRTUAL_WIDTH / 3,
        y = VIRTUAL_HEIGHT - 64,
        width = 64,
        height = 64,
        items = {
            {
                text = 'HP: ' .. tostring(self.pokemon.HP) -- self.levelUpStats.HPIncrease .. ' + ' .. 
                    --self.levelUpStats.HPIncrease .. ' = ' .. self.pokemon.HP)
            },
            {
                text = 'Attack: ' .. tostring(self.pokemon.attack) -- self.levelUpStats.attackIncrease) .. ' + ' .. 
                    --tostring(self.levelUpStats.attackIncrease) .. ' = ' .. tostring(self.pokemon.attack)
            },
            {
                text = 'Defence: ' .. tostring(self.pokemon.defence) -- self.levelUpStats.defenceIncrease) .. ' + ' .. 
                    --tostring(self.levelUpStats.defenceIncrease) .. ' = ' .. tostring(self.pokemon.defence)
            },
            {
                text = 'Speed: ' .. tostring(self.pokemon.speed) -- self.levelUpStats.speedIncrease) .. ' + ' .. 
                    --tostring(self.levelUpStats.speedIncrease) .. ' = ' .. tostring(self.pokemon.speed)
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