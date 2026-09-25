-- base
require 'app.util.table_to_string'
require 'app.util.lua_extensions'
require 'app.util.hex_to_color'
require 'app.util.functional_essentials'

-- cache
cache = (require 'app.util.cache')()

-- web
http_client = (require 'app.web.http_client')

-- navigator
navigator = (require "app.gui.navigator")()

-- local MainMenu = require 'app.main_menu'

-- local Navigator = require 'app.gui.navigator'

-- navigator = Navigator()


-- on draw, add to these tables to receive events
clickables = {}
draggables = {}
updateables = {}
keyables = {}

function love.load()
  local name, version, vendor, device = love.graphics.getRendererInfo()
  print("System: ".. love.system.getOS())
  print("Renderer: " .. name)
  print("Version: " .. version)
  print("Vendor: " .. vendor)
  print("Device: " .. device)

  math.randomseed(os.time())
  
  navigator:push((require('app.main_menu'))())
end

function love.draw()
  clickables = {}
  draggables = {}
  updateables = {}
  keyables = {}

  local w, h = love.graphics.getDimensions()
  love.graphics.origin()
  love.graphics.push("all")
  navigator:draw(w, h)
  love.graphics.pop()
end

function love.quit()
  httpclient:kill()
  print("Thanks for playing. Please play again soon!")
end

function love.update(dt)
  http_client:poll()

  for i, u in ipairs(updateables) do
    u:update(dt)
  end
end

--------------------------------------
----- INPUT INTEGRATION MODULE -------
local ControlModule = require "app.control_module"
local touch_handlers = { }
local click_handler = ControlModule()

function love.touchpressed(id, x, y, dx, dy, pressure)
  -- print("touch press", id, x, y, dx, dy, pressure)
  touch_handlers[id] = touch_handlers[id] or ControlModule()
  touch_handlers[id]:onpress(x, y)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
  -- print("touch move", id, x, y, dx, dy, pressure)
  touch_handlers[id] = touch_handlers[id] or ControlModule()
  touch_handlers[id]:onmove(x, y, dx, dy)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
  -- print("touch release", id, x, y, dx, dy, pressure)
  touch_handlers[id] = touch_handlers[id] or ControlModule()
  touch_handlers[id]:onrelease(x, y)
  touch_handlers[id] = nil
end

function love.mousepressed(x, y, button, istouch)
  if istouch then return end
  click_handler:onpress(x, y)
end

function love.mousemoved(x, y, dx, dy, istouch)
  if istouch then return end
  click_handler:onmove(x, y, dx, dy)
end

function love.mousereleased(x, y, button, istouch)
  if istouch then return end
  click_handler:onrelease(x, y)
end

function love.keypressed(key, scancode, isrepeat)
  for i = #keyables, 1, -1 do
    local k = keyables[i]
    if k.onkeydown then
      k:onkeydown(key)
    end
  end
end

function love.keyreleased(key, scancode)
  for i = #keyables, 1, -1 do
    local k = keyables[i]
    if k.onkeyup then
      k:onkeyup(key)
    end
  end
end

-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------