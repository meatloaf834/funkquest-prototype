local interactable = {}
interactable.__index = interactable

function interactable.new(x, y, sprite, onInteract)
    return setmetatable({
        x = x,
        y = y,
        sprite = sprite,
        onInteract = onInteract,
        radius = 40
    }, interactable)
end

function interactable:interact(player)
    if self.onInteract then
        self.onInteract(self, player)
    end
end

function interactable:draw()
    if self.sprite then
        love.graphics.draw(self.sprite, self.x, self.y)
    end
end

return interactable