--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(player, dungeon)
    
    self.dungeon = dungeon

    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- check if pickbox collides with any objects in the scene
        for k, object in pairs(self.dungeon.currentRoom.objects) do
            if self:pickboxCollides(object) and object.pickable then
                self.entity:changeState('pick-up')
            end
        end
    end
end