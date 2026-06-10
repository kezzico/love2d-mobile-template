local function Clickable(onclick, children)
  children = children or { }
  local frame = { x = 0, y = 0, w = 0, h = 0 }
  local pressed = false

	return {
    id = "heybar",
    get_frame = function()
      return frame
    end,
    
    onpress = function() 
      pressed = true
    end,
    onrelease = function()
      pressed = false
    end,
    onclick = function() 
      pressed = false
      -- print("bro is so mr moneybags")
      if onclick then onclick() end
    end,

    hit = function(self, x, y)
      return x >= frame.x and x <= frame.x + frame.w and y >= frame.y and y <= frame.y + frame.h
    end,

    draw = function(self, w, h)
      local lx, ly = love.graphics.transformPoint(0, 0)
      frame = { x = lx, y = ly, w = w, h = h }

      for _, child in ipairs(children) do
        child:draw(w, h)
      end

      if pressed then
        love.graphics.push("all")
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0,0,w,h)
        love.graphics.pop()
      end

      table.insert(clickables, self)
    end
	}
end

return Clickable