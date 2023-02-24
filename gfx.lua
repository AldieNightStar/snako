gfx = {tileSize=20}

local function modColor(color)
    return {color[1]*1.5, color[2]*1.5, color[3]*1.5}
end

function gfx.drawTile(x, y, color)
    if color == nil then color = {1, 1, 1} end
    local sz = gfx.tileSize
    love.graphics.setColor(unpack(modColor(color)))
    love.graphics.rectangle('fill', x*sz, y*sz, sz, sz)
    love.graphics.setColor(unpack(color))
    love.graphics.rectangle('fill', x*sz+1, y*sz+1, sz-1, sz-1)
end

function gfx.centerTileLine(x, y, x2, y2, color)
    if color == nil then color = {1, 1, 1} end
    local sz = gfx.tileSize
    love.graphics.setColor(unpack(color))
    love.graphics.line(x*sz+sz/2, y*sz+sz/2, x2*sz+sz/2, y2*sz+sz/2)
end