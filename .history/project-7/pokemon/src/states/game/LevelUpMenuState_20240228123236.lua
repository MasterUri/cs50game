--[[
    GD50
    Pokemon

    Author: Yurii Moskva
    i_moskva@yahoo.com
]]

LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(pokemon, levelUpStats, onClose)
    self.pokemon = pokemon
    self.onClose = onClose
    local HPIncrease = levelUpStats[0]
    local attackIncrease = levelUpStats[1]
    local defenseIncrease = levelUpStats[2]
    local speedIncrease = levelUpStats[3]

    self.levelUpMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT - 128,
        width = VIRTUAL_WIDTH / 2,
        height = 128,
        selectable = false,
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

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gStateStack:pop()
        self.onClose()
    end
end

function LevelUpMenuState:render()
    self.levelUpMenu:render()
end