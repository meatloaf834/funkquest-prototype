local game = {}

local Tween = require("libraries.tween")
local Project = require("project")

local init = {
    player = require("game.player.player")
}

function game.load()
    love.window.setMode(Project.width, Project.height, {
        resizable = Project.resizable,
        minwidth = Project.minwidth,
        minheight = Project.minheight,
        vsync = Project.vsync,
        centered = true,
        borderless = false,
        fullscreen = false
    })

    love.window.setTitle(Project.title)
    Project.width, Project.height = love.graphics.getWidth(), love.graphics.getHeight()

    init.player.load()
end

function game.resize(w, h)
    Project.width = math.max(1, w)
    Project.height = math.max(1, h)
end

function game.update(dt)
    init.player.update(dt)
end

function game.draw()
    init.player.draw()
end

return game