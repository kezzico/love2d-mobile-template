-- base
require 'app.util.table_to_string'
require 'app.util.functional_essentials'
require 'app.util.lua_extensions'
require 'app.util.cache'
require 'app.util.hex_to_color'

-- not sure about this caching thing...
cache = Cache()

-- web
local httpclient = require 'app.web.http_client'

local MainMenu = require 'app.main_menu'

local Navigator = require 'app.gui.navigator'

navigator = Navigator()

function love.load()
  navigator:push(MainMenu())
end

-- on draw, add to these tables to receive events

clickables = {}
draggables = {}
updateables = {}

local n = 1
function love.draw()
  clickables = {}
  draggables = {}
  updateables = {}

  local w, h = love.graphics.getDimensions()
  love.graphics.origin()
  navigator:draw(w, h)
end

function love.quit()
  httpclient:kill()
  print("Thanks for playing. Please play again soon!")
end

function love.update(dt)
  httpclient:poll()

  for i, u in ipairs(updateables) do
    u:update(dt)
  end
end

local mouse_down = false
local mouse_drag = false
local mouse_delta = 0

function love.mousepressed(x, y, button, istouch, presses)
  -- print("🐁 press the mouse down")
  mouse_down = true
  mouse_drag = false

  for i, clickable in ipairs(clickables) do
    -- print("🐁 " .. table_to_string(clickable.id))
    if clickable:hit(x, y) and clickable.onpress then
      clickable:onpress(x, y)
      return
    end
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
  if mouse_down then
    mouse_delta = mouse_delta + math.abs(dx) + math.abs(dy)
  else
    mouse_delta = 0
  end

  if mouse_delta > 5 then
    mouse_drag = true
  end

  for i, draggable in ipairs(draggables) do
    if draggable:hit(x, y) and mouse_down == true then
      draggable:ondrag(dx, dy, x, y)
    end
  end
end

function love.mousereleased(x, y, button, istouch, presses)
  -- print("🐁 release the mouse")
  mouse_down = false
  for i = #clickables, 1, -1 do
    local clickable = clickables[i]
    -- print("🐁 " .. table_to_string(clickable.id))
    if clickable:hit(x, y) and clickable.onclick and mouse_drag == false then
      clickable:onclick(x, y)
      return
    elseif clickable.onrelease then
      clickable:onrelease(x, y)
      -- return
    end
  end
end
