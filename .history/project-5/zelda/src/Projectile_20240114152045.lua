--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(projectile, dungeon, direction)

    self.direction = direction
    self.projectile = projectile
    self.dungeon = dungeon
    self.fire = false

end

function Projectile:update(dt)
    if self.fire then
        if self.direction == 'left' then
            self.projectile.x = self.projectile.x - PROJECTILE_SPEED * dt
        elseif self.direction == 'right' then
            self.projectile.x = self.projectile.x + PROJECTILE_SPEED * dt
        elseif self.direction == 'down' then
            self.projectile.y = self.projectile.y - PROJECTILE_SPEED * dt
        elseif self.direction == 'down' then
            self.projectile.y = self.projectile.y - PROJECTILE_SPEED * dt
        end
    end
end

function Projectile:render()

end