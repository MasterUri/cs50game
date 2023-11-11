Powerups = Class{}

function Powerups:init(type)
    
    self.width = 16
    self.height = 16

    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 8

    self.dy = 100

    self.inPlay = false

    self.type = type

    self.sound = false
end

function Powerups:collides(target)

    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    return true
end

function Powerups:update(dt)

    self.y = self.y + self.dy * dt

end

function Powerups:render()

    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.type], 
        self.x, self.y)
end