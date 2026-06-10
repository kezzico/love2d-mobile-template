    -- local scroll_example = ScrollView(scroll_state, function(scrollview, score, index)
    --     local cell = scrollview:dequeue_cell("example_cell")

    --     if cell == nil then
    --         cell = ExampleCell()
    --     end

    --     cell.state.text = "ejemplo"

    --     return cell            
    -- end)

-- local function ExampleCell()
--     local self = { }

--     self.reuseIdentifier = "example_cell"

--     self.state = {
--         text = "",
--     }

--     local view = TextView(self.state)

--     self.draw = function(self, w, h)
--         view:draw(w, h)
--     end

--     return self
-- end

local function ScrollView(scroll_state, cellForRow) 
  local frame = { x = 0, y = 0, w = 0, h = 0 }

  scroll_state.offset = scroll_state.offset or 0
  scroll_state.velocity = scroll_state.velocity or 0
  scroll_state.height = 0

  local cell_queue = { }

  return {
    dequeue_cell = function(self, reuseIdentifier)
      if #cell_queue > 0 then
        local cell = table.remove(cell_queue, 1)
        return cell
      end

      return nil
    end,

    hit = function(self, x, y)
      return x >= frame.x and x <= frame.x + frame.w and y >= frame.y and y <= frame.y + frame.h
    end,

    ondrag = function(self, dx, dy)
      scroll_state.velocity = dy 
    end,

    update = function(self, dt)
      local last_cell_height = scroll_state.heights[#scroll_state.heights] or 1

      local overscroll = 0
      if scroll_state.offset > scroll_state.height - last_cell_height then
        overscroll = scroll_state.offset - scroll_state.height
      elseif scroll_state.offset < 0 then
        overscroll = scroll_state.offset
      end

      local min_velocity = 2
      if math.abs(scroll_state.velocity) > min_velocity then
        local inertia = 0.1

        scroll_state.velocity = scroll_state.velocity * inertia ^ dt
      else
        scroll_state.velocity = 0
      end

      if math.abs(overscroll) > 0 then
        local stiffness = 1
        local damping = 10
        local spring_force = overscroll * stiffness
        local damping_force = -scroll_state.velocity * damping
        local acceleration = spring_force + damping_force
        scroll_state.velocity = scroll_state.velocity + acceleration * dt
      end

      scroll_state.offset = scroll_state.offset - scroll_state.velocity
    end,

    draw = function(self, w, h)
      if h < 0 then return end
      local lx, ly = love.graphics.transformPoint(0, 0)
      frame = { x = lx, y = ly, w = w, h = h}

      -- TODO: support multiple cell heights lol
      local child_height = scroll_state.heights[1]
      scroll_state.height = math.max(child_height * #scroll_state.items - h, 0)

      local start_index = math.max(1, math.floor(scroll_state.offset / child_height) + 1)
      local end_index = math.min(math.ceil((scroll_state.offset + h) / child_height), #scroll_state.items)
      
      -- recycle cells for best scroll performance
      local cells_for_reuse = { }

      -- setScissor uses screen coordinates. it does not respond to transformations
      love.graphics.setScissor(lx, ly, w, h)

      for i=start_index,end_index do
        local cell = cellForRow(self, scroll_state.items[i], i)
        table.insert(cells_for_reuse, cell)

        love.graphics.push()
        love.graphics.translate(0, (i - 1) * child_height - scroll_state.offset)
        cell:draw(w, child_height)
        love.graphics.pop()
      end
      love.graphics.setScissor()

      cell_queue = cells_for_reuse

      -- table.insert(clickables, self)
      table.insert(draggables, self)
      table.insert(updateables, self)
    end
  }

end

return ScrollView