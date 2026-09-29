local game = require("game.init")

function love.load()
    game.load()
end

function love.resize(w, h)
    game.resize(w, h)
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
end