local tween = require("libraries.tween")

local player = {}

function player.load()
    player = {
        x = 640,
        y = 360,
        speed = 500,
        walkSpeed = 500,
        sprintSpeed = 1000,
        sprintTween = nil
    }
end

function player.update(dt)
    local targetSpeed = love.keyboard.isDown("lshift") and player.sprintSpeed or player.walkSpeed

    if player.sprintTween == nil or player.sprintTween.target.speed ~= targetSpeed then
        player.sprintTween = tween.new(0.25, player, { speed = targetSpeed }, "inOutSine")
    end

    if player.sprintTween then
        player.sprintTween:update(dt)
    end

    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end

    if player.x < 0 or player.x > love.graphics.getWidth() or player.y < 0 or player.y > love.graphics.getHeight() then
        player.x = math.max(0, math.min(player.x, love.graphics.getWidth()))
        player.y = math.max(0, math.min(player.y, love.graphics.getHeight()))
    end
end

function player.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", player.x, player.y, 100)
end

return player