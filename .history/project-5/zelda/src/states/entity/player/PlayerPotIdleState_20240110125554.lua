--[[
    GD50
    Legend of Zelda

    Author: Yurii Moskva
]]

PlayerPotIdleState = Class{__includes = EntityIdleState}

-- function PlayerPotIdleState:init(params)
--     self.entity:changeAnimation('potidle-' .. self.entity.direction)
-- end

function PlayerPotIdleState:enter(params)
    
    self.entity:changeAnimation('potidle-' .. self.entity.direction)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPotIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('pot-walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('pot-throw')
    end
end