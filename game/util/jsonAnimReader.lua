local json = require("libraries.json")
local jsonAnimReader = {}

function jsonAnimReader.read(image, jsonFilePath)
    local rawData, readError = love.filesystem.read(jsonFilePath)
    assert(rawData, readError)

    local data = json.decode(rawData)
    local quads = {}

    for _, frameData in ipairs(data.frames) do
        local frame = frameData.frame

        quads[#quads + 1] = love.graphics.newQuad(
            frame.x, frame.y, frame.w, frame.h,
            image:getDimensions()
        )
    end

    return quads
end

return jsonAnimReader