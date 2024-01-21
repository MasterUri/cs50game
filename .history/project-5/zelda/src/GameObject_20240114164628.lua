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
    
    -- whether picked
    self.picked = false

    -- whether projectile was fired
    self.fired = false

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- direction of the projectile
    self.direction = nil

    -- default empty collision callback
    self.onCollide = function() end

end

function GameObject:getDirection(direction)
    self.direction = direction
end

function GameObject:update(dt)
    
    -- updating projectile movement
    if self.picked and self.fired then
        local speed = PROJECTILE_SPEED
        local distance = TILE_SIZE * 4
        
        -- starting coordinates before the projectile was fired
        local origX = self.x
        local origY = self.y
        
        if self.direction == 'left' then
            self.x = self.x - speed * dt
        elseif self.direction == 'right' then
            self.x = self.x + speed * dt
        elseif self.direction == 'up' then
            self.y = self.y - speed * dt
        elseif self.direction == 'down' then
            self.y = self.y + speed * dt
        end
        
        if self.x >= origX + distance or self.y >= origY + distance then
            speed = 0
        end
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end