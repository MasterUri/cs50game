--[[
    GD50
    Super Mario Bros. Remake

    -- PlayState Class --
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    
end

function PlayState:enter(params)
    self.camX = 0
    self.camY = 0
    self.levelNumber = params.levelNumber
    self.levelWidth = 100
    if self.levelNumber > 1 then
        self.levelWidth = self.levelWidth + (self.levelWidth / self.levelNumber)
    end
    self.level = LevelMaker.generate(self.levelWidth, 10)
    self.tileMap = self.level.tileMap
    self.background = math.random(3)
    self.backgroundX = 0

    self.gravityOn = true
    self.gravityAmount = 6

    self.test = nil

    self.player = Player({
        x = self:checkForGround(), y = 0,
        width = 16, height = 20,
        texture = 'green-alien',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerWalkingState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end
        },
        map = self.tileMap,
        level = self.level
    })

    self.player.score = params.score or 0
    self.player.levelNumber = params.levelNumber or 1

    self.steps = 0

    self:spawnEnemies()

    self.player:changeState('falling')
end
--[[
function PlayState:enter(params)
    self.player.score = params.score or 0
    self.player.levelNumber = params.levelNumber or 1
    self.test = self.player.levelNumber
end
]]
function PlayState:checkForGround()
    local mapTiles = self.tileMap.tiles
    local horizontalSpawnPoint = 0

    for k,  collumns in pairs(mapTiles) do
        for l, tiles in pairs(collumns) do
            if tiles.id == TILE_ID_GROUND then
                horizontalSpawnPoint = (tiles.x - 1) * TILE_SIZE
                break
            end
        end
    end
    return horizontalSpawnPoint
end

function PlayState:update(dt)
    Timer.update(dt)

    -- remove any nils from pickups, etc.
    self.level:clear()

    -- update player and level
    self.player:update(dt)
    self.level:update(dt)
    self:updateCamera()

    -- constrain player X no matter which state
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > TILE_SIZE * self.tileMap.width - self.player.width then
        self.player.x = TILE_SIZE * self.tileMap.width - self.player.width
    end

    self.steps = math.floor(self.player.x / 16 + 1)
end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    
    -- translate the entire view of the scene to emulate a camera
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    
    self.level:render()

    self.player:render()
    love.graphics.pop()
    
    -- render score
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(self.player.score), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(tostring(self.player.score), 4, 4)

    --render level Number
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Level: ", VIRTUAL_WIDTH / 4, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Level: ", VIRTUAL_WIDTH / 4 - 1, 4)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(self.levelNumber), VIRTUAL_WIDTH / 4 + 25, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(tostring(self.levelNumber), VIRTUAL_WIDTH / 4 + 24, 4)

    -- render distance
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Steps: ", VIRTUAL_WIDTH / 2, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Steps: ", VIRTUAL_WIDTH / 2 - 1, 4)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print(tostring(self.steps), VIRTUAL_WIDTH / 2 + 20, 5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(tostring(self.steps), VIRTUAL_WIDTH / 2 + 19, 4)


    -- show icon if player has a key
    if self.player.hasKey then
        love.graphics.draw(gTextures['key'], gFrames['key'][self.player.keyColor], VIRTUAL_WIDTH - 21, 5)
    end

    -- debug
    if self.test then
        love.graphics.printf(self.test, 1, 40, VIRTUAL_WIDTH, 'center') 
    end
end

function PlayState:updateCamera()
    -- clamp movement of the camera's X between 0 and the map bounds - virtual width,
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(0,
        math.min(TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH,
        self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

    -- adjust background X to move a third the rate of the camera for parallax
    self.backgroundX = (self.camX / 3) % 256
end

--[[
    Adds a series of enemies to the level randomly.
]]
function PlayState:spawnEnemies()
    -- spawn snails in the level
    for x = 1, self.tileMap.width do

        -- flag for whether there's ground on this column of the level
        local groundFound = false

        for y = 1, self.tileMap.height do
            if not groundFound then
                if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
                    groundFound = true

                    -- random chance, 1 in 20
                    if math.random(20) == 1 then
                        
                        -- instantiate snail, declaring in advance so we can pass it into state machine
                        local snail
                        snail = Snail {
                            texture = 'creatures',
                            x = (x - 1) * TILE_SIZE,
                            y = (y - 2) * TILE_SIZE + 2,
                            width = 16,
                            height = 16,
                            stateMachine = StateMachine {
                                ['idle'] = function() return SnailIdleState(self.tileMap, self.player, snail) end,
                                ['moving'] = function() return SnailMovingState(self.tileMap, self.player, snail) end,
                                ['chasing'] = function() return SnailChasingState(self.tileMap, self.player, snail) end
                            }
                        }
                        snail:changeState('idle', {
                            wait = math.random(5)
                        })

                        table.insert(self.level.entities, snail)
                    end
                end
            end
        end
    end
end