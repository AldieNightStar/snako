local directionProtect = {
    up = {"left", "right"},
    down = {"left", "right"},
    left = {"up", "down"},
    right = {"up", "down"},
}

local directionNameToPos = {
    left = {-1, 0},
    right = {1, 0},
    up = {0, -1},
    down = {0, 1}
}

-- Checks is it ok to go that wey
-- Will protect snake from suicide
-- d1, d2 is a string values of 'left', 'right', 'up', 'down'
local function isAllowToDirect(d1, d2)
    local val = directionProtect[d1]
    -- Now val looks like {"left", "right"}
    if val == nil then return false end

    -- Check that d2 value is inside of val
    -- If it's, then it's allowed direction
    for _, v in ipairs(val) do
        if d2 == v then return true end
    end

    -- Return false anyways
    return false
end

-- Gets value looking like {0, -1}
-- And returns it direction like 'left', 'right', 'up', 'down'
local function parseDirection(vec)
    if vec[1] < 0 then return 'left'
    elseif vec[1] > 0 then return 'right'
    elseif vec[2] < 0 then return 'up'
    elseif vec[2] > 0 then return 'down'
    else return 'right' end -- this is default value
end

-- Gets two positions, {1, 0} like objects and return direction (for ex: 'left') to say direction to it
local function relativeDirection(pos1, pos2)
    local p = {pos2[1] - pos1[1], pos2[2] - pos1[2]}
    return parseDirection(p)
end

function initControlFor(controlEvent)
    -- Connect controls to the snake
    -- We are using events
    controlEvent:connect(function(k)
        -- If game is not under GameOver state
        if not isGameOver then
            local snakeDirection = parseDirection(snake.dir)
            -- Here we are mapping directional control
            if k == 'up' and isAllowToDirect(snakeDirection, 'up') then
                snake.dir = {0, -1}
            elseif k == 'down' and isAllowToDirect(snakeDirection, 'down') then
                snake.dir = {0, 1}
            elseif k == 'left' and isAllowToDirect(snakeDirection, 'left') then
                snake.dir = {-1, 0}
            elseif k == 'right' and isAllowToDirect(snakeDirection, 'right') then
                snake.dir = {1, 0}
            elseif k == 'a' then
                -- Autosnake feature
                -- When 'a' is pressed and snake feels an apple then it turns to it automatically
                local newdir = relativeDirection(snake:pos(), applepos)
                if newdir ~= nil and isAllowToDirect(snakeDirection, newdir) then
                    snake.dir = directionNameToPos[newdir]
                end

            end
        else
            -- GAME OVER state
            if k == 'a' then
                -- This will completely reset the game
                initGame()
            end
        end
        -- Return true to survive
        return true
    end)
end