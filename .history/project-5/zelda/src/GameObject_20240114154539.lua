--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    -- whether consumed
    self.consumable = false
    self.consumed = false
    
    -- wheather picked
    self.picked = false

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:update(dt)

end

function GameObject:fire(dt, direction)
    local direction = direction
    
    if direction == 'left' then
        self.x = self.x - PROJECTILE_SPEED * dt
    elseif direction == 'right' then
        self.x = self.x + PROJECTILE_SPEED * dt
    elseif direction == 'down' then
        self.y = self.y - PROJECTILE_SPEED * dt
    elseif direction == 'down' then
        self.y = self.y - PROJECTILE_SPEED * dt
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end