--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)

    -- create pickbox based on where the player is and facing
    local direction = self.direction
    local pickboxX, pickboxY, pickboxWidth, pickboxHeight

    if direction == 'left' then
        pickboxWidth = 16
        pickboxHeight = 16
        pickboxX = self.x - pickboxWidth
        pickboxY = self.y + 2
    elseif direction == 'right' then
        pickboxWidth = 16
        pickboxHeight = 16
        pickboxX = self.x + self.width
        pickboxY = self.y + 2
    elseif direction == 'up' then
        pickboxWidth = 16
        pickboxHeight = 16
        pickboxX = self.x
        pickboxY = self.y - pickboxHeight
    else
        pickboxWidth = 16
        pickboxHeight = 16
        pickboxX = self.x
        pickboxY = self.y + self.height
    end

    -- separate pickbox for the player
    self.playerPickbox = Hitbox(pickboxX, pickboxY, pickboxWidth, pickboxHeight)
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:pickboxCollides(target)
    return not (self.playerPickbox.x + self.playerPickbox.width < target.x or self.playerPickbox.x > target.x + target.width or
                self.playerPickbox.y + self.playerPickbox.height < target.y or self.playerPickbox.y > target.y + target.height)
end

function Player:render()
    Entity.render(self)
    
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.printf(self.health, 1, 40, VIRTUAL_WIDTH, 'center')
end