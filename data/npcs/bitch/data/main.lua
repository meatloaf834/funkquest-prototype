return {
    name = "bitch",
    sprites = {
        idle = love.graphics.newImage("assets/art/bitch-idle.png"),
        talk = love.graphics.newImage("assets/art/bitch-talk.png"),
        jsons = {
            idle = "assets/art/bitch-idle.json",
            talk = "assets/art/bitch-talk.json"
        }
    },
    animations = {
        idle = require("game.util.jsonAnimReader").read(
            love.graphics.newImage("assets/art/bitch-idle.png"),
            "assets/art/bitch-idle.json"
        ),
        talk = require("game.util.jsonAnimReader").read(
            love.graphics.newImage("assets/art/bitch-talk.png"),
            "assets/art/bitch-talk.json"
        )
    }
}