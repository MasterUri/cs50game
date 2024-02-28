--[[
    GD50
    Pokemon

    Author: Yurii Moskva
    i_moskva@yahoo.com
]]

LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(levelUpState)
    self.levelUpState = levelUpState
    
    self.levelUpMenu = Menu {
        x = VIRTUAL_WIDTH - VIRTUAL_WIDTH / 3,
        y = VIRTUAL_HEIGHT - 64,
        width = 64,
        height = 64,
        items = {
            {
                text = 'HP'
            },
            {
                text = 'Attack'
            },
            {
                text = 'Deffence'
            },
            {
                text = 'Speed'
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