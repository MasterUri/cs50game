--[[
    GD50
    Legend of Zelda

    Author: Yurii Moskva
]]

PlayerPickUpState = Class{__includes = BaseState}

function PlayerPickUpState:init(player)
    self.player = player
    self.collidedPot = self.player.collidedObject

    -- render offset for spaced character sprite; negated in render function of state
    self.player.offsetY = 5
    self.player.offsetX = 0

     -- create hitbox based on where the player is and facing
     local direction = self.player.direction
     local pickboxX, pickboxY, pickboxWidth, pickboxHeight
 
     if direction == 'left' then
         pickboxWidth = 8
         pickboxHeight = 16
         pickboxX = self.player.x - hitboxWidth
         pickboxY = self.player.y + 2
     elseif direction == 'right' then
         pickboxWidth = 8
         pickboxHeight = 16
         pickboxX = self.player.x + self.player.width
         pickboxY = self.player.y + 2
     elseif direction == 'up' then
         pickboxWidth = 16
         pickboxHeight = 8
         pickboxX = self.player.x
         pickboxY = self.player.y - hitboxHeight
     else
         pickboxWidth = 16
         pickboxHeight = 8
         pickboxX = self.player.x
         pickboxY = self.player.y + self.player.height
     end
 
     -- separate hitbox for the player's sword; will only be active during this state
     self.playerPickbox = Hitbox(pickboxX, pickboxY, pickboxWidth, pickboxHeight)

    -- pick up facing left, right, ...
    self.player:changeAnimation('pick-' .. self.player.direction)
end

function PlayerPickUpState:enter(params)
    self.player.currentAnimation:refresh()
end

function PlayerPickUpState:update(dt)
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