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
    self.player.offsetX = 8

    -- throw left, throw up, etc
    self.player:changeAnimation('throw-' .. self.player.direction)

    gSounds['sword']:play()

    self.player:changeState('idle')
end

function PlayerPotThrowState:enter(params)
    
    -- use sword swing sound as throw sound
    gSounds['sword']:stop()
    gSounds['sword']:play()

    -- restart sword swing animation
    self.player.currentAnimation:refresh()
end