local function Navigator(rootView)
  local stack = {}
    
  return {
    reset = function(self)
      local current = stack[#stack]

      if current ~= nil and current.suspend then
        current:suspend()
      end

      while #stack > 1 do
        table.remove(stack)
      end

      local new_top = stack[1]
      if new_top ~= nil and new_top.activate then
        new_top:activate()
      end
    end,

    push = function(self, destination)
      local current = stack[#stack]

      if current ~= nil and current.suspend then
        current:suspend()
      end

      table.insert(stack, destination)

      if destination.activate then
        destination:activate()
      end
    end,
    
    pop = function(self)
      local current = stack[#stack] 

      if current ~= nil and current.suspend then
        current:suspend()
      end

      table.remove(stack)

      local new_top = stack[#stack]
      if new_top ~= nil and new_top.activate then
        new_top:activate()
      end
    end,
    
    draw = function(self, w, h)
      if #stack > 0 then
        stack[#stack]:draw(w, h)
      end
    end
  }
end

return Navigator