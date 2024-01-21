--[[
    GD50
    Legend of Zelda

    Author: Yurii Moskva
]]

PlayerPotThrowState = Class{__includes = BaseState}

function PlayerPotThrowState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 8
end