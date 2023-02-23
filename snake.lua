local Snake = {}
local Smt = {__index=Snake}

function Snake:move()
    -- We adding new to head
    -- And remove one from tail
    -- if 'toGrow' is true then no tail removal

    -- Let's find postion by the last element
    local lastPos = self.arr[#self.arr]

    -- Add new cell to relative to direction position
    table.insert(self.arr, {lastPos[1]+self.dir[1], lastPos[2]+self.dir[2]})
    -- If not growing then remove first one cell
    -- If growing then don't remove the cell just turn growing off
    if not self.isGrow then
        table.remove(self.arr, 1) -- remove tail
    else
        self.isGrow = false
    end
end

function Snake:draw()
    -- We will go with each cell and draw the tile
    for _, pos in ipairs(self.arr) do
        gfx.drawTile(pos[1], pos[2])
    end
end

function snake(x, y)
    return setmetatable({
        arr={{x, y}},
        -- Used to indicate that snake will grow
        -- Inital value is true to make snake 2 cells
        toGrow = true,
        -- Direction x, y
        -- used to make snake self move
        dir = {1, 0},
    }, Smt)
end