require 'event'
require 'gfx'
require 'snake'
require 'once'
require 'apple'
require 'inputs'

function love.load()
    -- Events for control
    -- Takes string of keys pressed (look at joymap)
    control = event()
    -- Events for score gaining
    -- Takes string 'name' when bonus taken
    -- For example it could be an 'apple'
    score = event()

    -- Event for game over stuff
    -- When snake dies it emits without any parameters
    gameOver = event()

    -- Data for the snake
    snake = newSnake(10, 10)
    gameSpeed = 12
    -- Timing
    gameOnce = once()
    -- Init joystick mapping
    joymap = {
        dpleft="left",
        dpright="right",
        dpup="up",
        dpdown="down",
        a="a",
        b="b",
        start="spec"
    }
    -- Connect controls to the snake
    -- We are using events
    control:connect(function(k)
        -- If game is not under GameOver state
        if not isGameOver then
            -- Here we are mapping directional control
            if k == 'up' then
                snake.dir = {0, -1}
            elseif k == 'down' then
                snake.dir = {0, 1}
            elseif k == 'left' then
                snake.dir = {-1, 0}
            elseif k == 'right' then
                snake.dir = {1, 0}
            end
        else
            -- GAME OVER state
            if k == 'a' then
                -- This will completely reset the game
                love.load()
            end
        end
        -- Return true to survive
        return true
    end)

    -- Connect score controls to the snake
    score:connect(function(name)
        -- When it's an apple then we random that apple and grow the snake
        if name == 'apple' then
            appleRandom()
            snake.grow = snake.grow + 1
        end

        return true
    end)

    -- Connect to game over event
    -- When GameOver event will happen we will set isGameOver to true
    -- Event has no arguments as no sense for them
    gameOver:connect(function()
        -- Change the state
        isGameOver = true
        -- To make function survive
        return true
    end)

    -- Load the Apple position
    appleRandom()

    -- Game over state
    isGameOver = false
end

function love.draw()
    snake:draw()
    drawApple()
    -- Draw text if Game Over state
    if isGameOver then
        love.graphics.scale(2, 2)
        love.graphics.print("Game Over", 0, 0)
    end
end

function love.update()
    if gameOnce:validate(1/gameSpeed) then
        -- If game is not under the Game Over state
        if not isGameOver then
            snake:move()
            -- When snake take an apple
            -- Then we add to grow + 1
            -- and also reroll the apple pos
            if isApple() then
                score:emit('apple')
            end
            -- Check that Snake is colliding or not
            -- If collide then we stop the game, saying "Game over" TODO
            if snake:collideSelf() then
                gameOver:emit()
            end
        end
    end
end
