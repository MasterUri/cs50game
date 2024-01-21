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


    -- create pickbox based on where the player is and facing
    local direction = self.player.direction
    local pickboxX, pickboxY, pickboxWidth, pickboxHeight

    if direction == 'left' then
        pickboxWidth = 8
        pickboxHeight = 16
        pickboxX = self.player.x - pickboxWidth
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
        pickboxY = self.player.y - pickboxHeight
    else
        pickboxWidth = 16
        pickboxHeight = 8
        pickboxX = self.player.x
        pickboxY = self.player.y + self.player.height
    end

    -- separate pickbox for the player
    self.player.playerPickbox = Hitbox(pickboxX, pickboxY, pickboxWidth, pickboxHeight)

    -- pick up facing left, right, ...
    self.player:changeAnimation('pick-' .. self.player.direction)
end

function PlayerPickUpState:enter(params)
    self.player.currentAnimation:refresh()
end

function PlayerPickUpState:pickboxCollides(target)
    return not (self.player.playerPickbox.x + self.player.playerPickbox.width < target.x or self.player.playerPickbox.x > target.x + target.width or
                self.player.playerPickbox.y + self.player.playerPickbox.height < target.y or self.player.playerPickbox.y > target.y + target.height)
end

function PlayerPickUpState:update(dt)

    local pickableObject = nil
    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if self:pickboxCollides(object) and object.pickable then
            pickableObject = object
        end
    end

    -- if we've fully elapsed through one cycle of animation, change back to idle state
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        if pickableObject ~= nil then
            pickableObject.x = pickableObject.x + 32
            self.player:changeState('swing-sword')
        else
            self.player:changeState('idle')
        end
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