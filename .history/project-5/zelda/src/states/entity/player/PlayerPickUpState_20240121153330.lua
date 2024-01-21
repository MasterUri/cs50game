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
    self.playerPickbox = Hitbox(pickboxX, pickboxY, pickboxWidth, pickboxHeight)

    -- pick up facing left, right, ...
    self.player:changeAnimation('pick-' .. self.player.direction)
end

function PlayerPickUpState:enter(params)
    self.player.currentAnimation:refresh()
end

function PlayerPickUpState:pickboxCollides(target)
    return not (self.playerPickbox.x + self.playerPickbox.width < target.x or self.playerPickbox.x > target.x + target.width or
                self.playerPickbox.y + self.playerPickbox.height < target.y or self.playerPickbox.y > target.y + target.height)
end

function PlayerPickUpState:potPickUp(pot)
    Timer.tween(0.3, {
        [pot] = {x = self.player.x, y = self.player.y - (self.player.height / 2)}
    })
end

function PlayerPickUpState:update(dt)

    self.player.pickedObject = nil
    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if self:pickboxCollides(object) and object.type == 'pot' then
            object.picked = true
            self.player.pickedObject = object
            self:potPickUp(self.player.pickedObject)
        end
    end

    -- if we've fully elapsed through one cycle of animation, change back to idle state
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        if self.player.pickedObject ~= nil then
            self.player:changeState('pot-idle')
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
    -- debug for player and pickbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.playerPickbox.x, self.playerPickbox.y,
    --     self.playerPickbox.width, self.playerPickbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end