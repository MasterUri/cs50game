--[[
    GD50
    Legend of Zelda

    Author: Yurii Moskva
]]

PlayerPickUpState = Class{__includes = BaseState}

function PlayerPickUpState:init(player)
    self.player = player
    self.collidedPot = self.player.collidedObject

    -- render offset for spaced character sprite; negated in render function of state
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- store direction the player is facing
    local direction = self.player.direction

    -- pick up facing left, right, ...
    self.player:changeAnimation('pick-' .. self.player.direction)
end

function PlayerPickUpState:update(dt)
    
end