local tween = require("libraries.tween")
local anim8 = require("libraries.anim8")

local player = {}

function player.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {
        x = 640,
        y = 360,
        speed = 400,
        walkSpeed = 400,
        sprintSpeed = 750,
        sprintTween = nil,
        animationSpeed = 1,
        facingRight = false,
    }

    player.spriteSheet = love.graphics.newImage("assets/art/proto-mimi.png")
    player.grid = anim8.newGrid(93, 160, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    
    player.animationFrames = {
        down = player.grid('1-4', 1),
        downLeft = player.grid('1-4', 2),
        left = player.grid('1-4', 3),
        upLeft = player.grid('1-4', 4),
        up = player.grid('1-4', 5)
    }

    player.animations = {
        down = anim8.newAnimation(player.animationFrames.down, 0.2),
        downLeft = anim8.newAnimation(player.animationFrames.downLeft, 0.2),
        left = anim8.newAnimation(player.animationFrames.left, 0.2),
        upLeft = anim8.newAnimation(player.animationFrames.upLeft, 0.2),
        up = anim8.newAnimation(player.animationFrames.up, 0.2)
    }

    player.currentAnimation = player.animations.down
end

function player.update(dt)
    local dx, dy = 0, 0
    local isSprinting = love.keyboard.isDown("lshift")
    local targetSpeed = isSprinting and player.sprintSpeed or player.walkSpeed

    if player.sprintTween == nil or player.sprintTween.target.speed ~= targetSpeed then
        player.sprintTween = tween.new(0.25, player, { speed = targetSpeed }, "inOutSine")
    end

    if player.sprintTween then
        player.sprintTween:update(dt)
    end

    if love.keyboard.isDown("a") then dx = dx - 1 end
    if love.keyboard.isDown("d") then dx = dx + 1 end
    if love.keyboard.isDown("w") then dy = dy - 1 end
    if love.keyboard.isDown("s") then dy = dy + 1 end

    local isMoving = dx ~= 0 or dy ~= 0

    if isMoving then
        local length = math.sqrt(dx * dx + dy * dy)
        player.x = player.x + dx / length * player.speed * dt
        player.y = player.y + dy / length * player.speed * dt

        local direction
        if dy > 0 then
            direction = dx == 0 and "down" or "downLeft"
        elseif dy < 0 then
            direction = dx == 0 and "up" or "upLeft"
        else
            direction = "left"
        end

        player.facingRight = dx > 0 or (dx == 0 and player.facingRight)

        local nextAnimation = player.animations[direction]
        if player.currentAnimation ~= nextAnimation then
            local frame = player.currentAnimation.position
            player.currentAnimation = nextAnimation
            player.currentAnimation:gotoFrame(math.min(frame, #player.currentAnimation.frames)
            )
        end
    end

    if not isMoving then
        player.currentAnimation:gotoFrame(1)
        player.animationSpeed = 1
    else
        player.animationSpeed = math.max(1, player.speed / player.walkSpeed)
        player.currentAnimation:update(dt * player.animationSpeed)
    end

    if player.x < 0 or player.x > love.graphics.getWidth() or player.y < 0 or player.y > love.graphics.getHeight() then
        player.x = math.max(0, math.min(player.x, love.graphics.getWidth()))
        player.y = math.max(0, math.min(player.y, love.graphics.getHeight()))
    end
end

function player.draw()
    local scale = 1.75
    local x = player.x
    if player.facingRight then
        x = x + player.grid.frameWidth * scale
        scale = -scale
    end
    player.currentAnimation:draw(player.spriteSheet, x, player.y, nil, scale, 1.75)
end

return player
