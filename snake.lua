local Snake = {}
local Smt = {__index=Snake}

function Snake:move()
    -- We adding new to head
    -- And remove one from tail
    -- if 'grow' > 0 then no tail removal

    -- Let's find postion by the last element
    local lastPos = self:pos()

    -- Add new cell to relative to direction position
    table.insert(self.arr, {lastPos[1]+self.dir[1], lastPos[2]+self.dir[2]})
    -- If not growing then remove first one cell
    -- If growing then don't remove the cell just turn growing off
    if self.grow < 1 then
        table.remove(self.arr, 1) -- remove tail
    else
        self.grow = self.grow - 1
    end
end

function Snake:pos()
    return self.arr[#self.arr]
end

function Snake:draw()
    -- We will go with each cell and draw the tile
    for id, pos in ipairs(self.arr) do
        if id == #self.arr then
            gfx.drawTile(pos[1], pos[2], {.2, .1, .1})
        else
            local blue  = (id%10)/10
            local green = (id%25)/25 
            gfx.drawTile(pos[1], pos[2], {.1, green, blue})
        end
    end
end

function Snake:collideSelf()
    local pos = self:pos()
    for id, p in ipairs(self.arr) do
        if id == #self.arr then goto _end end
        if p[1] == pos[1] and p[2] == pos[2] then
            return true
        end
        ::_end::
    end
    return false
end

function newSnake(x, y)
    return setmetatable({
        arr={{x, y}},
        -- Used to indicate that snake will grow
        -- Inital value is true to make snake 5 cells
        grow = 5,
        -- Direction x, y
        -- used to make snake self move
        dir = {1, 0},
    }, Smt)
end