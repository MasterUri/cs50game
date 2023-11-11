--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local firstPlace = love.graphics.newImage('Medal_Gold.png')
local secondPlace = love.graphics.newImage('Medal_Silver.png')
local thirdPlace = love.graphics.newImage('Medal_Bronze.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    
    if not GAME_PAUSED then
        -- render medal under the score text
        if (self.score > 3 and self.score <= 6) then
            love.graphics.draw(thirdPlace, VIRTUAL_WIDTH / 2 - 54, VIRTUAL_HEIGHT / 2 - 96)
        elseif (self.score > 6 and self.score <= 9) then
            love.graphics.draw(secondPlace, VIRTUAL_WIDTH / 2 - 54, VIRTUAL_HEIGHT / 2 - 96)
        elseif (self.score > 9) then
            love.graphics.draw(firstPlace, VIRTUAL_WIDTH / 2 - 54, VIRTUAL_HEIGHT / 2 - 96)
        end

        -- simply render the score to the middle of the screen
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

        love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
    end
end