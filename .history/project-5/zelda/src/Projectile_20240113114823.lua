--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(projectile, dungeon, direction)

    self.projectile = projectile
    self.dungeon = dungeon
    self.direction = direction

end

function Projectile:update(dt)
    if self.player.direction == 'left' then
        self.projectile.x = self.projectile.x - PROJECTILE_SPEED * dt
    elseif self.player.direction == 'right' then
        self.projectile.x = self.projectile.x + PROJECTILE_SPEED * dt
    elseif self.player.direction == 'down' then
        self.projectile.y = self.projectile.y - PROJECTILE_SPEED * dt
    elseif self.player.direction == 'down' then
        self.projectile.y = self.projectile.y - PROJECTILE_SPEED * dt
    end
    
end

function Projectile:render()

end