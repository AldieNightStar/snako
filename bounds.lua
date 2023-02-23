local Bounds = {}
local Bmt = { __index = Bounds }

function Bounds:inside(x, y)
    if x <= self.x then return false end
    if y <= self.y then return false end
    if x >= self.x + self.w then return false end
    if y >= self.y + self.h then return false end
    return true
end

function Bounds:draw()
    for x = self.x, self.x + self.w do
        for y = self.y, self.y + self.h do
            if (x == self.x or x == self.x + self.w) or (y == self.y or y == self.y + self.h) then
                gfx.drawTile(x, y, {.5, .5, .5})
            end
        end
    end
end

function bounds(x, y, w, h)
    return setmetatable({ x = x, y = y, w = w, h = h }, Bmt)
end
