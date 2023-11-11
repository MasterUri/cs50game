--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.ball = params.ball
    self.level = params.level
    self.powerups = {}
    self.hasKey = params.hasKey
    self.hasLockedBrick = false

    self.recoverPoints = params.recoverPoints
    
    -- points when a multiball powerup is spawned
    self.powerPoints = params.powerPoints

    -- points when the paddle grows
    self.growScore = params.growScore

    -- points when key powerup should spawn
    if self.score > 0 then
        self.keyScore = self.score + params.keyScore
    else
        self.keyScore = params.keyScore
    end

    -- create list of balls in game and store the first ball in it
    self.multiBalls = {}
    table.insert(self.multiBalls, self.ball)

    -- give ball random starting velocity
    for j, balls in pairs(self.multiBalls) do
        balls.dx = math.random(-200, 200)
        balls.dy = math. random(-50, -60)
    end

    -- detect if there is a locked brick present on the level 
    for k, brick in pairs(self.bricks)do
        if brick.locked and brick.inPlay then
            self.hasLockedBrick = true
        end
    end
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    -- update positions based on velocity
    self.paddle:update(dt)

    -- update each ball in balls table
    for j, balls in pairs(self.multiBalls) do
        balls:update(dt)
    end

    -- detect if powerup is out of screen
    for l, powerup in pairs(self.powerups) do
        if powerup.inPlay then
            powerup:update(dt)

            if powerup.y > VIRTUAL_HEIGHT then
                powerup.inPlay = false
            end
        end
    end

    for j, balls in pairs(self.multiBalls) do
        if balls:collides(self.paddle) then
            -- raise ball above paddle in case it goes below it, then reverse dy
            balls.y = self.paddle.y - 8
            balls.dy = -balls.dy
    
            --
            -- tweak angle of bounce based on where it hits the paddle
            --
    
            -- if we hit the paddle on its left side while moving left...
            if balls.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                balls.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - balls.x))
            
            -- else if we hit the paddle on its right side while moving right...
            elseif balls.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                balls.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - balls.x))
            end
    
            gSounds['paddle-hit']:play()
        end
    end

    -- powerups collide with paddle
    for l, powerup in pairs(self.powerups) do
        if powerup:collides(self.paddle) then

            if powerup.type == 3 then
                
                while (#self.multiBalls < 3) do
                    bl = Ball()
                    bl.skin = math.random(7)
                    bl.x = self.paddle.x + self.paddle.width / 2
                    bl.y = self.paddle.y
                    bl.dx = math.random (-200, 200)
                    bl.dy = math.random (-50, -60)

                    table.insert(self.multiBalls, bl)
                    gSounds['multiball']:play()
                end
            elseif powerup.type == 4 then
                self.hasKey = true
            end

            while (powerup.inPlay) do
                gSounds['powerup-pickup']:play()
                powerup.inPlay = false
            end
            
        end
    end
    
    -- if there is no locked bricks left there will be no keys in posession
    if self.hasLockedBrick == false then
        self.hasKey = false
    end

    -- detect collision across all bricks with the ball
    for k, brick in pairs(self.bricks) do
        for j, balls in pairs(self.multiBalls) do
            -- only check collision if we're in play
            --if brick.inPlay and self.ball:collides(brick) then
            if brick.inPlay and balls:collides(brick) then

                -- add to score
                if brick.locked == false then
                    self.score = self.score + (brick.tier * 200 + brick.color * 25)
                elseif self.hasKey then
                    self.score = self.score + (brick.tier * 200 + 200)
                    self.hasLockedBrick = false
                    brick.inPlay = false
                end

                -- trigger the brick's hit function, which removes it from play
                brick:hit()

                -- if we have enough points, recover a point of health
                if self.score > self.recoverPoints then
                    -- can't go above 3 health
                    self.health = math.min(3, self.health + 1)

                    -- multiply recover points by 2
                    self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)

                    -- play recover sound effect
                    gSounds['recover']:play()
                end

                -- spawn a multiball powerup from the destroyed brick
                if (self.score >= self.powerPoints and #self.multiBalls < 3) then
                    
                    if #self.powerups == 0 then
                        p = Powerups()
                        p.type = 3
                        table.insert(self.powerups, p)
                    else
                        for l, powerup in pairs(self.powerups) do
                            if powerup.type == 3 then 
                                break
                            else
                                p = Powerups()
                                p.type = 3
                                table.insert(self.powerups, p)
                            end
                        end
                    end

                    for l, powerup in pairs(self.powerups) do
                        if powerup.type == 3 and powerup.inPlay == false then
                            powerup.inPlay = true
                            powerup.dy = 100
                            powerup.x = brick.x + 16
                            powerup.y = brick.y + 8
                        end
                    end

                    self.powerPoints = self.score + self.powerPoints
                end
                
                -- spawn key powerup from the middle of the screen
                if (self.score >= self.keyScore and self.hasLockedBrick == true and self.hasKey == false) then
                    
                    if #self.powerups == 0 then
                        p = Powerups()
                        p.type = 4
                        table.insert(self.powerups, p)
                    else
                        for l, powerup in pairs(self.powerups) do
                            if powerup.type == 4 then 
                                break
                            else
                                p = Powerups()
                                p.type = 4
                                table.insert(self.powerups, p)
                            end
                        end

                    end

                    for l, powerup in pairs(self.powerups) do
                        if powerup.type == 4 and powerup.inPlay == false then
                            powerup.inPlay = true
                            powerup.dy = 100
                            powerup.x = VIRTUAL_WIDTH / 2 - 8
                            powerup.y = VIRTUAL_HEIGHT / 2 - 8
                        end
                    end

                    self.keyScore = self.score + self.keyScore
                    
                end

                -- the paddle grows when score is equal or higher than growScore
                if self.score >= self.growScore then
                    if self.paddle.size < 4 then
                        self.paddle.size = self.paddle.size + 1
                        self.paddle.width = self.paddle.width + 32
                        gSounds['paddle-grow']:play()
                    end
                    self.growScore = self.score + self.growScore
                end

                -- go to our victory screen if there are no more bricks left
                if self:checkVictory() then
                    gSounds['victory']:play()

                    gStateMachine:change('victory', {
                        level = self.level,
                        paddle = self.paddle,
                        health = self.health,
                        score = self.score,
                        highScores = self.highScores,
                        ball = self.ball,
                        recoverPoints = self.recoverPoints,
                        powerPoints = self.powerPoints,
                        growScore = self.growScore,
                        keyScore = self.keyScore,
                        hasKey = self.hasKey
                    })
                end

                --
                -- collision code for bricks
                --
                -- we check to see if the opposite side of our velocity is outside of the brick;
                -- if it is, we trigger a collision on that side. else we're within the X + width of
                -- the brick and should check to see if the top or bottom edge is outside of the brick,
                -- colliding on the top or bottom accordingly 
                --
                -- left edge; only check if we're moving right, and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                if balls.x + 2 < brick.x and balls.dx > 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    balls.dx = -balls.dx
                    balls.x = brick.x - 8
                
                -- right edge; only check if we're moving left, , and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                elseif balls.x + 6 > brick.x + brick.width and balls.dx < 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    balls.dx = -balls.dx
                    balls.x = brick.x + 32
                
                -- top edge if no X collisions, always check
                elseif balls.y < brick.y then
                    
                    -- flip y velocity and reset position outside of brick
                    balls.dy = -balls.dy
                    balls.y = brick.y - 8
                
                -- bottom edge if no X collisions or top collision, last possibility
                else
                    
                    -- flip y velocity and reset position outside of brick
                    balls.dy = -balls.dy
                    balls.y = brick.y + 16
                end

                -- slightly scale the y velocity to speed up the game, capping at +- 150
                if math.abs(balls.dy) < 150 then
                    balls.dy = balls.dy * 1.02
                end

                -- only allow colliding with one brick, for corners
                break
            end
        end
    end

    -- if ball goes below bounds, revert to serve state and decrease health
    for j, balls in pairs(self.multiBalls) do
        if balls.y >= VIRTUAL_HEIGHT then
            self.health = self.health - 1
            gSounds['hurt']:play()
            
            -- the paddle shrinks if we loose heart
            if self.paddle.size > 1 then
                self.paddle.size = self.paddle.size - 1
                self.paddle.width = self.paddle.width - 32
                gSounds['paddle-shrink']:play()
            end
    
            if self.health == 0 then
                gStateMachine:change('game-over', {
                    score = self.score,
                    highScores = self.highScores
                })
            else
                gStateMachine:change('serve', {
                    paddle = self.paddle,
                    bricks = self.bricks,
                    health = self.health,
                    score = self.score,
                    highScores = self.highScores,
                    level = self.level,
                    recoverPoints = self.recoverPoints,
                    powerPoints = self.powerPoints,
                    growScore = self.growScore,
                    keyScore = self.keyScore,
                    hasKey = self.hasKey
                })
            end
        end
    end


    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    self.paddle:render()

    for j, balls in pairs (self.multiBalls) do
        balls:render()
    end

    for l, powerup in pairs(self.powerups) do
        if powerup.inPlay then
            powerup:render()
        end
    end

    -- indicate if player has a key by showing key icon at the top-mid of the screen
    if self.hasKey and self.hasLockedBrick then
        love.graphics.draw(gTextures['main'], gFrames['key'], VIRTUAL_WIDTH / 2 - 8, 0)
    end

    renderScore(self.score)
    renderHealth(self.health)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end