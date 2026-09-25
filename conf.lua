function love.conf(t)
    -- local width = 320
    -- local height = 640
    local width = 800
    local height = 400

    -- TODO: correct the font scaling then crank msaa up to 4
    t.window.msaa = 4 
    t.window.title = "Doom Truck"
    t.window.width = width
    t.window.height = height
    t.window.resizable = true
    t.window.vsync = true
    t.window.fullscreen = false
    t.window.minwidth = width
    t.window.minheight = height
    
    -- For mobile
    t.window.fullscreentype = "desktop"
    t.modules.joystick = true
    t.modules.physics = true
    
    -- Enable only what we need
    t.modules.audio = true
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.thread = true
    t.modules.timer = true
    t.modules.touch = true
    t.modules.video = false
    t.modules.window = true
    if love._os == "Android" then 
        t.graphics.renderers = {"opengl"}
    end    
end
