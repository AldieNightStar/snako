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
    -- Data for the snake
    snake = snake(10, 10)
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
        -- Here soon will be bonuses etc control mappings
        -- Return true to survive
        return true
    end)

    -- Connect score controls to the snake
    score:connect(function(name)
        -- When it's an apple then we random that apple
        if name == 'apple' then appleRandom() end

        return true
    end)

    -- Load the Apple position
    appleRandom()
end

function love.draw()
    drawApple()
    snake:draw()
end

function love.update()
    if gameOnce:validate(1/gameSpeed) then
        snake:move()
        -- When snake take an apple
        -- Then we add to grow + 1
        -- and also reroll the apple pos
        if isApple() then
            snake.grow = snake.grow + 1
            score:emit('apple')
        end
    end
end
