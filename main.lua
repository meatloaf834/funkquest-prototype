function love.load()
    love.window.setMode(1080,720)

    player = {
        x = 540,
        y = 360,
    }
end

function love.update(dt)
    
end

function love.draw()
    love.graphics.circle("fill", player.x, player.y, 100)
end