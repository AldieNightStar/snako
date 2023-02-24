function appleRandom()
    applepos = {
        love.math.random(gameBounds.x+1, gameBounds.x + gameBounds.w-1),
        love.math.random(gameBounds.y+1, gameBounds.y + gameBounds.h-1),
    }
end

function isApple()
    local pos = snake:pos()
    return pos[1] == applepos[1] and pos[2] == applepos[2]
end

function drawApple()
    gfx.drawTile(applepos[1], applepos[2], {1, 0, 0})
end