function appleRandom()
    applepos = {
        love.math.random(0, 20),
        love.math.random(0, 20)
    }
end

function isApple()
    local pos = snake:pos()
    return pos[1] == applepos[1] and pos[2] == applepos[2]
end

function drawApple()
    gfx.drawTile(applepos[1], applepos[2], {1, 0, 0})
end