--[[
    GD50
    Legend of Zelda

    Author: Yurii Moskva
]]

PlayerPotThrowState = Class{__includes = BaseState}

function PlayerPotThrowState:init(player, dungeon)
    
    self.player = player
    self.dungeon = dungeon
    self.pot = player.pickedObject

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- throw left, throw up, etc
    self.player:changeAnimation('throw-' .. self.player.direction)

    gSounds['sword']:play()
end

function PlayerPotThrowState:update(dt)
    
    if self.player.direction == 'left' then
        self.pot.dx = PROJECTILE_SPEED
        self.pot.x = self.pot.x - self.pot.dx
    elseif self.player.direction == 'right' then
        self.pot.dx = PROJECTILE_SPEED
        self.pot.x = self.pot.x + self.pot.dx
    elseif self.player.direction == 'up' then
        self.pot.dy = PROJECTILE_SPEED
        self.pot.y = self.pot.y - self.pot.dy
    elseif self.player.direction == 'down' then
        self.pot.dy = PROJECTILE_SPEED
        self.pot.y = self.pot.y + self.pot.dy
    end

    self.player.pickedObject = nil


    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end
end

function PlayerPotThrowState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end