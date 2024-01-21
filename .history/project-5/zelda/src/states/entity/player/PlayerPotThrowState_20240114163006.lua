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
    -- if self.player.direction == 'left' then
    --     Timer.tween(0.3, {
    --         [self.pot] = {x = self.player.x - TILE_SIZE, y = self.player.y}
    --     })
    -- elseif self.player.direction == 'right' then
    --     Timer.tween(0.3, {
    --         [self.pot] = {x = self.player.x + self.player.width, y = self.player.y}
    --     })
    -- elseif self.player.direction == 'down' then
    --     Timer.tween(0.3, {
    --         [self.pot] = {x = self.player.x, y = self.player.y}
    --     })
    -- end

    self.pot = nil

    self.player.pickedObject = nil
    for k, obj in pairs(self.dungeon.currentRoom.objects) do
        if obj.picked then
            obj.fired = true
        end
    end


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