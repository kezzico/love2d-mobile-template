local red = hexToColor(0xFF0000)
local white = hexToColor(0xFFFFFF)
local blue = hexToColor(0x3253FF)
local black = hexToColor(0x000000, 1.0)
local creamy_yellow = hexToColor(0xFFF0E9, 1.0)
local bright_yellow = hexToColor(0xFFB300, 1.0)
local clear = hexToColor(0x0, 0)

return {
    colors = {
        red = red,
        white = white,
        black = black,
        green = hexToColor(0x00AA00, 1),
        blue = blue,

        text = creamy_yellow,
        text_highlight = bright_yellow,
        shadow = black,
        clear = clear,

        menu_background = hexToColor(0x440000, 0.8),
        burger_menu_background = hexToColor(0x610300, 1.0),
        header_background = hexToColor(0x610300, 1.0),
        highlight_background = hexToColor(0x3253FF, 1.0),

        rock_red = hexToColor(0xFF0011),
        rock_orange = hexToColor(0xFFB300),
        rock_white = hexToColor(0xFFF0E9),
        rock_black = hexToColor(0x242424)        

    },

    error_text = {
        color = red, size = 10
    },

    fonts = {
        joystix = cache.font({"assets/fonts/joystix.ttf"})
    },

    music = {
        terryontap = love.audio.newSource("assets/music/terryontap.mp3", "stream"),
    },
    
   buttons = {
        primary = { color = white, backgroundColor = blue, size = 14 },
        secondary = { color = blue, backgroundColor = white, size = 14 },
    },

    sliders = { 
        blue = { color = blue, backgroundColor = hexToColor(0x444444) },
        red = { color = red, backgroundColor = hexToColor(0x444444) }
    }
}