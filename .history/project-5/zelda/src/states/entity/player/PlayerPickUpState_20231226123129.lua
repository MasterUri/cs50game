--[[
    GD50
    Legend of Zelda

    Author: Yurii Moskva
]]

PlayerPickUpState = Class{__includes = BaseState}

function PlayerPickUpState:init(player)
    self.entity = player

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPickUpState:update(dt)
    
end