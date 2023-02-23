gfx = {tileSize=16}

function gfx.drawTile(x, y, color)
    if color == nil then color = {1, 1, 1} end
    local sz = gfx.tileSize
    love.graphics.setColor(unpack(color))
    love.graphics.rectangle('fill', x*sz, y*sz, sz, sz)
end