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

    -- whether projetile is broken
    self.broken = false

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

function GameObject:getDirection(direction, startingX, styartingY)
    -- getting directions and starting coordinates of the projectile
    self.direction = direction
    self.origX = startingX
    self.origY = styartingY
end

-- check if projectile has hit a wall
function GameObject:hitWallCheck()
    local hitWall = false

    if self.direction == 'left' then
        if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
            hitWall = true
        end
    elseif self.direction == 'right' then
        if self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            hitWall = true
        end
    elseif self.direction == 'up' then
        if self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2 then 
            hitWall = true
        end
    elseif self.direction == 'down' then
        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
            + MAP_RENDER_OFFSET_Y - TILE_SIZE

        if self.y + self.height >= bottomEdge then
            hitWall = true
        end
    end

    if hitWall then
        return true
    else
        return false
    end
end

-- check the projectiles distance
function GameObject:distanceCheck()
    
    local distance = TILE_SIZE * 4
    local reachedDistance = false
    
    if self.direction == 'left' then
        if self.x <= self.origX - distance then
            reachedDistance = true
        end
    elseif self.direction == 'right' then
        if self.x >= self.origX + distance then
            reachedDistance = true
        end
    elseif self.direction == 'up' then
        if self.y <= self.origY - distance then
            reachedDistance = true
        end
    elseif self.direction == 'down' then
        if self.y >= self.origY + distance then
            reachedDistance = true
        end
    end

    if reachedDistance then
        return true
    else
        return false
    end
end

function GameObject:update(dt)
    
    -- updating projectile movement
    if self.picked and self.fired then
        local speed = PROJECTILE_SPEED

        if self.direction == 'left' then
            self.x = self.x - speed * dt
        elseif self.direction == 'right' then
            self.x = self.x + speed * dt
        elseif self.direction == 'up' then
            self.y = self.y - speed * dt
        elseif self.direction == 'down' then
            self.y = self.y + speed * dt
        end
        
        if self:hitWallCheck() or self:distanceCheck() then
            self.broken = true
        end
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end