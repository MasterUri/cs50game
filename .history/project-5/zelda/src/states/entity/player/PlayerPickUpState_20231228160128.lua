--[[
    GD50
    Legend of Zelda

    Author: Yurii Moskva
]]

PlayerPickUpState = Class{__includes = BaseState}

function PlayerPickUpState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite; negated in render function of state
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- pick up facing left, right, ...
    self.player:changeAnimation('pick-' .. self.player.direction)
end

function PlayerPickUpState:enter(params)
    self.player.currentAnimation:refresh()
end

function PlayerPickUpState:update(dt)

     -- check if pickbox collides with any objects in the scene
     for k, object in pairs(self.dungeon.currentRoom.objects) do
        if self:collides(object) and object.pickable then
            self.player:changeAnimation('pick-' .. self.player.direction)
        else
            self.player:changeState('idle')
        end
    end

    -- if we've fully elapsed through one cycle of animation, change back to idle state
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end
end

function PlayerPickUpState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end