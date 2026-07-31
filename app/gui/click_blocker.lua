local function ClickBlocker()
    local self = {}

    self.id = "click_blocker"
    self.frame = {
        x = 0,
        y = 0,
        w = 0,
        h = 0
    }

    self.ondrag = function()
        return true
    end
    self.onpress = function()
    end
    self.onrelease = function()
    end
    self.onclick = function()
        -- print("click blocked")
    end

    self.hit = function(self, x, y)
        return x >= self.frame.x and x <= self.frame.x + self.frame.w and y >= self.frame.y and y <= self.frame.y + self.frame.h
    end

    self.draw = function(self, w, h)
        local lx, ly = love.graphics.transformPoint(0, 0)
        self.frame = {
            x = lx,
            y = ly,
            w = w,
            h = h
        }

        table.insert(clickables, self)
        table.insert(draggables, self)

    end
    return self
end

return ClickBlocker