require 'event'
require 'gfx'
require 'snake'
require 'once'
require 'apple'
require 'inputs'
require 'bounds'
require 'snake_control'

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

    -- Load snake control
    initControlFor(control)

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

    -- Bounds
    gameBounds = bounds(1, 1, 32, 32)
end

function love.draw()
    -- Draw bounds
    gameBounds:draw()

    -- Draw the snake whatever happens
    snake:draw()
    -- Draw text if Game Over state
    if isGameOver then
        love.graphics.setNewFont(64)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Game Over", 0, 0)
    else
        -- Get snake pos for future use
        local snakepos = snake:pos()
        -- if NOT GAME OVER state
        drawApple()
        -- Draw cross liens for head of the snake
        local colorLine = {1, 1, 1, .1}
        gfx.centerTileLine(gameBounds.x, snakepos[2], gameBounds.x + gameBounds.w, snakepos[2], colorLine) -- horizontal line
        gfx.centerTileLine(snakepos[1], gameBounds.y, snakepos[1], gameBounds.y + gameBounds.h, colorLine) -- vertical line
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
            if snake:collideSelf() or not gameBounds:inside(unpack(snake:pos())) then
                gameOver:emit()
            end
        end
    end
end
