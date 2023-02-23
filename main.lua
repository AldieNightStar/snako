require 'event'
require 'gfx'
require 'snake'
require 'once'

function love.load()
    -- Events for control
    -- Takes string of keys pressed (look at joymap)
    control = event()
    -- Events for score gaining
    -- Takes int when bonus taken
    -- By default 1 is a simple 'apple'
    score = event()
    -- Data for the snake
    snake = snake(10, 10)
    gameSpeed = 4
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
end

function love.draw()
    snake:draw()
end

function love.update()
    if gameOnce:validate(1/gameSpeed) then
        snake:move()
    end
end

----------------------
-- Inputs
----------------------

-- Joysticks
function love.gamepadpressed(joystick, button)
    -- Curently no sense which joystick
    -- We use buttons from all of them (FIXME)
    -- button could be: dpleft, dpright, dpup, dpdown, a, b
    control:emit(joymap[button])
end