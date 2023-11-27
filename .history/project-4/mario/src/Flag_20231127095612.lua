--[[
    GD50
    Super Mario Bros. Remake

    -- Flag Class --

    Author: Yurii Moskva
]]

Flag = Class{__includes = Entity}

function Flag:init(def)
    Entity.init(self, def)
end

function FlagPole:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
        math.floor(self.x) + 8, math.floor(self.y) + 24)
end

function Flag:render()
    love.graphics.draw(gTextures[self.flgTexture], gFrames[self.flagTexture][self.currentAnimation:getCurrentFrame()],
        math.floor(self.x) + 8, math.floor(self.y) + 8)
end