local game = {}

local Project = require("project")

local init = {
    player = require("game.player.movement")
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

    for i, v in pairs(init) do
        if v.load then
            v.load()
        end
    end
end

function game.resize(w, h)
    Project.width = math.max(1, w)
    Project.height = math.max(1, h)
end

function game.update(dt)
    for i, v in pairs(init) do
        if v.update then
            v.update(dt)
        end
    end
end

function game.draw()
    for i, v in pairs(init) do
        if v.draw then
            v.draw()
        end
    end
end

return game